import SwiftUI

struct MHCueBlock<Content: View>: View {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.colorScheme)
    private var colorScheme

    let style: MHResolvedCueStyle
    let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: style.spacing) {
            Rectangle()
                .fill(
                    theme.resolvedColor(
                        for: style.colorRole,
                        in: colorScheme
                    )
                )
                .frame(
                    width: style.width,
                    height: style.height
                )

            content
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    init(
        style: MHResolvedCueStyle,
        @ViewBuilder content: () -> Content
    ) {
        self.style = style
        self.content = content()
    }
}
