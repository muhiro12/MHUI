import SwiftUI
private struct MHInputChromeModifier: ViewModifier {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.colorScheme)
    private var colorScheme

    let state: MHFieldState

    func body(content: Content) -> some View {
        let style = theme.resolvedInputChromeStyle(for: state)
        let shape = RoundedRectangle(
            cornerRadius: theme.radius.control,
            style: .continuous
        )

        content
            .padding(.horizontal, style.horizontalPadding)
            .padding(.vertical, style.verticalPadding)
            .background {
                shape
                    .fill(backgroundColor(for: style))
            }
            .overlay {
                shape
                    .stroke(
                        borderColor(for: style),
                        lineWidth: theme.divider.thickness
                    )
            }
            .animation(
                .easeOut(duration: theme.motion.quick),
                value: state
            )
    }
}

private extension MHInputChromeModifier {
    func backgroundColor(
        for style: MHResolvedInputChromeStyle
    ) -> Color {
        theme.resolvedColor(
            for: style.fillRole,
            in: colorScheme
        )
        .opacity(style.fillOpacity)
    }

    func borderColor(
        for style: MHResolvedInputChromeStyle
    ) -> Color {
        theme.resolvedColor(
            for: style.borderRole,
            in: colorScheme
        )
        .opacity(style.borderOpacity)
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
