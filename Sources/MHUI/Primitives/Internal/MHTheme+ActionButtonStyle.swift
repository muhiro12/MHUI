// swiftlint:disable function_body_length no_magic_numbers
private struct MHButtonBackgroundRecipe {
    let fallbackFillRole: MHColorRole?
    let fallbackFillOpacity: Double
    let glassTintRole: MHColorRole?
    let glassTintOpacity: Double
    let borderRole: MHColorRole?
    let borderOpacity: Double
}

extension MHTheme {
    func resolvedActionButtonStyle(
        for role: MHButtonRole,
        context: MHAdaptiveLayoutContext,
        glassPolicy: MHGlassPolicy,
        reduceTransparency: Bool,
        supportsGlass: Bool = MHGlassRuntimeSupport.isAvailable
    ) -> MHResolvedActionButtonStyle {
        let isCompactWidth = context.isCompactWidth(
            threshold: layout.compactWidthThreshold
        )
        let filledHorizontalPadding = isCompactWidth
            ? layout.compactActionHorizontalPadding
            : spacing.group
        let filledVerticalPadding = isCompactWidth
            ? layout.compactActionVerticalPadding
            : spacing.control
        let quietHorizontalPadding = isCompactWidth
            ? layout.compactRowAccessorySpacing
            : spacing.control
        let quietVerticalPadding = isCompactWidth
            ? layout.compactKeyValueSpacing
            : spacing.inline + 2

        return switch role {
        case .primary:
            MHResolvedActionButtonStyle(
                backgroundStyle: resolvedGlassBackgroundStyle(
                    .init(
                        fallbackFillRole: .surfaceMuted,
                        fallbackFillOpacity: 1,
                        glassTintRole: .accent,
                        glassTintOpacity: 0.14,
                        borderRole: .accent,
                        borderOpacity: 0.18
                    ),
                    glassPolicy: glassPolicy,
                    reduceTransparency: reduceTransparency,
                    supportsGlass: supportsGlass
                ),
                foregroundRole: .primaryText,
                horizontalPadding: filledHorizontalPadding,
                verticalPadding: filledVerticalPadding,
                pressedOpacity: 0.88,
                disabledOpacity: 0.55
            )
        case .secondary:
            MHResolvedActionButtonStyle(
                backgroundStyle: resolvedGlassBackgroundStyle(
                    .init(
                        fallbackFillRole: .surface,
                        fallbackFillOpacity: 1,
                        glassTintRole: .surface,
                        glassTintOpacity: 0.12,
                        borderRole: .border,
                        borderOpacity: 0.22
                    ),
                    glassPolicy: glassPolicy,
                    reduceTransparency: reduceTransparency,
                    supportsGlass: supportsGlass
                ),
                foregroundRole: .primaryText,
                horizontalPadding: filledHorizontalPadding,
                verticalPadding: filledVerticalPadding,
                pressedOpacity: 0.88,
                disabledOpacity: 0.55
            )
        case .quiet:
            MHResolvedActionButtonStyle(
                backgroundStyle: nil,
                foregroundRole: .accent,
                horizontalPadding: quietHorizontalPadding,
                verticalPadding: quietVerticalPadding,
                pressedOpacity: 0.72,
                disabledOpacity: 0.50
            )
        case .destructive:
            MHResolvedActionButtonStyle(
                backgroundStyle: resolvedGlassBackgroundStyle(
                    .init(
                        fallbackFillRole: .surface,
                        fallbackFillOpacity: 1,
                        glassTintRole: .destructive,
                        glassTintOpacity: 0.10,
                        borderRole: .destructive,
                        borderOpacity: 0.20
                    ),
                    glassPolicy: glassPolicy,
                    reduceTransparency: reduceTransparency,
                    supportsGlass: supportsGlass
                ),
                foregroundRole: .destructive,
                horizontalPadding: filledHorizontalPadding,
                verticalPadding: filledVerticalPadding,
                pressedOpacity: 0.88,
                disabledOpacity: 0.55
            )
        }
    }

    func resolvedActionButtonStyle(
        for role: MHButtonRole
    ) -> MHResolvedActionButtonStyle {
        resolvedActionButtonStyle(
            for: role,
            context: .init(),
            glassPolicy: .automatic,
            reduceTransparency: false
        )
    }

    private func resolvedGlassBackgroundStyle(
        _ recipe: MHButtonBackgroundRecipe,
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
}
// swiftlint:enable function_body_length no_magic_numbers
