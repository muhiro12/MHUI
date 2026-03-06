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
}
