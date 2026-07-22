import CoreGraphics

public extension MHDesignMetrics {
    // swiftlint:disable no_magic_numbers
    /// The default design baseline shared across MH sibling apps.
    static let standard = Self(
        spacing: .init(
            inline: gridUnit * 1,
            control: gridUnit * 2,
            content: gridUnit * 3,
            section: gridUnit * 5,
            screen: gridUnit * 7
        ),
        cornerRadius: .init(
            control: gridUnit * 1,
            surface: gridUnit * 0.75
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
    // swiftlint:enable no_magic_numbers
}

// swiftlint:disable no_magic_numbers
private extension MHDesignMetrics {
    static let gridUnit: CGFloat = 8

    static var platformReadableContentWidth: CGFloat {
        #if os(watchOS)
        gridUnit * 40
        #else
        gridUnit * 90
        #endif
    }

    static var platformCompactWidthThreshold: CGFloat {
        #if os(watchOS)
        gridUnit * 37.5
        #else
        gridUnit * 80
        #endif
    }

    static var platformScreenLayout: MHScreenLayoutMetrics {
        #if os(watchOS)
        .init(
            contentInsetHorizontal: gridUnit * 2,
            contentInsetVertical: gridUnit * 2.5,
            contentSpacing: gridUnit * 2,
            compactContentInsetHorizontal: gridUnit * 1.5,
            compactContentInsetVertical: gridUnit * 1.5,
            compactContentSpacing: gridUnit * 1.5
        )
        #else
        .init(
            contentInsetHorizontal: gridUnit * 7,
            contentInsetVertical: gridUnit * 8,
            contentSpacing: gridUnit * 7,
            compactContentInsetHorizontal: gridUnit * 3,
            compactContentInsetVertical: gridUnit * 5,
            compactContentSpacing: gridUnit * 4.5
        )
        #endif
    }

    static var platformSurfaceLayout: MHSurfaceLayoutMetrics {
        #if os(watchOS)
        .init(
            insetHorizontal: gridUnit * 1.5,
            insetVertical: gridUnit * 1.5,
            compactInsetHorizontal: gridUnit * 1.5,
            compactInsetVertical: gridUnit * 1.5
        )
        #else
        .init(
            insetHorizontal: gridUnit * 3.5,
            insetVertical: gridUnit * 3,
            compactInsetHorizontal: gridUnit * 2.5,
            compactInsetVertical: gridUnit * 2.25
        )
        #endif
    }

    static var platformMinimumControlTarget: CGFloat {
        #if os(macOS)
        28
        #else
        44
        #endif
    }
}
// swiftlint:enable no_magic_numbers
