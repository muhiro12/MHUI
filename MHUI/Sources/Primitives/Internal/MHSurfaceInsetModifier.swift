import SwiftUI

struct MHSurfaceInsetModifier: ViewModifier {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.mhAdaptiveLayoutContext)
    private var adaptiveLayoutContext

    func body(content: Content) -> some View {
        let style = theme.resolvedSurfaceInsetStyle(for: adaptiveLayoutContext)

        content
            .padding(.horizontal, style.horizontal)
            .padding(.vertical, style.vertical)
    }
}
