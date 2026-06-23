import SwiftUI

struct MHResolvedBadgeChromeStyle: Sendable, Equatable {
    static let neutralFillOpacity: Double = 0.06
    static let emphasizedFillOpacity: Double = 0.08
    static let neutralBorderOpacity: Double = 0.10
    static let emphasizedBorderOpacity: Double = 0.14

    var textRole: MHTextRole
    var foregroundRole: MHColorRole
    var backgroundStyle: MHResolvedGlassBackgroundStyle
    var horizontalPadding: CGFloat
    var verticalPadding: CGFloat
}

extension MHTheme {
    func resolvedBadgeChromeStyle(
        for style: MHBadgeStyle,
        glassPolicy: MHGlassPolicy,
        reduceTransparency: Bool
    ) -> MHResolvedBadgeChromeStyle {
        resolvedBadgeChromeStyle(
            for: style,
            glassPolicy: glassPolicy,
            reduceTransparency: reduceTransparency,
            supportsGlass: MHGlassRuntimeSupport.isAvailable
        )
    }

    func resolvedBadgeChromeStyle(
        for style: MHBadgeStyle,
        glassPolicy: MHGlassPolicy,
        reduceTransparency: Bool,
        supportsGlass: Bool
    ) -> MHResolvedBadgeChromeStyle {
        let foregroundRole = badgeForegroundColorRole(for: style)
        let markerRole = badgeMarkerColorRole(for: style)
        let fillOpacity = style == .neutral
            ? MHResolvedBadgeChromeStyle.neutralFillOpacity
            : MHResolvedBadgeChromeStyle.emphasizedFillOpacity
        let borderOpacity = style == .neutral
            ? MHResolvedBadgeChromeStyle.neutralBorderOpacity
            : MHResolvedBadgeChromeStyle.emphasizedBorderOpacity
        let usesGlass = glassPolicy.resolvesUsesGlass(
            prefersGlass: true,
            supportsGlass: supportsGlass,
            reduceTransparency: reduceTransparency
        )

        return .init(
            textRole: .caption,
            foregroundRole: foregroundRole,
            backgroundStyle: .init(
                usesGlass: usesGlass,
                fallbackFillRole: markerRole,
                fallbackFillOpacity: fillOpacity,
                glassTintRole: usesGlass ? markerRole : nil,
                glassTintOpacity: usesGlass ? fillOpacity : 0,
                isGlassInteractive: false,
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
