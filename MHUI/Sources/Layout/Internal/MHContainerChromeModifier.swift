import SwiftUI

struct MHContainerChromeModifier<Header: View>: ViewModifier {
    @Environment(\.mhTheme)
    private var theme

    let kind: MHContainerChromeKind
    let title: Text?
    let subtitle: Text?
    let header: Header?

    func body(content: Content) -> some View {
        MHAdaptiveLayoutScope { context in
            chromeBody(
                content: content,
                context: context
            )
        }
    }
}

private extension MHContainerChromeModifier {
    var showsTitleBlock: Bool {
        title != nil || subtitle != nil
    }

    func chromeBody(
        content: Content,
        context: MHAdaptiveLayoutContext
    ) -> some View {
        let style = theme.resolvedScreenChromeStyle(for: context)

        return widthLimitedContent(style: style) {
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

                chromeContent(content: content)
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .topLeading
                    )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, style.horizontalMargin)
        .padding(.vertical, style.verticalPadding)
        .background(MHCanvasBackground())
    }

    @ViewBuilder
    func widthLimitedContent<WrappedContent: View>(
        style: MHResolvedScreenChromeStyle,
        @ViewBuilder content: () -> WrappedContent
    ) -> some View {
        if let readableContentWidth = style.readableContentWidth {
            content()
                .frame(
                    maxWidth: readableContentWidth,
                    maxHeight: .infinity,
                    alignment: .topLeading
                )
        } else {
            content()
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .topLeading
                )
        }
    }

    @ViewBuilder
    func chromeContent(
        content: Content
    ) -> some View {
        switch kind {
        case .list:
            content
                .scrollContentBackground(.hidden)
                .listStyle(.plain)
        case .form:
            content
                .scrollContentBackground(.hidden)
        }
    }
}
