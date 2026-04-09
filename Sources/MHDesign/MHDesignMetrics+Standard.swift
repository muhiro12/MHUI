public extension MHDesignMetrics {
    // swiftlint:disable no_magic_numbers
    /// The default design baseline shared across MH sibling apps.
    static let standard = Self(
        spacing: .init(
            inline: 8,
            control: 16,
            group: 24,
            section: 32,
            screen: 40
        ),
        radius: .init(
            control: 8,
            surface: 16,
            pill: 999
        ),
        layout: .init(
            readableContentWidth: 640,
            compactWidthThreshold: 600,
            narrowWidthThreshold: 360,
            screenHorizontalMargin: 40,
            screenVerticalPadding: 72,
            screenContentSpacing: 48,
            compactScreenHorizontalMargin: 16,
            compactScreenVerticalPadding: 32,
            compactScreenContentSpacing: 24,
            surfaceInsetHorizontal: 24,
            surfaceInsetVertical: 24,
            compactSurfaceInsetHorizontal: 16,
            compactSurfaceInsetVertical: 16,
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
    )
    // swiftlint:enable no_magic_numbers
}
