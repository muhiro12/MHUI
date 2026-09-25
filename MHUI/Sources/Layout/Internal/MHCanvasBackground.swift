import SwiftUI

struct MHCanvasBackground: View {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.colorScheme)
    private var colorScheme

    var body: some View {
        MHSurfaceFill(
            shape: Rectangle(),
            style: theme.resolvedCanvasSurfaceStyle(),
            theme: theme,
            colorScheme: colorScheme
        )
        .ignoresSafeArea()
    }
}
