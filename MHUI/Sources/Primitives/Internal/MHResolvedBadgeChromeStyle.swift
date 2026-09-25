import SwiftUI

struct MHResolvedBadgeChromeStyle: Sendable, Equatable {
    static let neutralFillOpacity: Double = 0.06
    static let emphasizedFillOpacity: Double = 0.08

    var textRole: MHTextRole
    var foregroundRole: MHColorRole
    var backgroundStyle: MHResolvedSurfaceStyle
    var horizontalPadding: CGFloat
    var verticalPadding: CGFloat
}

extension MHTheme {
    func resolvedBadgeChromeStyle(
        for style: MHBadgeStyle,
        increasedContrast: Bool
    ) -> MHResolvedBadgeChromeStyle {
        let markerRole = badgeMarkerColorRole(for: style)
        let fillOpacity = style == .neutral
            ? MHResolvedBadgeChromeStyle.neutralFillOpacity
            : MHResolvedBadgeChromeStyle.emphasizedFillOpacity
        let backgroundStyle = MHResolvedSurfaceStyle(
            fillRole: markerRole,
            fillOpacity: fillOpacity,
            borderRole: markerRole,
            borderOpacity: .zero
        )

        return .init(
            textRole: .caption,
            foregroundRole: badgeForegroundColorRole(for: style),
            backgroundStyle: backgroundStyle.outlined(
                minimumOpacity: divider.opacity,
                when: increasedContrast
            ),
            horizontalPadding: spacing.control,
            verticalPadding: spacing.inline
        )
    }

    private func badgeForegroundColorRole(
        for style: MHBadgeStyle
    ) -> MHColorRole {
        switch style {
        case .neutral:
            .secondaryText
        case .accent, .warning, .destructive:
            .primaryText
        }
    }

    private func badgeMarkerColorRole(
        for style: MHBadgeStyle
    ) -> MHColorRole {
        switch style {
        case .neutral:
            .secondaryText
        case .accent:
            .accent
        case .warning:
            .warning
        case .destructive:
            .destructive
        }
    }
}
