import SwiftUI

struct MHResolvedInputChromeStyle: Sendable, Equatable {
    static let focusedBorderOpacity: Double = 0.24
    static let invalidFillOpacity: Double = 0.04
    static let invalidBorderOpacity: Double = 0.18

    var fillRole: MHColorRole
    var fillOpacity: Double
    var borderRole: MHColorRole
    var borderOpacity: Double
    var horizontalPadding: CGFloat
    var verticalPadding: CGFloat
}

extension MHTheme {
    func resolvedInputChromeStyle(
        for state: MHFieldState
    ) -> MHResolvedInputChromeStyle {
        switch state {
        case .normal:
            .init(
                fillRole: .surface,
                fillOpacity: 1,
                borderRole: .border,
                borderOpacity: divider.opacity,
                horizontalPadding: spacing.group,
                verticalPadding: spacing.control
            )
        case .focused:
            .init(
                fillRole: .surface,
                fillOpacity: 1,
                borderRole: .accent,
                borderOpacity: MHResolvedInputChromeStyle.focusedBorderOpacity,
                horizontalPadding: spacing.group,
                verticalPadding: spacing.control
            )
        case .invalid:
            .init(
                fillRole: .destructive,
                fillOpacity: MHResolvedInputChromeStyle.invalidFillOpacity,
                borderRole: .destructive,
                borderOpacity: MHResolvedInputChromeStyle.invalidBorderOpacity,
                horizontalPadding: spacing.group,
                verticalPadding: spacing.control
            )
        }
    }
}
