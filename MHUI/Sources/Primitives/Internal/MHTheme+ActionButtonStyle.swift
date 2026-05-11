// swiftlint:disable function_body_length no_magic_numbers
private struct MHButtonBackgroundRecipe {
    let fallbackFillRole: MHColorRole?
    let accentFallbackFillOpacity: Double?
    let glassTintRole: MHColorRole?
    let accentGlassTintOpacity: Double?
    let borderRole: MHColorRole?
    let accentBorderOpacity: Double?
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
            ? presentation.compactActionHorizontalPadding
            : spacing.content
        let filledVerticalPadding = isCompactWidth
            ? presentation.compactActionVerticalPadding
            : spacing.control
        let quietHorizontalPadding = isCompactWidth
            ? presentation.compactRowAccessorySpacing
            : spacing.control
        let quietVerticalPadding = isCompactWidth
            ? presentation.compactKeyValueSpacing
            : spacing.inline

        return switch role {
        case .primary:
            MHResolvedActionButtonStyle(
                backgroundStyle: resolvedGlassBackgroundStyle(
                    .init(
                        fallbackFillRole: .surfaceMuted,
                        accentFallbackFillOpacity: nil,
                        glassTintRole: .accent,
                        accentGlassTintOpacity: 0.14,
                        borderRole: .accent,
                        accentBorderOpacity: 0.18
                    ),
                    glassPolicy: glassPolicy,
                    reduceTransparency: reduceTransparency,
                    supportsGlass: supportsGlass
                ),
                foregroundRole: .primaryText,
                horizontalPadding: filledHorizontalPadding,
                verticalPadding: filledVerticalPadding,
                minimumHeight: layout.control.minimumTouchTarget,
                pressedOpacity: 0.88,
                disabledOpacity: 0.55
            )
        case .secondary:
            MHResolvedActionButtonStyle(
                backgroundStyle: resolvedGlassBackgroundStyle(
                    .init(
                        fallbackFillRole: .surface,
                        accentFallbackFillOpacity: nil,
                        glassTintRole: .surfaceTint,
                        accentGlassTintOpacity: nil,
                        borderRole: .controlBorder,
                        accentBorderOpacity: nil
                    ),
                    glassPolicy: glassPolicy,
                    reduceTransparency: reduceTransparency,
                    supportsGlass: supportsGlass
                ),
                foregroundRole: .primaryText,
                horizontalPadding: filledHorizontalPadding,
                verticalPadding: filledVerticalPadding,
                minimumHeight: layout.control.minimumTouchTarget,
                pressedOpacity: 0.88,
                disabledOpacity: 0.55
            )
        case .quiet:
            MHResolvedActionButtonStyle(
                backgroundStyle: nil,
                foregroundRole: .accent,
                horizontalPadding: quietHorizontalPadding,
                verticalPadding: quietVerticalPadding,
                minimumHeight: layout.control.minimumTouchTarget,
                pressedOpacity: 0.72,
                disabledOpacity: 0.50
            )
        case .destructive:
            MHResolvedActionButtonStyle(
                backgroundStyle: resolvedGlassBackgroundStyle(
                    .init(
                        fallbackFillRole: .surface,
                        accentFallbackFillOpacity: nil,
                        glassTintRole: .destructiveTint,
                        accentGlassTintOpacity: nil,
                        borderRole: .destructiveBorder,
                        accentBorderOpacity: nil
                    ),
                    glassPolicy: glassPolicy,
                    reduceTransparency: reduceTransparency,
                    supportsGlass: supportsGlass
                ),
                foregroundRole: .destructive,
                horizontalPadding: filledHorizontalPadding,
                verticalPadding: filledVerticalPadding,
                minimumHeight: layout.control.minimumTouchTarget,
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
            accentFallbackFillOpacity: recipe.accentFallbackFillOpacity,
            glassTintRole: usesGlass ? recipe.glassTintRole : nil,
            accentGlassTintOpacity: usesGlass
                ? recipe.accentGlassTintOpacity
                : nil,
            borderRole: recipe.borderRole,
            accentBorderOpacity: recipe.accentBorderOpacity
        )
    }
}
// swiftlint:enable function_body_length no_magic_numbers
