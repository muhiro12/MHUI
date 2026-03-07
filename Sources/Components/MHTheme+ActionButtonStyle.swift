// swiftlint:disable function_body_length no_magic_numbers
extension MHTheme {
    func resolvedActionButtonStyle(
        for role: MHButtonRole
    ) -> MHResolvedActionButtonStyle {
        switch role {
        case .primary:
            .init(
                fillRole: .surfaceMuted,
                fillOpacity: 1,
                borderRole: .border,
                borderOpacity: divider.opacity,
                foregroundRole: .primaryText,
                accentRuleRole: nil,
                accentRuleOpacity: 0,
                horizontalPadding: spacing.group,
                verticalPadding: spacing.control,
                pressedOpacity: 0.88,
                disabledOpacity: 0.55
            )
        case .secondary:
            .init(
                fillRole: .surface,
                fillOpacity: 1,
                borderRole: .border,
                borderOpacity: divider.opacity,
                foregroundRole: .primaryText,
                accentRuleRole: nil,
                accentRuleOpacity: 0,
                horizontalPadding: spacing.group,
                verticalPadding: spacing.control,
                pressedOpacity: 0.88,
                disabledOpacity: 0.55
            )
        case .quiet:
            .init(
                fillRole: nil,
                fillOpacity: 0,
                borderRole: nil,
                borderOpacity: 0,
                foregroundRole: .accent,
                accentRuleRole: nil,
                accentRuleOpacity: 0,
                horizontalPadding: spacing.control,
                verticalPadding: spacing.inline + 2,
                pressedOpacity: 0.72,
                disabledOpacity: 0.50
            )
        case .destructive:
            .init(
                fillRole: .surface,
                fillOpacity: 1,
                borderRole: .destructive,
                borderOpacity: 0.18,
                foregroundRole: .destructive,
                accentRuleRole: nil,
                accentRuleOpacity: 0,
                horizontalPadding: spacing.group,
                verticalPadding: spacing.control,
                pressedOpacity: 0.88,
                disabledOpacity: 0.55
            )
        }
    }
}
// swiftlint:enable function_body_length no_magic_numbers
