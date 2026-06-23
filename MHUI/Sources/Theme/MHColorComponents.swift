import SwiftUI

/// RGBA values used to build adaptive SwiftUI colors.
struct MHColorComponents: Sendable, Equatable {
    var red: Double
    var green: Double
    var blue: Double
    var opacity: Double

    internal var color: Color {
        .init(
            .sRGB,
            red: red,
            green: green,
            blue: blue,
            opacity: opacity
        )
    }

    init(
        red: Double,
        green: Double,
        blue: Double,
        opacity: Double
    ) {
        self.red = red
        self.green = green
        self.blue = blue
        self.opacity = opacity
    }

    // swiftlint:disable no_magic_numbers
    /// Creates RGBA values from an `0xRRGGBB` color code.
    init(
        hex: UInt32,
        opacity: Double
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
