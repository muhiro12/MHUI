public extension MHDesignMetrics {
    // swiftlint:disable no_magic_numbers
    /// The default design baseline shared across MH sibling apps.
    static let standard = Self(
        spacing: .init(
            inline: 4,
            control: 12,
            group: 20,
            section: 32,
            screen: 40
        ),
        radius: .init(
            control: 8,
            surface: 12,
            pill: 999
        ),
        layout: .init(
            readableContentWidth: 640,
            compactWidthThreshold: 600,
            narrowWidthThreshold: 360,
            screenHorizontalMargin: 40,
            screenVerticalPadding: 72,
            screenContentSpacing: 44,
            compactScreenHorizontalMargin: 16,
            compactScreenVerticalPadding: 32,
            compactScreenContentSpacing: 24,
            surfaceInsetHorizontal: 20,
            surfaceInsetVertical: 24,
            compactSurfaceInsetHorizontal: 14,
            compactSurfaceInsetVertical: 16,
            rowHorizontalInset: 20,
            rowVerticalPadding: 16,
            rowAccessorySpacing: 12,
            compactRowHorizontalInset: 14,
            compactRowVerticalPadding: 12,
            compactRowAccessorySpacing: 10,
            compactActionHorizontalPadding: 12,
            compactActionVerticalPadding: 9,
            regularKeyValueMinimumValueWidth: 160,
            compactKeyValueMinimumValueWidth: 120,
            compactKeyValueSpacing: 8,
            compactActionGroupSpacing: 8,
            screenCueWidth: 20,
            screenCueHeight: 2,
            sectionCueWidth: 12,
            sectionCueHeight: 2
        )
    )
    // swiftlint:enable no_magic_numbers
}
