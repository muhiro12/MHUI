import SwiftUI

struct MHSectionHeaderModifier: ViewModifier {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.mhAdaptiveLayoutContext)
    private var adaptiveLayoutContext
    @Environment(\.horizontalSizeClass)
    private var horizontalSizeClass

    func body(content: Content) -> some View {
        let context = adaptiveLayoutContext.resolved(
            with: horizontalSizeClass,
            threshold: theme.layout.compactWidthThreshold
        )
        let style = theme.resolvedSectionChromeStyle(for: context)

        return MHCueBlock(style: style.cueStyle) {
            content
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.leading, style.leadingInset)
        .padding(.bottom, style.footerTopSpacing)
        .textCase(nil)
    }
}
