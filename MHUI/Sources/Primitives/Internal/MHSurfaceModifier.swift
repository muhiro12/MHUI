import SwiftUI

struct MHSurfaceModifier: ViewModifier {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.colorScheme)
    private var colorScheme

    let role: MHSurfaceRole

    func body(content: Content) -> some View {
        let shape = RoundedRectangle(
            cornerRadius: theme.cornerRadius.surface,
            style: .continuous
        )
        let style = theme.resolvedSurfaceStyle(for: role)

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
                            for: style.borderRole,
                            in: colorScheme
                        )
                        .opacity(style.borderOpacity),
                        lineWidth: theme.divider.thickness
                    )
            }
    }
}
