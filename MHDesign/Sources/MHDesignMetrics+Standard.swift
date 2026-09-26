import CoreGraphics

public extension MHDesignMetrics {
    /// The default design baseline shared across MH sibling apps.
    static let standard = Self(
        spacing: platformSpacing,
        cornerRadius: .init(
            control: gridUnit * 1,
            surface: gridUnit * 1
        ),
        layout: .init(
            readableContentWidth: platformReadableContentWidth,
            compactWidthThreshold: platformCompactWidthThreshold,
            screen: platformScreenLayout,
            surface: platformSurfaceLayout,
            control: .init(
                minimumTouchTarget: platformMinimumControlTarget
            )
        )
    )
}

// swiftlint:disable no_magic_numbers
private extension MHDesignMetrics {
    static let gridUnit: CGFloat = 8

    static var platformSpacing: MHSpacingMetrics {
        #if os(watchOS)
        .init(inline: 8, control: 16, content: 24, section: 40, screen: 56)
        #else
        .init(inline: 8, control: 16, content: 24, section: 32, screen: 48)
        #endif
    }

    static var platformReadableContentWidth: CGFloat {
        #if os(watchOS)
        gridUnit * 40
        #else
        gridUnit * 80
        #endif
    }

    static var platformCompactWidthThreshold: CGFloat {
        #if os(watchOS)
        gridUnit * 38
        #else
        gridUnit * 80
        #endif
    }

    static var platformScreenLayout: MHScreenLayoutMetrics {
        #if os(watchOS)
        .init(
            contentInsetHorizontal: gridUnit * 2,
            contentInsetVertical: gridUnit * 2,
            contentSpacing: gridUnit * 2,
            compactContentInsetHorizontal: gridUnit * 2,
            compactContentInsetVertical: gridUnit * 2,
            compactContentSpacing: gridUnit * 2
        )
        #else
        .init(
            contentInsetHorizontal: gridUnit * 5,
            contentInsetVertical: gridUnit * 5,
            contentSpacing: gridUnit * 5,
            compactContentInsetHorizontal: gridUnit * 3,
            compactContentInsetVertical: gridUnit * 3,
            compactContentSpacing: gridUnit * 4
        )
        #endif
    }

    static var platformSurfaceLayout: MHSurfaceLayoutMetrics {
        #if os(watchOS)
        .init(
            insetHorizontal: gridUnit * 2,
            insetVertical: gridUnit * 2,
            compactInsetHorizontal: gridUnit * 2,
            compactInsetVertical: gridUnit * 2
        )
        #else
        .init(
            insetHorizontal: gridUnit * 3,
            insetVertical: gridUnit * 3,
            compactInsetHorizontal: gridUnit * 2,
            compactInsetVertical: gridUnit * 2
        )
        #endif
    }

    static var platformMinimumControlTarget: CGFloat {
        #if os(macOS)
        32
        #else
        48
        #endif
    }
}
// swiftlint:enable no_magic_numbers
