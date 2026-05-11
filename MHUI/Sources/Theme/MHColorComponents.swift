import SwiftUI

/// RGBA values used to build adaptive SwiftUI colors.
struct MHColorComponents: Sendable, Equatable {
    var red: Double
    var green: Double
    var blue: Double

    internal var color: Color {
        .init(
            red: red,
            green: green,
            blue: blue
        )
    }

    init(
        red: Double,
        green: Double,
        blue: Double
    ) {
        self.red = red
        self.green = green
        self.blue = blue
    }

    // swiftlint:disable no_magic_numbers
    /// Creates RGB values from an `0xRRGGBB` color code.
    init(
        hex: UInt32
    ) {
        self.init(
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255
        )
    }
    // swiftlint:enable no_magic_numbers
}
