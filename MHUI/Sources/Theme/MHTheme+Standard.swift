import MHDesign

public extension MHTheme {
    // swiftlint:disable no_magic_numbers
    /// The package-owned standard theme used by MHUI components.
    static let standard = standard()

    private static var standardTypography: Typography {
        .init(
            screenTitle: standardScreenTitle,
            sectionTitle: .init(font: .subheadline, weight: .medium),
            body: .init(font: .body, weight: .regular),
            bodyStrong: .init(font: .body, weight: .semibold),
            supporting: .init(font: .subheadline, weight: .regular),
            metadata: .init(
                font: .footnote,
                weight: .medium,
                design: .monospaced,
                tracking: 0.6
            ),
            caption: .init(
                font: .caption,
                weight: .regular,
                design: .monospaced,
                tracking: 0.2
            ),
            summaryTitle: standardSummaryTitle
        )
    }

    private static var standardScreenTitle: TextStyle {
        #if os(iOS)
        .init(font: .largeTitle, weight: .medium)
        #else
        .init(font: .title2, weight: .medium)
        #endif
    }

    private static var standardSummaryTitle: TextStyle {
        #if os(iOS)
        .init(font: .title2, weight: .medium)
        #else
        .init(font: .title3, weight: .medium)
        #endif
    }

    private static var standardPresentation: Presentation {
        .init(
            rowHorizontalInset: 28,
            rowVerticalPadding: 18,
            rowAccessorySpacing: 16,
            compactRowHorizontalInset: 20,
            compactRowVerticalPadding: 14,
            compactRowAccessorySpacing: 12,
            compactActionHorizontalPadding: 22,
            compactActionVerticalPadding: 12,
            regularKeyValueMinimumValueWidth: 160,
            compactKeyValueMinimumValueWidth: 120,
            compactKeyValueSpacing: 8,
            compactActionGroupSpacing: 12,
            screenCuePlacement: .top,
            screenCueLength: 0,
            screenCueThickness: 1,
            sectionCuePlacement: .top,
            sectionCueLength: 0,
            sectionCueThickness: 1
        )
    }

    private static var standardDivider: Divider {
        .init(
            thickness: 1,
            opacity: 0.32
        )
    }

    private static var standardMotion: Motion {
        .init(
            quick: 0.18,
            regular: 0.30
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
                borderOpacity: 0.14
            ),
            elevated: .init(
                prefersGlass: false,
                fallbackColorRole: .surfaceElevated,
                fallbackOpacity: 1,
                glassTintColorRole: nil,
                glassTintOpacity: 0,
                borderColorRole: .border,
                borderOpacity: 0.24
            ),
            muted: .init(
                prefersGlass: false,
                fallbackColorRole: .surfaceMuted,
                fallbackOpacity: 1,
                glassTintColorRole: nil,
                glassTintOpacity: 0,
                borderColorRole: .border,
                borderOpacity: 0
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
            warning: .asset(MHColorAsset.warning),
            destructive: .asset(MHColorAsset.destructive)
        )
    }

    // swiftlint:enable no_magic_numbers
}
