import SwiftUI
private struct MHInputChromeModifier: ViewModifier {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.mhGlassPolicy)
    private var glassPolicy
    @Environment(\.colorScheme)
    private var colorScheme
    @Environment(\.accessibilityReduceTransparency)
    private var accessibilityReduceTransparency

    let state: MHFieldState

    func body(content: Content) -> some View {
        let style = theme.resolvedInputChromeStyle(
            for: state,
            glassPolicy: glassPolicy,
            reduceTransparency: accessibilityReduceTransparency
        )
        let shape = RoundedRectangle(
            cornerRadius: theme.radius.control,
            style: .continuous
        )

        content
            .padding(.horizontal, style.horizontalPadding)
            .padding(.vertical, style.verticalPadding)
            .background {
                MHSurfaceFill(
                    shape: shape,
                    style: style.backgroundStyle,
                    theme: theme,
                    colorScheme: colorScheme
                )
            }
            .overlay {
                if let borderRole = style.backgroundStyle.borderRole {
                    shape
                        .stroke(
                            theme.resolvedColor(
                                for: borderRole,
                                in: colorScheme
                            )
                            .opacity(style.backgroundStyle.borderOpacity),
                            lineWidth: theme.divider.thickness
                        )
                }
            }
            .animation(
                .easeOut(duration: theme.motion.quick),
                value: state
            )
    }
}

public extension View {
    /// Applies calm MHUI input chrome to text entry controls.
    func mhInputChrome(
        state: MHFieldState = .normal
    ) -> some View {
        modifier(MHInputChromeModifier(state: state))
    }
}
