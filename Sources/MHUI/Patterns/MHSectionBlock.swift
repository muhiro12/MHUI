// swiftlint:disable type_contents_order
import SwiftUI

/// A titled content block that wraps grouped content in a calm surface.
public struct MHSectionBlock<Accessory: View, Content: View, Footer: View>: View {
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
        VStack(alignment: .leading, spacing: theme.spacing.group) {
            VStack(alignment: .leading, spacing: theme.spacing.inline) {
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
            supporting: supporting.map { value in
                Text(value)
            },
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
            supporting: supporting.map { value in
                Text(value)
            },
            accessory: accessory,
            content: content,
            footer: EmptyView.init
        )
    }
}

private extension MHSectionBlock {
    var hasAccessory: Bool {
        Accessory.self != EmptyView.self
    }

    var hasFooter: Bool {
        Footer.self != EmptyView.self
    }
}

#Preview("Section Block") {
    MHSectionBlock(
        "Rhythm",
        supporting: "Shared section framing without owning app workflow.",
        accessory: {
            MHBadge("v1", style: .accent)
        },
        content: {
            MHRowGroup {
                MHListRow(
                    "Section title",
                    subtitle: "Secondary text stays quiet.",
                    overline: "Pattern"
                )
                MHKeyValueRow("Surface", value: "Wrapped")
            }
        }
    )
    .padding()
}
// swiftlint:enable type_contents_order
