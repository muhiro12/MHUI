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

        switch role {
        case .primary:
            let backgroundStyle = resolvedGlassBackgroundStyle(
                .init(
                    fallbackFillRole: .accent,
                    fallbackFillOpacity: 1,
                    glassTintRole: .accent,
                    glassTintOpacity: 0.20,
                    borderRole: .accent,
                    borderOpacity: 0
                ),
                glassPolicy: glassPolicy,
                reduceTransparency: reduceTransparency,
                supportsGlass: supportsGlass
            )
            return MHResolvedActionButtonStyle(
                backgroundStyle: backgroundStyle,
                foregroundRole: backgroundStyle.usesGlass ? .primaryText : .onAccent,
                horizontalPadding: filledHorizontalPadding,
                verticalPadding: filledVerticalPadding,
                minimumHeight: layout.control.minimumTouchTarget,
                pressedOpacity: 0.88,
                disabledOpacity: 0.55
            )
        case .secondary:
            return MHResolvedActionButtonStyle(
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
                minimumHeight: layout.control.minimumTouchTarget,
                pressedOpacity: 0.88,
                disabledOpacity: 0.55
            )
        case .quiet:
            return MHResolvedActionButtonStyle(
                backgroundStyle: nil,
                foregroundRole: .accent,
                horizontalPadding: quietHorizontalPadding,
                verticalPadding: quietVerticalPadding,
                minimumHeight: layout.control.minimumTouchTarget,
                pressedOpacity: 0.72,
                disabledOpacity: 0.50
            )
        case .destructive:
            return MHResolvedActionButtonStyle(
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
            fallbackFillOpacity: recipe.fallbackFillOpacity,
            glassTintRole: usesGlass ? recipe.glassTintRole : nil,
            glassTintOpacity: usesGlass ? recipe.glassTintOpacity : 0,
            borderRole: recipe.borderRole,
            borderOpacity: recipe.borderOpacity
        )
    }
}
// swiftlint:enable function_body_length no_magic_numbers
