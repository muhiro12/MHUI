// swiftlint:disable type_contents_order
import SwiftUI

/// A titled content block that wraps grouped content in a calm surface.
public struct MHSectionBlock<Accessory: View, Content: View, Footer: View>: View {
    private enum Layout {
        static var headingCueWidth: CGFloat {
            CGFloat(Int("12") ?? .zero)
        }
    }

    @Environment(\.mhTheme)
    private var theme
    @Environment(\.colorScheme)
    private var colorScheme

    private let title: Text
    private let supporting: Text?
    private let accessory: Accessory
    private let content: Content
    private let footer: Footer

    public init(
        title: Text,
        supporting: Text? = nil,
        @ViewBuilder accessory: () -> Accessory,
        @ViewBuilder content: () -> Content,
        @ViewBuilder footer: () -> Footer
    ) {
        self.title = title
        self.supporting = supporting
        self.accessory = accessory()
        self.content = content()
        self.footer = footer()
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.group + theme.spacing.control) {
            headerBlock

            MHSurface {
                content
            }

            if hasFooter {
                footer
                    .foregroundStyle(
                        theme.resolvedColor(
                            for: .secondaryText,
                            in: colorScheme
                        )
                    )
            }
        }
    }
}

public extension MHSectionBlock where Accessory == EmptyView, Footer == EmptyView {
    /// Creates a section block without accessory or footer content.
    init(
        _ title: LocalizedStringKey,
        supporting: LocalizedStringKey? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.init(
            title: Text(title),
            supporting: supporting.map { Text($0) },
            accessory: EmptyView.init,
            content: content,
            footer: EmptyView.init
        )
    }
}

public extension MHSectionBlock where Footer == EmptyView {
    /// Creates a section block with accessory content and no footer.
    init(
        _ title: LocalizedStringKey,
        supporting: LocalizedStringKey? = nil,
        @ViewBuilder accessory: () -> Accessory,
        @ViewBuilder content: () -> Content
    ) {
        self.init(
            title: Text(title),
            supporting: supporting.map { Text($0) },
            accessory: accessory,
            content: content,
            footer: EmptyView.init
        )
    }
}

private extension MHSectionBlock {
    var headerBlock: some View {
        VStack(alignment: .leading, spacing: headerCueSpacing) {
            Rectangle()
                .fill(theme.resolvedColor(for: .accent, in: colorScheme))
                .frame(
                    width: Layout.headingCueWidth,
                    height: headerCueHeight
                )

            VStack(alignment: .leading, spacing: theme.spacing.control) {
                HStack(alignment: .firstTextBaseline, spacing: theme.spacing.control) {
                    title
                        .mhTextStyle(.sectionTitle)
                    Spacer(minLength: theme.spacing.control)
                    if hasAccessory {
                        accessory
                    }
                }
                if let supporting {
                    supporting
                        .mhTextStyle(.supporting, colorRole: .secondaryText)
                }
            }
        }
        .padding(.leading, theme.spacing.inline)
    }

    var headerCueHeight: CGFloat {
        theme.divider.thickness + theme.divider.thickness
    }

    var headerCueSpacing: CGFloat {
        theme.spacing.inline + headerCueHeight
    }

    var hasAccessory: Bool {
        Accessory.self != EmptyView.self
    }

    var hasFooter: Bool {
        Footer.self != EmptyView.self
    }
}

// swiftlint:enable type_contents_order
