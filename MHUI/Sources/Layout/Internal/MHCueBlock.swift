import SwiftUI

struct MHCueBlock<Content: View>: View {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.colorScheme)
    private var colorScheme

    let style: MHResolvedCueStyle
    let content: Content

    var body: some View {
        let cueColor = theme.resolvedColor(
            for: style.colorRole,
            in: colorScheme
        )

        switch style.placement {
        case .top:
            VStack(alignment: .leading, spacing: style.spacing) {
                Rectangle()
                    .fill(cueColor)
                    .accessibilityHidden(true)
                    .frame(
                        width: style.length,
                        height: style.thickness
                    )

                content
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        case .leading:
            content
                .frame(
                    maxWidth: .infinity,
                    minHeight: style.length,
                    alignment: .topLeading
                )
                .padding(
                    .leading,
                    style.thickness + style.spacing
                )
                .overlay(alignment: .leading) {
                    Rectangle()
                        .fill(cueColor)
                        .accessibilityHidden(true)
                        .frame(width: style.thickness)
                }
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
