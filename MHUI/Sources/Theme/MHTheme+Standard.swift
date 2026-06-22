import MHDesign

public extension MHTheme {
    // swiftlint:disable no_magic_numbers
    /// The default calm theme used by MHUI components.
    /// Tune default spacing, typography, and surface recipes here first.
    static let standard = standard()

    private static var standardTypography: Typography {
        .init(
            screenTitle: .init(style: .title2, weight: .semibold),
            sectionTitle: .init(style: .title3, weight: .semibold),
            body: .init(style: .body, weight: .regular),
            bodyStrong: .init(style: .body, weight: .medium),
            supporting: .init(style: .subheadline, weight: .regular),
            metadata: .init(style: .footnote, weight: .medium),
            caption: .init(style: .footnote, weight: .medium)
        )
    }

    private static var standardPresentation: MHPresentationMetrics {
        .init(
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
        )
    }

    private static var standardDivider: Divider {
        .init(
            thickness: 1,
            opacity: 0.50
        )
    }

    private static var standardMotion: Motion {
        .init(
            quick: 0.14,
            regular: 0.22
        )
    }

    private static var standardSurfaces: Surfaces {
        .init(
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
    }

    /// Creates the standard neutral MHUI theme using the selected accent source.
    /// Uses the default MHUI on-accent foreground asset.
    static func standard(
        accent: MHColorReference = .tint
    ) -> Self {
        standard(
            metrics: .standard,
            accent: accent,
            onAccent: .asset(MHColorAsset.onAccent)
        )
    }

    /// Creates the standard neutral MHUI theme with an app-provided on-accent foreground.
    static func standard(
        onAccent: MHColorReference
    ) -> Self {
        standard(
            metrics: .standard,
            accent: .tint,
            onAccent: onAccent
        )
    }

    /// Creates the standard neutral MHUI theme with an app-provided metrics baseline.
    static func standard(
        metrics: MHDesignMetrics,
        accent: MHColorReference = .tint
    ) -> Self {
        standard(
            metrics: metrics,
            accent: accent,
            onAccent: .asset(MHColorAsset.onAccent)
        )
    }

    /// Creates the standard neutral MHUI theme with an app-provided on-accent foreground.
    /// Use this when the app's accent color needs a foreground other than the MHUI default.
    static func standard(
        accent: MHColorReference,
        onAccent: MHColorReference
    ) -> Self {
        standard(
            metrics: .standard,
            accent: accent,
            onAccent: onAccent
        )
    }

    /// Creates the standard neutral MHUI theme with app-provided metrics and colors.
    /// Use this when an app wants MHUI chrome with its own shared layout baseline.
    static func standard(
        metrics: MHDesignMetrics,
        accent: MHColorReference,
        onAccent: MHColorReference
    ) -> Self {
        Self(
            colors: standardColors(
                accent: accent,
                onAccent: onAccent
            ),
            typography: standardTypography,
            metrics: metrics,
            presentation: standardPresentation,
            divider: standardDivider,
            motion: standardMotion,
            surfaces: standardSurfaces
        )
    }

    private static func standardColors(
        accent: MHColorReference,
        onAccent: MHColorReference
    ) -> Colors {
        .init(
            background: .asset(MHColorAsset.background),
            surface: .asset(MHColorAsset.surface),
            surfaceElevated: .asset(MHColorAsset.surfaceElevated),
            surfaceMuted: .asset(MHColorAsset.surfaceMuted),
            border: .asset(MHColorAsset.border),
            primaryText: .asset(MHColorAsset.primaryText),
            secondaryText: .asset(MHColorAsset.secondaryText),
            tertiaryText: .asset(MHColorAsset.tertiaryText),
            accent: accent,
            onAccent: onAccent,
            warning: .asset(MHColorAsset.warning),
            destructive: .asset(MHColorAsset.destructive)
        )
    }

    // swiftlint:enable no_magic_numbers
}
