import SwiftUI

struct MHBadgeModifier: ViewModifier {
    private static let standardLineLimit = 1

    @Environment(\.mhTheme)
    private var theme
    @Environment(\.colorScheme)
    private var colorScheme
    @Environment(\.dynamicTypeSize)
    private var dynamicTypeSize

    let style: MHBadgeStyle
    let accessibilityLabel: Text?

    private var lineLimit: Int? {
        dynamicTypeSize.isAccessibilitySize
            ? nil
            : Self.standardLineLimit
    }

    func body(content: Content) -> some View {
        let chromeStyle = theme.resolvedBadgeChromeStyle(for: style)
        let shape = RoundedRectangle(
            cornerRadius: theme.cornerRadius.control,
            style: .continuous
        )

        let styledContent = content
            .mhTextStyle(chromeStyle.textRole, colorRole: chromeStyle.foregroundRole)
            .lineLimit(lineLimit)
            .allowsTightening(true)
            .fixedSize(
                horizontal: !dynamicTypeSize.isAccessibilitySize,
                vertical: false
            )
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
                shape
                    .stroke(
                        theme.resolvedColor(
                            for: chromeStyle.backgroundStyle.borderRole,
                            in: colorScheme
                        )
                        .opacity(chromeStyle.backgroundStyle.borderOpacity),
                        lineWidth: theme.divider.thickness
                    )
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
