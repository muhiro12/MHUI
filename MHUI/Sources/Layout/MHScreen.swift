// swiftlint:disable one_declaration_per_file file_types_order type_contents_order
import SwiftUI

private enum MHScreen {}

private struct MHScreenModifier<Header: View>: ViewModifier {
    @Environment(\.mhTheme)
    private var theme

    let title: Text?
    let subtitle: Text?
    let header: Header?

    func body(content: Content) -> some View {
        MHAdaptiveLayoutScope { context in
            ScrollView {
                screenContent(
                    content: content,
                    context: context
                )
            }
            .background(MHCanvasBackground())
        }
    }
}

public extension View {
    /// Wraps content in the MHUI centered screen layout.
    func mhScreen(
        title: Text? = nil,
        subtitle: Text? = nil
    ) -> some View {
        modifier(
            MHScreenModifier<EmptyView>(
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
                header: header()
            )
        )
    }

    /// Wraps content in the MHUI centered screen layout using localized string keys.
    func mhScreen(
        title: LocalizedStringKey? = nil,
        subtitle: LocalizedStringKey? = nil
    ) -> some View {
        mhScreen(
            title: title.map { title in
                Text(title)
            },
            subtitle: subtitle.map { subtitle in
                Text(subtitle)
            }
        )
    }

    /// Wraps content in the MHUI centered screen layout using localized string keys and a header block.
    func mhScreen<Header: View>(
        title: LocalizedStringKey? = nil,
        subtitle: LocalizedStringKey? = nil,
        @ViewBuilder header: () -> Header
    ) -> some View {
        mhScreen(
            title: title.map { title in
                Text(title)
            },
            subtitle: subtitle.map { subtitle in
                Text(subtitle)
            },
            header: header
        )
    }
}

private extension MHScreenModifier {
    @ViewBuilder
    func screenContent(
        content: Content,
        context: MHAdaptiveLayoutContext
    ) -> some View {
        let style = theme.resolvedScreenChromeStyle(for: context)

        widthLimitedContent(style: style) {
            VStack(alignment: .leading, spacing: style.contentSpacing) {
                if showsTitleBlock {
                    MHScreenTitleBlock(
                        title: title,
                        subtitle: subtitle
                    )
                }

                if let header {
                    header
                }

                content
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.horizontal, style.horizontalMargin)
        .padding(.vertical, style.verticalPadding)
    }

    var showsTitleBlock: Bool {
        title != nil || subtitle != nil
    }

    @ViewBuilder
    func widthLimitedContent<WrappedContent: View>(
        style: MHResolvedScreenChromeStyle,
        @ViewBuilder content: () -> WrappedContent
    ) -> some View {
        if let readableContentWidth = style.readableContentWidth {
            content()
                .frame(maxWidth: readableContentWidth, alignment: .leading)
        } else {
            content()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

// MARK: - Preview

private struct MHScreenPreviewContent: View {
    var body: some View {
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
            subtitle: "Focused development preview for screen chrome and section rhythm."
        )
    }
}

#Preview("Screen", traits: .fixedLayout(width: 760, height: 900)) {
    MHScreenPreviewContent()
        .mhPreviewTint()
}
// swiftlint:enable one_declaration_per_file file_types_order type_contents_order
