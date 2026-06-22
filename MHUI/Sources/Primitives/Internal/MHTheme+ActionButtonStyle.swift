extension MHTheme {
    func resolvedActionButtonStyle(
        for role: MHButtonRole,
        context: MHAdaptiveLayoutContext,
        glassPolicy: MHGlassPolicy,
        reduceTransparency: Bool
    ) -> MHResolvedActionButtonStyle {
        resolvedActionButtonStyle(
            for: role,
            context: context,
            glassPolicy: glassPolicy,
            reduceTransparency: reduceTransparency,
            supportsGlass: MHGlassRuntimeSupport.isAvailable
        )
    }

    func resolvedActionButtonStyle(
        for role: MHButtonRole,
        context: MHAdaptiveLayoutContext,
        glassPolicy: MHGlassPolicy,
        reduceTransparency: Bool,
        supportsGlass: Bool
    ) -> MHResolvedActionButtonStyle {
        let padding = actionButtonPadding(for: context)

        switch role {
        case .primary:
            return primaryActionButtonStyle(
                padding: padding,
                glassPolicy: glassPolicy,
                reduceTransparency: reduceTransparency,
                supportsGlass: supportsGlass
            )
        case .secondary:
            return secondaryActionButtonStyle(
                padding: padding,
                glassPolicy: glassPolicy,
                reduceTransparency: reduceTransparency,
                supportsGlass: supportsGlass
            )
        case .quiet:
            return quietActionButtonStyle(padding: padding)
        case .destructive:
            return destructiveActionButtonStyle(
                padding: padding,
                glassPolicy: glassPolicy,
                reduceTransparency: reduceTransparency,
                supportsGlass: supportsGlass
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
}

private extension MHTheme {
    func actionButtonPadding(
        for context: MHAdaptiveLayoutContext
    ) -> MHActionButtonPadding {
        let isCompactWidth = context.isCompactWidth(
            threshold: layout.compactWidthThreshold
        )

        return .init(
            filledHorizontal: isCompactWidth
                ? presentation.compactActionHorizontalPadding
                : spacing.content,
            filledVertical: isCompactWidth
                ? presentation.compactActionVerticalPadding
                : spacing.control,
            quietHorizontal: isCompactWidth
                ? presentation.compactRowAccessorySpacing
                : spacing.control,
            quietVertical: isCompactWidth
                ? presentation.compactKeyValueSpacing
                : spacing.inline
        )
    }

    func primaryActionButtonStyle(
        padding: MHActionButtonPadding,
        glassPolicy: MHGlassPolicy,
        reduceTransparency: Bool,
        supportsGlass: Bool
    ) -> MHResolvedActionButtonStyle {
        let backgroundStyle = resolvedGlassBackgroundStyle(
            .primary,
            glassPolicy: glassPolicy,
            reduceTransparency: reduceTransparency,
            supportsGlass: supportsGlass
        )

        return filledActionButtonStyle(
            backgroundStyle: backgroundStyle,
            foregroundRole: backgroundStyle.usesGlass ? .primaryText : .onAccent,
            padding: padding
        )
    }

    func secondaryActionButtonStyle(
        padding: MHActionButtonPadding,
        glassPolicy: MHGlassPolicy,
        reduceTransparency: Bool,
        supportsGlass: Bool
    ) -> MHResolvedActionButtonStyle {
        filledActionButtonStyle(
            backgroundStyle: resolvedGlassBackgroundStyle(
                .secondary,
                glassPolicy: glassPolicy,
                reduceTransparency: reduceTransparency,
                supportsGlass: supportsGlass
            ),
            foregroundRole: .primaryText,
            padding: padding
        )
    }

    func destructiveActionButtonStyle(
        padding: MHActionButtonPadding,
        glassPolicy: MHGlassPolicy,
        reduceTransparency: Bool,
        supportsGlass: Bool
    ) -> MHResolvedActionButtonStyle {
        filledActionButtonStyle(
            backgroundStyle: resolvedGlassBackgroundStyle(
                .destructive,
                glassPolicy: glassPolicy,
                reduceTransparency: reduceTransparency,
                supportsGlass: supportsGlass
            ),
            foregroundRole: .destructive,
            padding: padding
        )
    }

    func quietActionButtonStyle(
        padding: MHActionButtonPadding
    ) -> MHResolvedActionButtonStyle {
        .init(
            backgroundStyle: nil,
            foregroundRole: .accent,
            horizontalPadding: padding.quietHorizontal,
            verticalPadding: padding.quietVertical,
            minimumHeight: layout.control.minimumTouchTarget,
            pressedOpacity: MHActionButtonConstants.quietPressedOpacity,
            disabledOpacity: MHActionButtonConstants.quietDisabledOpacity
        )
    }

    func filledActionButtonStyle(
        backgroundStyle: MHResolvedGlassBackgroundStyle,
        foregroundRole: MHColorRole,
        padding: MHActionButtonPadding
    ) -> MHResolvedActionButtonStyle {
        .init(
            backgroundStyle: backgroundStyle,
            foregroundRole: foregroundRole,
            horizontalPadding: padding.filledHorizontal,
            verticalPadding: padding.filledVertical,
            minimumHeight: layout.control.minimumTouchTarget,
            pressedOpacity: MHActionButtonConstants.filledPressedOpacity,
            disabledOpacity: MHActionButtonConstants.filledDisabledOpacity
        )
    }

    func resolvedGlassBackgroundStyle(
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
            glassTintOpacity: usesGlass
                ? recipe.glassTintOpacity
                : MHActionButtonConstants.noOpacity,
            isGlassInteractive: usesGlass,
            borderRole: recipe.borderRole,
            borderOpacity: recipe.borderOpacity
        )
    }
}

private extension MHButtonBackgroundRecipe {
    static let primary = Self(
        fallbackFillRole: .accent,
        fallbackFillOpacity: MHActionButtonConstants.opaque,
        glassTintRole: .accent,
        glassTintOpacity: MHActionButtonConstants.primaryGlassTintOpacity,
        borderRole: .accent,
        borderOpacity: MHActionButtonConstants.noOpacity
    )

    static let secondary = Self(
        fallbackFillRole: .surface,
        fallbackFillOpacity: MHActionButtonConstants.opaque,
        glassTintRole: .surface,
        glassTintOpacity: MHActionButtonConstants.secondaryGlassTintOpacity,
        borderRole: .border,
        borderOpacity: MHActionButtonConstants.secondaryBorderOpacity
    )

    static let destructive = Self(
        fallbackFillRole: .surface,
        fallbackFillOpacity: MHActionButtonConstants.opaque,
        glassTintRole: .destructive,
        glassTintOpacity: MHActionButtonConstants.destructiveGlassTintOpacity,
        borderRole: .destructive,
        borderOpacity: MHActionButtonConstants.destructiveBorderOpacity
    )
}
