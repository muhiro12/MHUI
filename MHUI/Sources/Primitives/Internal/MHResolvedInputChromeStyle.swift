import SwiftUI

struct MHResolvedInputChromeStyle: Sendable, Equatable {
    static let normalBorderOpacity: Double = 0.20
    static let focusedBorderOpacity: Double = 0.24
    static let invalidFillOpacity: Double = 0.06
    static let invalidBorderOpacity: Double = 0.20

    var backgroundStyle: MHResolvedSurfaceStyle
    var horizontalPadding: CGFloat
    var verticalPadding: CGFloat
    var minimumHeight: CGFloat
}

extension MHTheme {
    func resolvedInputChromeStyle(
        for state: MHFieldState,
        increasedContrast: Bool
    ) -> MHResolvedInputChromeStyle {
        .init(
            backgroundStyle: inputBackgroundStyle(for: state)
                .outlined(
                    minimumOpacity: divider.opacity,
                    when: increasedContrast
                ),
            horizontalPadding: spacing.content,
            verticalPadding: spacing.control,
            minimumHeight: layout.control.minimumTouchTarget
        )
    }

    private func inputBackgroundStyle(
        for state: MHFieldState
    ) -> MHResolvedSurfaceStyle {
        switch state {
        case .normal:
            .init(
                fillRole: .surface,
                fillOpacity: 1,
                borderRole: .border,
                borderOpacity: MHResolvedInputChromeStyle.normalBorderOpacity
            )
        case .focused:
            .init(
                fillRole: .surface,
                fillOpacity: 1,
                borderRole: .accent,
                borderOpacity: MHResolvedInputChromeStyle.focusedBorderOpacity
            )
        case .invalid:
            .init(
                fillRole: .destructive,
                fillOpacity: MHResolvedInputChromeStyle.invalidFillOpacity,
                borderRole: .destructive,
                borderOpacity: MHResolvedInputChromeStyle.invalidBorderOpacity
            )
        }
    }
}
