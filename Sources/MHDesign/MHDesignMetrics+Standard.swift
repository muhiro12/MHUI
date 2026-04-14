import CoreGraphics

public extension MHDesignMetrics {
    // swiftlint:disable no_magic_numbers
    /// The default design baseline shared across MH sibling apps.
    static let standard = Self(
        spacing: .init(
            inline: gridUnit * 1,
            control: gridUnit * 2,
            content: gridUnit * 3,
            section: gridUnit * 4,
            screen: gridUnit * 5
        ),
        cornerRadius: .init(
            control: gridUnit * 1,
            surface: gridUnit * 2
        ),
        layout: .init(
            readableContentWidth: gridUnit * 80,
            compactWidthThreshold: gridUnit * 75,
            screen: .init(
                contentInsetHorizontal: gridUnit * 5,
                contentInsetVertical: gridUnit * 9,
                contentSpacing: gridUnit * 6,
                compactContentInsetHorizontal: gridUnit * 2,
                compactContentInsetVertical: gridUnit * 4,
                compactContentSpacing: gridUnit * 3
            ),
            surface: .init(
                insetHorizontal: gridUnit * 3,
                insetVertical: gridUnit * 3,
                compactInsetHorizontal: gridUnit * 2,
                compactInsetVertical: gridUnit * 2
            ),
            control: .init(
                minimumTouchTarget: 44
            )
        )
    )
    // swiftlint:enable no_magic_numbers
}

private extension MHDesignMetrics {
    static let gridUnit: CGFloat = 8
}
