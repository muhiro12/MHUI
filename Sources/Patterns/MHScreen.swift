// swiftlint:disable type_contents_order
import SwiftUI

/// A centered, scrollable screen container for calm non-list layouts.
public struct MHScreen<Header: View, Content: View>: View {
    private enum Layout {
        static var maxContentWidth: CGFloat {
            CGFloat(Int("620") ?? .zero)
        }
    }

    @Environment(\.mhTheme)
    private var theme
    @Environment(\.colorScheme)
    private var colorScheme

    private let title: Text?
    private let subtitle: Text?
    private let header: Header
    private let content: Content

    public init(
        title: Text? = nil,
        subtitle: Text? = nil,
        @ViewBuilder header: () -> Header,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.subtitle = subtitle
        self.header = header()
        self.content = content()
    }

    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section + theme.spacing.control) {
                if title != nil || subtitle != nil {
                    VStack(alignment: .leading, spacing: theme.spacing.group) {
                        if let title {
                            title
                                .mhTextStyle(.screenTitle)
                        }
                        if let subtitle {
                            subtitle
                                .mhTextStyle(.supporting, colorRole: .secondaryText)
                        }
                    }
                }

                if hasHeader {
                    header
                }

                content
            }
            .frame(maxWidth: Layout.maxContentWidth, alignment: .leading)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.horizontal, theme.spacing.screen)
            .padding(.vertical, theme.spacing.screen + theme.spacing.section)
        }
        .background(
            theme.resolvedColor(for: .background, in: colorScheme)
                .ignoresSafeArea()
        )
    }
}
// swiftlint:enable type_contents_order

public extension MHScreen where Header == EmptyView {
    /// Creates a screen without a separate header slot.
    init(
        title: LocalizedStringKey? = nil,
        subtitle: LocalizedStringKey? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.init(
            title: title.map { key in
                Text(key)
            },
            subtitle: subtitle.map { key in
                Text(key)
            },
            header: {
                EmptyView()
            },
            content: content
        )
    }
}

private extension MHScreen {
    var hasHeader: Bool {
        Header.self != EmptyView.self
    }
}

#Preview("Screen", traits: .fixedLayout(width: 760, height: 900)) {
    MHScreen(
        title: "MHUI",
        subtitle: "A quiet UI foundation for sibling apps."
    ) {
        MHSectionBlock(
            "Foundation",
            supporting: "Tokens, primitives, and composition patterns."
        ) {
            MHRowGroup {
                MHKeyValueRow("Atmosphere", value: "Calm")
                MHKeyValueRow("Approach", value: "Opinionated")
            }
        }
        MHEmptyState(
            "No examples yet",
            message: "Use the primitives below to assemble your own screens.",
            symbolSystemName: "square.grid.2x2"
        )
    }
    .preferredColorScheme(.light)
}
