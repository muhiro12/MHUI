// swiftlint:disable one_declaration_per_file file_types_order type_contents_order
import SwiftUI

private enum MHScreen {}

private struct MHScreenModifier: ViewModifier {
    @Environment(\.mhTheme)
    private var theme

    let title: Text?
    let subtitle: Text?
    let header: AnyView?

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
// swiftlint:enable one_declaration_per_file file_types_order type_contents_order
