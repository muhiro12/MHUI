import CoreGraphics

public extension MHDesignMetrics {
    // swiftlint:disable no_magic_numbers
    /// The default design baseline shared across MH sibling apps.
    static let standard = Self(
        spacing: .init(
            inline: gridUnit * 1,
            control: gridUnit * 2,
            group: gridUnit * 3,
            section: gridUnit * 4,
            screen: gridUnit * 5
        ),
        radius: .init(
            control: gridUnit * 1,
            surface: gridUnit * 2,
            pill: gridUnit * 1_000
        ),
        layout: .init(
            readableContentWidth: gridUnit * 80,
            compactWidthThreshold: gridUnit * 75,
            narrowWidthThreshold: gridUnit * 45,
            screenHorizontalMargin: gridUnit * 5,
            screenVerticalPadding: gridUnit * 9,
            screenContentSpacing: gridUnit * 6,
            compactScreenHorizontalMargin: gridUnit * 2,
            compactScreenVerticalPadding: gridUnit * 4,
            compactScreenContentSpacing: gridUnit * 3,
            surfaceInsetHorizontal: gridUnit * 3,
            surfaceInsetVertical: gridUnit * 3,
            compactSurfaceInsetHorizontal: gridUnit * 2,
            compactSurfaceInsetVertical: gridUnit * 2
        )
    )
    // swiftlint:enable no_magic_numbers
}

private extension MHDesignMetrics {
    static let gridUnit = 8.0
}
