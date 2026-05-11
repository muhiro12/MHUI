import SwiftUI

struct MHResolvedInputChromeStyle: Sendable, Equatable {
    static let focusedBorderOpacity: Double = 0.24

    var backgroundStyle: MHResolvedGlassBackgroundStyle
    var horizontalPadding: CGFloat
    var verticalPadding: CGFloat
    var minimumHeight: CGFloat
}

extension MHTheme {
    func resolvedInputChromeStyle(
        for state: MHFieldState,
        glassPolicy: MHGlassPolicy,
        reduceTransparency: Bool,
        supportsGlass: Bool = MHGlassRuntimeSupport.isAvailable
    ) -> MHResolvedInputChromeStyle {
        let recipe = inputBackgroundRecipe(for: state)

        return .init(
            backgroundStyle: resolvedInputBackgroundStyle(
                recipe,
                glassPolicy: glassPolicy,
                reduceTransparency: reduceTransparency,
                supportsGlass: supportsGlass
            ),
            horizontalPadding: spacing.content,
            verticalPadding: spacing.control,
            minimumHeight: layout.control.minimumTouchTarget
        )
    }

    private func resolvedInputBackgroundStyle(
        _ recipe: MHInputBackgroundRecipe,
        glassPolicy: MHGlassPolicy,
        reduceTransparency: Bool,
        supportsGlass: Bool
    ) -> MHResolvedGlassBackgroundStyle {
        let usesGlass = glassPolicy.resolvesUsesGlass(
            prefersGlass: true,
            supportsGlass: supportsGlass,
            reduceTransparency: reduceTransparency
        )

        return .init(
            usesGlass: usesGlass,
            fallbackFillRole: recipe.fallbackFillRole,
            accentFallbackFillOpacity: nil,
            glassTintRole: usesGlass ? recipe.glassTintRole : nil,
            accentGlassTintOpacity: nil,
            borderRole: recipe.borderRole,
            accentBorderOpacity: recipe.accentBorderOpacity
        )
    }

    private func inputBackgroundRecipe(
        for state: MHFieldState
    ) -> MHInputBackgroundRecipe {
        switch state {
        case .normal:
            .init(
                fallbackFillRole: .surface,
                glassTintRole: .inputTint,
                borderRole: .inputBorder,
                accentBorderOpacity: nil
            )
        case .focused:
            .init(
                fallbackFillRole: .surface,
                glassTintRole: .surfaceTint,
                borderRole: .accent,
                accentBorderOpacity: MHResolvedInputChromeStyle.focusedBorderOpacity
            )
        case .invalid:
            .init(
                fallbackFillRole: .inputInvalidFill,
                glassTintRole: .inputInvalidTint,
                borderRole: .destructiveBorder,
                accentBorderOpacity: nil
            )
        }
    }
}
