import SwiftUI

struct MHScreenModifier<Header: View>: ViewModifier {
    @Environment(\.mhTheme)
    private var theme

    let title: Text?
    let subtitle: Text?
    let titlePlacement: MHScreenTitlePlacement
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
            .modifier(MHScreenNavigationTitleModifier(
                title: titlePlacement == .navigation ? title : nil
            ))
        }
    }
}

private extension MHScreenModifier {
    var showsTitleBlock: Bool {
        (titlePlacement == .content && title != nil) || subtitle != nil
    }

    @ViewBuilder
    func screenContent(
        content: Content,
        context: MHAdaptiveLayoutContext
    ) -> some View {
        let style = theme.resolvedScreenChromeStyle(for: context)

        VStack(alignment: .leading, spacing: style.contentSpacing) {
            if showsTitleBlock {
                MHScreenTitleBlock(
                    title: titlePlacement == .content ? title : nil,
                    subtitle: subtitle
                )
            }

            if let header {
                header
            }

            content
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, style.horizontalMargin)
        .padding(.vertical, style.verticalPadding)
    }
}
