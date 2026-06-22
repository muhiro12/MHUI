import SwiftUI

struct MHScreenModifier<Header: View>: ViewModifier {
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

private extension MHScreenModifier {
    var showsTitleBlock: Bool {
        title != nil || subtitle != nil
    }

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
