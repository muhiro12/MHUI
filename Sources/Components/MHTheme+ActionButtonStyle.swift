// swiftlint:disable no_magic_numbers
extension MHTheme {
    func resolvedActionButtonStyle(
        for role: MHButtonRole
    ) -> MHResolvedActionButtonStyle {
        switch role {
        case .primary:
            .init(
                fillRole: .surface,
                fillOpacity: 1,
                borderRole: .border,
                borderOpacity: divider.opacity,
                foregroundRole: .primaryText,
                accentRuleRole: .accent,
                accentRuleOpacity: 0.75,
                horizontalPadding: spacing.group,
                verticalPadding: spacing.control
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
                verticalPadding: spacing.control
            )
        case .quiet:
            .init(
                fillRole: nil,
                fillOpacity: 0,
                borderRole: nil,
                borderOpacity: 0,
                foregroundRole: .primaryText,
                accentRuleRole: nil,
                accentRuleOpacity: 0,
                horizontalPadding: spacing.control,
                verticalPadding: spacing.inline + 2
            )
        case .destructive:
            .init(
                fillRole: .surface,
                fillOpacity: 1,
                borderRole: .destructive,
                borderOpacity: 0.22,
                foregroundRole: .destructive,
                accentRuleRole: .destructive,
                accentRuleOpacity: 0.55,
                horizontalPadding: spacing.group,
                verticalPadding: spacing.control
            )
        }
    }
}
// swiftlint:enable no_magic_numbers
