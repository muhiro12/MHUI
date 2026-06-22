import SwiftUI

struct MHBadgeModifier: ViewModifier {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.mhGlassPolicy)
    private var glassPolicy
    @Environment(\.colorScheme)
    private var colorScheme
    @Environment(\.accessibilityReduceTransparency)
    private var accessibilityReduceTransparency

    let style: MHBadgeStyle
    let accessibilityLabel: Text?

    func body(content: Content) -> some View {
        let chromeStyle = theme.resolvedBadgeChromeStyle(
            for: style,
            glassPolicy: glassPolicy,
            reduceTransparency: accessibilityReduceTransparency
        )
        let shape = RoundedRectangle(
            cornerRadius: theme.cornerRadius.control,
            style: .continuous
        )

        let styledContent = content
            .mhTextStyle(chromeStyle.textRole, colorRole: chromeStyle.foregroundRole)
            .lineLimit(1)
            .allowsTightening(true)
            .fixedSize(horizontal: true, vertical: false)
            .padding(.horizontal, chromeStyle.horizontalPadding)
            .padding(.vertical, chromeStyle.verticalPadding)
            .background {
                MHSurfaceFill(
                    shape: shape,
                    style: chromeStyle.backgroundStyle,
                    theme: theme,
                    colorScheme: colorScheme
                )
            }
            .overlay {
                if let borderRole = chromeStyle.backgroundStyle.borderRole {
                    shape
                        .stroke(
                            theme.resolvedColor(
                                for: borderRole,
                                in: colorScheme
                            )
                            .opacity(chromeStyle.backgroundStyle.borderOpacity),
                            lineWidth: theme.divider.thickness
                        )
                }
            }

        return accessibilityAdjustedContent(styledContent)
    }

    @ViewBuilder
    private func accessibilityAdjustedContent<StyledContent: View>(
        _ content: StyledContent
    ) -> some View {
        if let accessibilityLabel {
            content.accessibilityLabel(accessibilityLabel)
        } else {
            content
        }
    }
}
