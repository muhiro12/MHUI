import MHDesign

public extension MHTheme {
    // swiftlint:disable no_magic_numbers
    /// The default calm theme used by MHUI components.
    /// Tune default spacing, typography, and surface recipes here first.
    static let standard = standard()

    // swiftlint:disable function_body_length
    /// Creates the standard neutral MHUI theme using the selected accent source.
    /// Detached surfaces prefer Liquid Glass when the runtime and policy allow it.
    static func standard(
        accent: MHColorReference = .tint
    ) -> Self {
        Self(
            colors: .init(
                background: .asset(.mhBackground),
                surface: .asset(.mhSurface),
                surfaceTint: .asset(.mhSurfaceTint),
                surfaceMuted: .asset(.mhSurfaceMuted),
                surfaceMutedTint: .asset(.mhSurfaceMutedTint),
                surfaceBorder: .asset(.mhSurfaceBorder),
                surfaceMutedBorder: .asset(.mhSurfaceMutedBorder),
                controlBorder: .asset(.mhControlBorder),
                border: .asset(.mhBorder),
                divider: .asset(.mhDivider),
                primaryText: .asset(.mhPrimaryText),
                secondaryText: .asset(.mhSecondaryText),
                accent: accent,
                positive: .asset(.mhPositive),
                warning: .asset(.mhWarning),
                destructive: .asset(.mhDestructive),
                destructiveTint: .asset(.mhDestructiveTint),
                destructiveBorder: .asset(.mhDestructiveBorder),
                inputBorder: .asset(.mhInputBorder),
                inputTint: .asset(.mhInputTint),
                inputInvalidFill: .asset(.mhInputInvalidFill),
                inputInvalidTint: .asset(.mhInputInvalidTint),
                badgeNeutralFill: .asset(.mhBadgeNeutralFill),
                badgeNeutralBorder: .asset(.mhBadgeNeutralBorder),
                badgePositiveFill: .asset(.mhBadgePositiveFill),
                badgePositiveBorder: .asset(.mhBadgePositiveBorder),
                badgeWarningFill: .asset(.mhBadgeWarningFill),
                badgeWarningBorder: .asset(.mhBadgeWarningBorder),
                badgeDestructiveFill: .asset(.mhBadgeDestructiveFill),
                badgeDestructiveBorder: .asset(.mhBadgeDestructiveBorder)
            ),
            typography: .init(
                screenTitle: .init(style: .title2, weight: .semibold),
                sectionTitle: .init(style: .title3, weight: .semibold),
                body: .init(style: .body, weight: .regular),
                bodyStrong: .init(style: .body, weight: .medium),
                supporting: .init(style: .subheadline, weight: .regular),
                metadata: .init(style: .footnote, weight: .medium),
                caption: .init(style: .footnote, weight: .medium)
            ),
            metrics: .standard,
            presentation: .init(
                rowHorizontalInset: 24,
                rowVerticalPadding: 16,
                rowAccessorySpacing: 16,
                compactRowHorizontalInset: 16,
                compactRowVerticalPadding: 8,
                compactRowAccessorySpacing: 8,
                compactActionHorizontalPadding: 16,
                compactActionVerticalPadding: 8,
                regularKeyValueMinimumValueWidth: 160,
                compactKeyValueMinimumValueWidth: 120,
                compactKeyValueSpacing: 8,
                compactActionGroupSpacing: 8,
                screenCueWidth: 24,
                screenCueHeight: 2,
                sectionCueWidth: 16,
                sectionCueHeight: 2
            ),
            divider: .init(
                thickness: 1,
                colorRole: .divider
            ),
            motion: .init(
                quick: 0.14,
                regular: 0.22
            ),
            surfaces: .init(
                canvas: .init(
                    prefersGlass: false,
                    fallbackColorRole: .background,
                    glassTintColorRole: nil,
                    borderColorRole: nil
                ),
                standard: .init(
                    prefersGlass: true,
                    fallbackColorRole: .surface,
                    glassTintColorRole: .surfaceTint,
                    borderColorRole: .surfaceBorder
                ),
                muted: .init(
                    prefersGlass: true,
                    fallbackColorRole: .surfaceMuted,
                    glassTintColorRole: .surfaceMutedTint,
                    borderColorRole: .surfaceMutedBorder
                )
            )
        )
    }
    // swiftlint:enable function_body_length
    // swiftlint:enable no_magic_numbers
}
