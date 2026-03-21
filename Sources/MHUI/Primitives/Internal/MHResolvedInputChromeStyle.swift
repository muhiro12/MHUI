import SwiftUI

struct MHResolvedInputChromeStyle: Sendable, Equatable {
    static let normalBorderOpacity: Double = 0.20
    static let focusedBorderOpacity: Double = 0.24
    static let invalidFillOpacity: Double = 0.06
    static let invalidBorderOpacity: Double = 0.20
    static let normalGlassTintOpacity: Double = 0.10
    static let focusedGlassTintOpacity: Double = 0.12
    static let invalidGlassTintOpacity: Double = 0.08

    var backgroundStyle: MHResolvedGlassBackgroundStyle
    var horizontalPadding: CGFloat
    var verticalPadding: CGFloat
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
            horizontalPadding: spacing.group,
            verticalPadding: spacing.control
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
            fallbackFillOpacity: recipe.fallbackFillOpacity,
            glassTintRole: usesGlass ? recipe.glassTintRole : nil,
            glassTintOpacity: usesGlass ? recipe.glassTintOpacity : 0,
            borderRole: recipe.borderRole,
            borderOpacity: recipe.borderOpacity
        )
    }

    private func inputBackgroundRecipe(
        for state: MHFieldState
    ) -> MHInputBackgroundRecipe {
        switch state {
        case .normal:
            .init(
                fallbackFillRole: .surface,
                fallbackFillOpacity: 1,
                glassTintRole: .surface,
                glassTintOpacity: MHResolvedInputChromeStyle.normalGlassTintOpacity,
                borderRole: .border,
                borderOpacity: MHResolvedInputChromeStyle.normalBorderOpacity
            )
        case .focused:
            .init(
                fallbackFillRole: .surface,
                fallbackFillOpacity: 1,
                glassTintRole: .surface,
                glassTintOpacity: MHResolvedInputChromeStyle.focusedGlassTintOpacity,
                borderRole: .accent,
                borderOpacity: MHResolvedInputChromeStyle.focusedBorderOpacity
            )
        case .invalid:
            .init(
                fallbackFillRole: .destructive,
                fallbackFillOpacity: MHResolvedInputChromeStyle.invalidFillOpacity,
                glassTintRole: .destructive,
                glassTintOpacity: MHResolvedInputChromeStyle.invalidGlassTintOpacity,
                borderRole: .destructive,
                borderOpacity: MHResolvedInputChromeStyle.invalidBorderOpacity
            )
        }
    }
}
