import SwiftUI

struct MHActionButtonChromeModifier: ViewModifier {
    let style: MHResolvedActionButtonStyle
    let theme: MHTheme
    let colorScheme: ColorScheme
    let isEnabled: Bool
    let isPressed: Bool

    private var shape: RoundedRectangle {
        RoundedRectangle(
            cornerRadius: theme.cornerRadius.control,
            style: .continuous
        )
    }

    func body(content: Content) -> some View {
        content
            .mhTextStyle(.bodyStrong, colorRole: style.foregroundRole)
            .padding(.horizontal, style.horizontalPadding)
            .padding(.vertical, style.verticalPadding)
            .frame(minHeight: style.minimumHeight)
            .background {
                if let backgroundStyle = style.backgroundStyle {
                    MHSurfaceFill(
                        shape: shape,
                        style: backgroundStyle,
                        theme: theme,
                        colorScheme: colorScheme
                    )
                }
            }
            .overlay {
                if let backgroundStyle = style.backgroundStyle,
                   let borderRole = backgroundStyle.borderRole {
                    shape
                        .stroke(
                            theme.resolvedColor(
                                for: borderRole,
                                in: colorScheme
                            )
                            .opacity(backgroundStyle.borderOpacity),
                            lineWidth: theme.divider.thickness
                        )
                }
            }
            .contentShape(shape)
            .opacity(isEnabled ? 1 : style.disabledOpacity)
            .opacity(isPressed ? style.pressedOpacity : 1)
    }
}
