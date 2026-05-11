// swiftlint:disable one_declaration_per_file file_types_order
import SwiftUI

private enum MHBadge {}

private struct MHBadgeModifier: ViewModifier {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.mhGlassPolicy)
    private var glassPolicy
    @Environment(\.colorScheme)
    private var colorScheme
    @Environment(\.accessibilityReduceTransparency)
    private var accessibilityReduceTransparency

    let style: MHBadgeStyle

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

        content
            .mhTextStyle(chromeStyle.textRole, colorRole: chromeStyle.foregroundRole)
            .textCase(.uppercase)
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
    }
}

public extension View {
    /// Applies restrained badge chrome for compact metadata.
    func mhBadge(style: MHBadgeStyle = .neutral) -> some View {
        modifier(MHBadgeModifier(style: style))
    }
}

// MARK: - Preview

#Preview("Badge", traits: .sizeThatFitsLayout) {
    HStack(spacing: MHTheme.standard.spacing.control) {
        ForEach(MHBadgeStyle.allCases, id: \.rawValue) { style in
            Text(LocalizedStringKey(style.rawValue.capitalized))
                .mhBadge(style: style)
        }
    }
    .mhPreviewSurface()
}
// swiftlint:enable one_declaration_per_file file_types_order
