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
        let label = content
            .mhTextStyle(.bodyStrong, colorRole: style.foregroundRole)
            .padding(.horizontal, style.horizontalPadding)
            .padding(.vertical, style.verticalPadding)
            .frame(minHeight: style.minimumHeight)

        return actionSurface(label: label)
            .opacity(isEnabled ? 1 : style.disabledOpacity)
    }

    @ViewBuilder
    private func actionSurface(label: some View) -> some View {
        if let backgroundStyle = style.backgroundStyle,
           backgroundStyle.usesGlass,
           #available(iOS 26, macOS 26, watchOS 26, *) {
            // Include the label in the native effect so its foreground and
            // interactive response belong to the same surface as the glass.
            label
                .glassEffect(
                    backgroundStyle.glass(
                        theme: theme,
                        colorScheme: colorScheme,
                        isEnabled: isEnabled
                    ),
                    in: .capsule
                )
                .contentShape(.capsule)
        } else {
            fallbackSurface(label: label)
                .contentShape(shape)
                .opacity(isPressed ? style.pressedOpacity : 1)
        }
    }

    private func fallbackSurface(label: some View) -> some View {
        label
            .background {
                if let backgroundStyle = style.backgroundStyle,
                   let fillRole = backgroundStyle.fallbackFillRole {
                    shape
                        .fill(
                            theme.resolvedColor(
                                for: fillRole,
                                in: colorScheme
                            )
                            .opacity(backgroundStyle.fallbackFillOpacity)
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
    }
}
