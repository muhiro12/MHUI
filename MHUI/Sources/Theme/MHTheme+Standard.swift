import MHDesign

public extension MHTheme {
    // swiftlint:disable no_magic_numbers
    /// The package-owned standard theme used by MHUI components.
    static let standard = standard()

    private static var standardTypography: Typography {
        .init(
            screenTitle: standardScreenTitle,
            summaryTitle: standardSummaryTitle,
            sectionTitle: .init(font: .title3, weight: .semibold),
            body: .init(font: .body, weight: .regular),
            bodyStrong: .init(font: .body, weight: .semibold),
            supporting: .init(font: .subheadline, weight: .regular),
            metadata: .init(
                font: .footnote,
                weight: .medium,
                design: .monospaced,
                tracking: 0.7
            ),
            caption: .init(
                font: .caption,
                weight: .medium,
                tracking: 0.2
            )
        )
    }

    private static var standardScreenTitle: TextStyle {
        #if os(iOS)
        .init(font: .largeTitle, weight: .bold)
        #else
        .init(font: .title2, weight: .bold)
        #endif
    }

    private static var standardSummaryTitle: TextStyle {
        #if os(iOS)
        .init(font: .title2, weight: .bold)
        #else
        .init(font: .title3, weight: .semibold)
        #endif
    }

    private static var standardPresentation: Presentation {
        .init(
            rowHorizontalInset: 24,
            rowVerticalPadding: 16,
            rowAccessorySpacing: 16,
            compactRowHorizontalInset: 20,
            compactRowVerticalPadding: 12,
            compactRowAccessorySpacing: 12,
            compactActionHorizontalPadding: 20,
            compactActionVerticalPadding: 12,
            regularKeyValueMinimumValueWidth: 160,
            compactKeyValueMinimumValueWidth: 120,
            compactKeyValueSpacing: 8,
            compactActionGroupSpacing: 12,
            screenCuePlacement: .leading,
            screenCueLength: 72,
            screenCueThickness: 2,
            sectionCuePlacement: .leading,
            sectionCueLength: 40,
            sectionCueThickness: 2
        )
    }

    private static var standardDivider: Divider {
        .init(
            thickness: 1,
            opacity: 0.75
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
                prefersGlass: false,
                fallbackColorRole: .surface,
                fallbackOpacity: 1,
                glassTintColorRole: nil,
                glassTintOpacity: 0,
                borderColorRole: .border,
                borderOpacity: 0.65
            ),
            elevated: .init(
                prefersGlass: false,
                fallbackColorRole: .surfaceElevated,
                fallbackOpacity: 1,
                glassTintColorRole: nil,
                glassTintOpacity: 0,
                borderColorRole: .border,
                borderOpacity: 0.8
            ),
            muted: .init(
                prefersGlass: false,
                fallbackColorRole: .surfaceMuted,
                fallbackOpacity: 1,
                glassTintColorRole: nil,
                glassTintOpacity: 0,
                borderColorRole: .border,
                borderOpacity: 0.35
            )
        )
    }

    /// Creates the standard MHUI theme using the host app's accent by default.
    ///
    /// The package supplies a neutral on-accent fallback. Use the overload that
    /// accepts `onAccent` when the app's accent needs another foreground.
    static func standard(
        accent: MHColorReference = .tint
    ) -> Self {
        standard(
            metrics: .standard,
            accent: accent,
            onAccent: .asset(MHColorAsset.onAccent)
        )
    }

    /// Creates the standard MHUI theme with an app-provided on-accent foreground.
    static func standard(
        onAccent: MHColorReference
    ) -> Self {
        standard(
            metrics: .standard,
            accent: .tint,
            onAccent: onAccent
        )
    }

    /// Creates the standard MHUI theme with app-provided metrics and an optional accent source.
    ///
    /// The package supplies a neutral on-accent fallback. Use the overload that
    /// accepts both colors when the app's accent needs another foreground.
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

    /// Creates the standard MHUI theme with an app-provided on-accent foreground.
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

    /// Creates the standard MHUI theme with app-provided metrics and colors.
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
            warning: .system(.warning),
            destructive: .system(.destructive)
        )
    }

    // swiftlint:enable no_magic_numbers
}
