import SwiftUI

private struct MHTextStyleModifier: ViewModifier {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.colorScheme)
    private var colorScheme
    @Environment(\.mhUsesNativeRowForeground)
    private var usesNativeRowForeground

    let role: MHTextRole
    let colorRole: MHColorRole

    func body(content: Content) -> some View {
        let style = theme.resolvedTextStyle(
            for: role,
            colorRole: colorRole
        )

        content
            .font(
                style.textStyle.font.font
                    .weight(style.textStyle.weight.fontWeight)
            )
            .fontDesign(style.design)
            .tracking(style.tracking)
            .foregroundStyle(
                theme.resolvedTextForeground(
                    for: style.colorRole,
                    in: colorScheme,
                    usesNativeHierarchy: usesNativeRowForeground
                )
            )
    }
}

public extension View {
    /// Applies MHUI semantic typography and foreground color.
    func mhTextStyle(
        _ role: MHTextRole,
        colorRole: MHColorRole = .primaryText
    ) -> some View {
        modifier(
            MHTextStyleModifier(
                role: role,
                colorRole: colorRole
            )
        )
    }
}
