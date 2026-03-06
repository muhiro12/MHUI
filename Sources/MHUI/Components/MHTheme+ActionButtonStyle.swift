// swiftlint:disable no_magic_numbers
extension MHTheme {
    func resolvedActionButtonStyle(
        for role: MHButtonRole
    ) -> MHResolvedActionButtonStyle {
        switch role {
        case .primary:
            .init(
                fillRole: .accent,
                fillOpacity: 0.14,
                borderRole: .accent,
                borderOpacity: 0.26,
                foregroundRole: .accent,
                horizontalPadding: spacing.group,
                verticalPadding: spacing.control
            )
        case .secondary:
            .init(
                fillRole: .surfaceMuted,
                fillOpacity: 1,
                borderRole: .border,
                borderOpacity: divider.opacity,
                foregroundRole: .primaryText,
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
                horizontalPadding: spacing.control,
                verticalPadding: spacing.inline + 2
            )
        case .destructive:
            .init(
                fillRole: .destructive,
                fillOpacity: 0.12,
                borderRole: .destructive,
                borderOpacity: 0.24,
                foregroundRole: .destructive,
                horizontalPadding: spacing.group,
                verticalPadding: spacing.control
            )
        }
    }
}
// swiftlint:enable no_magic_numbers
