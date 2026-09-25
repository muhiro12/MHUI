import SwiftUI

struct MHResolvedBadgeChromeStyle: Sendable, Equatable {
    static let neutralFillOpacity: Double = 0.06
    static let emphasizedFillOpacity: Double = 0.08
    static let neutralBorderOpacity: Double = 0.10
    static let emphasizedBorderOpacity: Double = 0.14

    var textRole: MHTextRole
    var foregroundRole: MHColorRole
    var backgroundStyle: MHResolvedSurfaceStyle
    var horizontalPadding: CGFloat
    var verticalPadding: CGFloat
}

extension MHTheme {
    func resolvedBadgeChromeStyle(
        for style: MHBadgeStyle
    ) -> MHResolvedBadgeChromeStyle {
        let markerRole = badgeMarkerColorRole(for: style)
        let fillOpacity = style == .neutral
            ? MHResolvedBadgeChromeStyle.neutralFillOpacity
            : MHResolvedBadgeChromeStyle.emphasizedFillOpacity
        let borderOpacity = style == .neutral
            ? MHResolvedBadgeChromeStyle.neutralBorderOpacity
            : MHResolvedBadgeChromeStyle.emphasizedBorderOpacity

        return .init(
            textRole: .caption,
            foregroundRole: badgeForegroundColorRole(for: style),
            backgroundStyle: .init(
                fillRole: markerRole,
                fillOpacity: fillOpacity,
                borderRole: markerRole,
                borderOpacity: borderOpacity
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
