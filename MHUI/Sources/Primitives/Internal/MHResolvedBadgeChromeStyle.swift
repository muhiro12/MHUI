// swiftlint:disable file_types_order one_declaration_per_file
import SwiftUI

struct MHResolvedBadgeChromeStyle: Sendable, Equatable {
    static let accentFillOpacity: Double = 0.08
    static let accentBorderOpacity: Double = 0.14

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
        reduceTransparency: Bool,
        supportsGlass: Bool = MHGlassRuntimeSupport.isAvailable
    ) -> MHResolvedBadgeChromeStyle {
        let colors = badgeColorRoles(for: style)
        let usesGlass = glassPolicy.resolvesUsesGlass(
            prefersGlass: true,
            supportsGlass: supportsGlass,
            reduceTransparency: reduceTransparency
        )

        return MHResolvedBadgeChromeStyle(
            textRole: .caption,
            foregroundRole: colors.foregroundRole,
            backgroundStyle: .init(
                usesGlass: usesGlass,
                fallbackFillRole: colors.fillRole,
                accentFallbackFillOpacity: colors.accentFillOpacity,
                glassTintRole: usesGlass ? colors.tintRole : nil,
                accentGlassTintOpacity: usesGlass
                    ? colors.accentFillOpacity
                    : nil,
                borderRole: colors.borderRole,
                accentBorderOpacity: colors.accentBorderOpacity
            ),
            horizontalPadding: spacing.control,
            verticalPadding: spacing.inline
        )
    }

    private func badgeColorRoles(
        for style: MHBadgeStyle
    ) -> BadgeColorRoles {
        switch style {
        case .neutral:
            .init(
                foregroundRole: .secondaryText,
                fillRole: .badgeNeutralFill,
                tintRole: .badgeNeutralFill,
                borderRole: .badgeNeutralBorder
            )
        case .accent:
            .init(
                foregroundRole: .accent,
                fillRole: .accent,
                tintRole: .accent,
                borderRole: .accent,
                accentFillOpacity: MHResolvedBadgeChromeStyle.accentFillOpacity,
                accentBorderOpacity: MHResolvedBadgeChromeStyle.accentBorderOpacity
            )
        case .positive:
            .init(
                foregroundRole: .positive,
                fillRole: .badgePositiveFill,
                tintRole: .badgePositiveFill,
                borderRole: .badgePositiveBorder
            )
        case .warning:
            .init(
                foregroundRole: .warning,
                fillRole: .badgeWarningFill,
                tintRole: .badgeWarningFill,
                borderRole: .badgeWarningBorder
            )
        case .destructive:
            .init(
                foregroundRole: .destructive,
                fillRole: .badgeDestructiveFill,
                tintRole: .badgeDestructiveFill,
                borderRole: .badgeDestructiveBorder
            )
        }
    }
}

private struct BadgeColorRoles {
    var foregroundRole: MHColorRole
    var fillRole: MHColorRole
    var tintRole: MHColorRole
    var borderRole: MHColorRole
    var accentFillOpacity: Double?
    var accentBorderOpacity: Double?

    init(
        foregroundRole: MHColorRole,
        fillRole: MHColorRole,
        tintRole: MHColorRole,
        borderRole: MHColorRole,
        accentFillOpacity: Double? = nil,
        accentBorderOpacity: Double? = nil
    ) {
        self.foregroundRole = foregroundRole
        self.fillRole = fillRole
        self.tintRole = tintRole
        self.borderRole = borderRole
        self.accentFillOpacity = accentFillOpacity
        self.accentBorderOpacity = accentBorderOpacity
    }
}
// swiftlint:enable file_types_order one_declaration_per_file
