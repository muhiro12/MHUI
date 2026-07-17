import SwiftUI

private struct MHSemanticColorModifier: ViewModifier {
    enum Application {
        case foreground
        case tint
    }

    @Environment(\.colorScheme)
    private var colorScheme
    @Environment(\.mhTheme)
    private var theme

    let role: MHColorRole
    let application: Application

    @ViewBuilder
    func body(content: Content) -> some View {
        let color = theme.resolvedColor(
            for: role,
            in: colorScheme
        )

        switch application {
        case .foreground:
            content.foregroundStyle(color)
        case .tint:
            content.tint(color)
        }
    }
}

public extension View {
    /// Applies a semantic MHUI color as the foreground style.
    ///
    /// Use this for labels, symbols, and shapes that need a theme-owned color
    /// without also adopting an MHUI text style.
    func mhForegroundStyle(
        _ role: MHColorRole
    ) -> some View {
        modifier(MHSemanticColorModifier(
            role: role,
            application: .foreground
        ))
    }

    /// Applies a semantic MHUI color as the native-control tint.
    ///
    /// Use this for a deliberate local tint exception. The root theme remains
    /// the ordinary tint source for the rest of the app.
    func mhTint(
        _ role: MHColorRole
    ) -> some View {
        modifier(MHSemanticColorModifier(
            role: role,
            application: .tint
        ))
    }
}

#Preview("Semantic Color Application", traits: .sizeThatFitsLayout) {
    @Previewable @State var isEnabled = true

    VStack(alignment: .leading, spacing: MHTheme.standard.spacing.content) {
        Label(
            "Theme-owned warning",
            systemImage: "exclamationmark.triangle"
        )
        .mhForegroundStyle(.warning)

        Toggle("Local control tint", isOn: $isEnabled)
            .mhTint(.accent)
    }
    .padding(MHTheme.standard.spacing.content)
    .mhTheme(.standard)
}
