import SwiftUI

struct MHSurfaceModifier: ViewModifier {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.mhGlassPolicy)
    private var glassPolicy
    @Environment(\.colorScheme)
    private var colorScheme
    @Environment(\.accessibilityReduceTransparency)
    private var accessibilityReduceTransparency

    let role: MHSurfaceRole

    func body(content: Content) -> some View {
        let shape = RoundedRectangle(
            cornerRadius: theme.cornerRadius.surface,
            style: .continuous
        )
        let style = theme.resolvedSurfaceStyle(
            for: role,
            glassPolicy: glassPolicy,
            reduceTransparency: accessibilityReduceTransparency
        )

        return content
            .background {
                MHSurfaceFill(
                    shape: shape,
                    style: style,
                    theme: theme,
                    colorScheme: colorScheme
                )
            }
            .overlay {
                shape
                    .stroke(
                        theme.resolvedColor(
                            for: style.borderRole ?? .border,
                            in: colorScheme
                        )
                        .opacity(style.borderOpacity),
                        lineWidth: theme.divider.thickness
                    )
            }
    }
}
