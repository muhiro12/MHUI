// swiftlint:disable one_declaration_per_file file_types_order type_contents_order
import SwiftUI

private enum MHScreen {}

private struct MHScreenModifier: ViewModifier {
    private enum Layout {
        static var maxContentWidth: CGFloat {
            CGFloat(Int("640") ?? .zero)
        }

        static var titleCueWidth: CGFloat {
            CGFloat(Int("20") ?? .zero)
        }
    }

    @Environment(\.mhTheme)
    private var theme
    @Environment(\.colorScheme)
    private var colorScheme

    let title: Text?
    let subtitle: Text?
    let header: AnyView?

    func body(content: Content) -> some View {
        ScrollView {
            screenContent(content: content)
        }
        .background(
            theme.resolvedColor(for: .background, in: colorScheme)
                .ignoresSafeArea()
        )
    }
}

public extension View {
    /// Wraps content in the MHUI centered screen layout.
    func mhScreen(
        title: Text? = nil,
        subtitle: Text? = nil
    ) -> some View {
        modifier(
            MHScreenModifier(
                title: title,
                subtitle: subtitle,
                header: nil
            )
        )
    }

    /// Wraps content in the MHUI centered screen layout with a header block.
    func mhScreen<Header: View>(
        title: Text? = nil,
        subtitle: Text? = nil,
        @ViewBuilder header: () -> Header
    ) -> some View {
        modifier(
            MHScreenModifier(
                title: title,
                subtitle: subtitle,
                header: AnyView(header())
            )
        )
    }

    /// Wraps content in the MHUI centered screen layout using localized string keys.
    func mhScreen(
        title: LocalizedStringKey? = nil,
        subtitle: LocalizedStringKey? = nil
    ) -> some View {
        mhScreen(
            title: title.map { Text($0) },
            subtitle: subtitle.map { Text($0) }
        )
    }

    /// Wraps content in the MHUI centered screen layout using localized string keys and a header block.
    func mhScreen<Header: View>(
        title: LocalizedStringKey? = nil,
        subtitle: LocalizedStringKey? = nil,
        @ViewBuilder header: () -> Header
    ) -> some View {
        mhScreen(
            title: title.map { Text($0) },
            subtitle: subtitle.map { Text($0) },
            header: header
        )
    }
}

private extension MHScreenModifier {
    func screenContent(content: Content) -> some View {
        VStack(alignment: .leading, spacing: theme.spacing.section + theme.spacing.control) {
            if showsTitleBlock {
                titleBlock
            }

            if let header {
                header
            }

            content
        }
        .frame(maxWidth: Layout.maxContentWidth, alignment: .leading)
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.horizontal, theme.spacing.screen)
        .padding(.vertical, theme.spacing.screen + theme.spacing.section)
    }

    @ViewBuilder var titleBlock: some View {
        VStack(alignment: .leading, spacing: titleCueSpacing) {
            Rectangle()
                .fill(theme.resolvedColor(for: .accent, in: colorScheme))
                .frame(
                    width: Layout.titleCueWidth,
                    height: titleCueHeight
                )

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
    }

    var showsTitleBlock: Bool {
        title != nil || subtitle != nil
    }

    var titleCueHeight: CGFloat {
        theme.divider.thickness + theme.divider.thickness
    }

    var titleCueSpacing: CGFloat {
        theme.spacing.control - titleCueHeight
    }
}

#Preview("Screen", traits: .fixedLayout(width: 760, height: 900)) {
    VStack(alignment: .leading, spacing: MHTheme.standard.spacing.section) {
        VStack(spacing: 0) {
            LabeledContent("Atmosphere", value: "Calm")
                .labeledContentStyle(.mhKeyValue)
            LabeledContent("Approach", value: "Opinionated")
                .labeledContentStyle(.mhKeyValue)
        }
        .mhGroupedRows()
        .mhSection(
            "Foundation",
            supporting: "Tokens, styles, and composition helpers."
        )

        ContentUnavailableView(
            "No examples yet",
            systemImage: "square.grid.2x2",
            description: Text("Use native SwiftUI views and apply MHUI styling.")
        )
        .mhEmptyStateLayout()
        .mhSurfaceInset()
        .mhSurface()
    }
    .mhScreen(
        title: "MHUI",
        subtitle: "A quiet UI foundation for sibling apps."
    )
    .mhPreviewTint()
}
// swiftlint:enable one_declaration_per_file file_types_order type_contents_order
