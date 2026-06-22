import SwiftUI

struct MHSurfaceInsetModifier: ViewModifier {
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
        let style = theme.resolvedSurfaceInsetStyle(for: context)

        content
            .padding(.horizontal, style.horizontal)
            .padding(.vertical, style.vertical)
    }
}
