import SwiftUI

// swiftlint:disable no_magic_numbers
private struct MHInputChromeModifier: ViewModifier {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.colorScheme)
    private var colorScheme

    let state: MHFieldState

    func body(content: Content) -> some View {
        let shape = RoundedRectangle(
            cornerRadius: theme.radius.control,
            style: .continuous
        )

        content
            .padding(.horizontal, theme.spacing.group)
            .padding(.vertical, theme.spacing.control)
            .background {
                shape
                    .fill(backgroundColor)
            }
            .overlay {
                shape
                    .stroke(
                        borderColor,
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
    var backgroundColor: Color {
        switch state {
        case .normal:
            theme.resolvedColor(for: .surface, in: colorScheme)
        case .focused:
            theme.resolvedColor(for: .surface, in: colorScheme)
        case .invalid:
            theme.resolvedColor(for: .destructive, in: colorScheme)
                .opacity(0.04)
        }
    }

    var borderColor: Color {
        switch state {
        case .normal:
            theme.resolvedColor(for: .border, in: colorScheme)
                .opacity(theme.divider.opacity)
        case .focused:
            theme.resolvedColor(for: .accent, in: colorScheme)
                .opacity(0.24)
        case .invalid:
            theme.resolvedColor(for: .destructive, in: colorScheme)
                .opacity(0.18)
        }
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

#Preview("Input Chrome", traits: .sizeThatFitsLayout) {
    VStack(spacing: MHTheme.standard.spacing.group) {
        TextField("Name", text: .constant(""))
            .mhInputChrome()
        TextField("Focused", text: .constant("Focused"))
            .mhInputChrome(state: .focused)
        TextEditor(text: .constant("Validation message owned by the app."))
            .frame(height: 120)
            .mhInputChrome(state: .invalid)
    }
    .mhPreviewSurface()
}
// swiftlint:enable no_magic_numbers
