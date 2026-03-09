import SwiftUI

struct MHResolvedBadgeChromeStyle: Sendable, Equatable {
    static let neutralFillOpacity: Double = 0.03
    static let emphasizedFillOpacity: Double = 0.05
    static let neutralBorderOpacity: Double = 0.08
    static let emphasizedBorderOpacity: Double = 0.10

    var textRole: MHTextRole
    var foregroundRole: MHColorRole
    var horizontalPadding: CGFloat
    var verticalPadding: CGFloat
    var fillOpacity: Double
    var borderOpacity: Double
}

extension MHTheme {
    func resolvedBadgeChromeStyle(
        for style: MHBadgeStyle
    ) -> MHResolvedBadgeChromeStyle {
        MHResolvedBadgeChromeStyle(
            textRole: .caption,
            foregroundRole: badgeForegroundColorRole(for: style),
            horizontalPadding: spacing.control,
            verticalPadding: spacing.inline,
            fillOpacity: style == .neutral
                ? MHResolvedBadgeChromeStyle.neutralFillOpacity
                : MHResolvedBadgeChromeStyle.emphasizedFillOpacity,
            borderOpacity: style == .neutral
                ? MHResolvedBadgeChromeStyle.neutralBorderOpacity
                : MHResolvedBadgeChromeStyle.emphasizedBorderOpacity
        )
    }

    private func badgeForegroundColorRole(
        for style: MHBadgeStyle
    ) -> MHColorRole {
        switch style {
        case .neutral:
            .secondaryText
        case .accent:
            .accent
        case .positive:
            .positive
        case .warning:
            .warning
        case .destructive:
            .destructive
        }
    }
}
