import SwiftUI

/// RGBA values used to build adaptive SwiftUI colors.
public struct MHColorComponents: Sendable, Equatable {
    public var red: Double
    public var green: Double
    public var blue: Double
    public var opacity: Double

    internal var color: Color {
        .init(
            .sRGB,
            red: red,
            green: green,
            blue: blue,
            opacity: opacity
        )
    }

    public init(
        red: Double,
        green: Double,
        blue: Double,
        opacity: Double = 1
    ) {
        self.red = red
        self.green = green
        self.blue = blue
        self.opacity = opacity
    }

    // swiftlint:disable no_magic_numbers
    /// Creates RGBA values from an `0xRRGGBB` color code.
    public init(
        hex: UInt32,
        opacity: Double = 1
    ) {
        self.init(
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: opacity
        )
    }
    // swiftlint:enable no_magic_numbers
}
