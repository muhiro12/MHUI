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
        @ViewBuilder accessory: @escaping () -> Accessory,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder footer: @escaping () -> Footer
    ) {
        self.title = title
        self.supporting = supporting
        self.accessory = accessory()
        self.content = content()
        self.footer = footer()
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.group + theme.spacing.control) {
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
            .padding(.leading, theme.spacing.inline)

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
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.init(
            title: Text(title),
            supporting: supporting.map { value in
                Text(value)
            },
            accessory: {
                EmptyView()
            },
            content: content,
            footer: {
                EmptyView()
            }
        )
    }
}

public extension MHSectionBlock where Footer == EmptyView {
    /// Creates a section block with accessory content and no footer.
    init(
        _ title: LocalizedStringKey,
        supporting: LocalizedStringKey? = nil,
        @ViewBuilder accessory: @escaping () -> Accessory,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.init(
            title: Text(title),
            supporting: supporting.map { value in
                Text(value)
            },
            accessory: accessory,
            content: content,
            footer: {
                EmptyView()
            }
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

// swiftlint:enable type_contents_order
