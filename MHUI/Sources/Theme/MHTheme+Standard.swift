import MHDesign

private enum MHStandardColorAsset {
    static let background = "MHBackground"
    static let surface = "MHSurface"
    static let surfaceMuted = "MHSurfaceMuted"
    static let border = "MHBorder"
    static let primaryText = "MHPrimaryText"
    static let secondaryText = "MHSecondaryText"
    static let positive = "MHPositive"
    static let warning = "MHWarning"
    static let destructive = "MHDestructive"
}

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
                background: .asset(name: MHStandardColorAsset.background),
                surface: .asset(name: MHStandardColorAsset.surface),
                surfaceMuted: .asset(name: MHStandardColorAsset.surfaceMuted),
                border: .asset(name: MHStandardColorAsset.border),
                primaryText: .asset(name: MHStandardColorAsset.primaryText),
                secondaryText: .asset(name: MHStandardColorAsset.secondaryText),
                accent: accent,
                positive: .asset(name: MHStandardColorAsset.positive),
                warning: .asset(name: MHStandardColorAsset.warning),
                destructive: .asset(name: MHStandardColorAsset.destructive)
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
                opacity: 0.50
            ),
            motion: .init(
                quick: 0.14,
                regular: 0.22
            ),
            surfaces: .init(
                canvas: .init(
                    prefersGlass: false,
                    fallbackColorRole: .background,
                    fallbackOpacity: 1,
                    glassTintColorRole: nil,
                    glassTintOpacity: 0,
                    borderColorRole: .border,
                    borderOpacity: 0
                ),
                standard: .init(
                    prefersGlass: true,
                    fallbackColorRole: .surface,
                    fallbackOpacity: 1,
                    glassTintColorRole: .surface,
                    glassTintOpacity: 0.12,
                    borderColorRole: .border,
                    borderOpacity: 0.24
                ),
                muted: .init(
                    prefersGlass: true,
                    fallbackColorRole: .surfaceMuted,
                    fallbackOpacity: 1,
                    glassTintColorRole: .surfaceMuted,
                    glassTintOpacity: 0.08,
                    borderColorRole: .border,
                    borderOpacity: 0.18
                )
            )
        )
    }
    // swiftlint:enable function_body_length
    // swiftlint:enable no_magic_numbers
}
