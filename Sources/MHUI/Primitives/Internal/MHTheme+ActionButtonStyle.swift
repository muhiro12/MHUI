// swiftlint:disable function_body_length no_magic_numbers
extension MHTheme {
    func resolvedActionButtonStyle(
        for role: MHButtonRole,
        context: MHAdaptiveLayoutContext
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
                fillRole: .surfaceMuted,
                fillOpacity: 1,
                borderRole: .border,
                borderOpacity: divider.opacity,
                foregroundRole: .primaryText,
                accentRuleRole: nil,
                accentRuleOpacity: 0,
                horizontalPadding: filledHorizontalPadding,
                verticalPadding: filledVerticalPadding,
                pressedOpacity: 0.88,
                disabledOpacity: 0.55
            )
        case .secondary:
            MHResolvedActionButtonStyle(
                fillRole: .surface,
                fillOpacity: 1,
                borderRole: .border,
                borderOpacity: divider.opacity,
                foregroundRole: .primaryText,
                accentRuleRole: nil,
                accentRuleOpacity: 0,
                horizontalPadding: filledHorizontalPadding,
                verticalPadding: filledVerticalPadding,
                pressedOpacity: 0.88,
                disabledOpacity: 0.55
            )
        case .quiet:
            MHResolvedActionButtonStyle(
                fillRole: nil,
                fillOpacity: 0,
                borderRole: nil,
                borderOpacity: 0,
                foregroundRole: .accent,
                accentRuleRole: nil,
                accentRuleOpacity: 0,
                horizontalPadding: quietHorizontalPadding,
                verticalPadding: quietVerticalPadding,
                pressedOpacity: 0.72,
                disabledOpacity: 0.50
            )
        case .destructive:
            MHResolvedActionButtonStyle(
                fillRole: .surface,
                fillOpacity: 1,
                borderRole: .destructive,
                borderOpacity: 0.18,
                foregroundRole: .destructive,
                accentRuleRole: nil,
                accentRuleOpacity: 0,
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
        resolvedActionButtonStyle(for: role, context: .init())
    }
}
// swiftlint:enable function_body_length no_magic_numbers
