import SwiftUI

struct MHCanvasBackground: View {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.mhGlassPolicy)
    private var glassPolicy
    @Environment(\.colorScheme)
    private var colorScheme
    @Environment(\.accessibilityReduceTransparency)
    private var accessibilityReduceTransparency

    var body: some View {
        let style = theme.resolvedCanvasSurfaceStyle(
            glassPolicy: glassPolicy,
            reduceTransparency: accessibilityReduceTransparency
        )

        return MHSurfaceFill(
            shape: Rectangle(),
            style: style,
            theme: theme,
            colorScheme: colorScheme
        )
        .ignoresSafeArea()
    }
}
