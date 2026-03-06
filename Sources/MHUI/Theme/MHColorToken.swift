import SwiftUI

/// Adaptive color ingredients used by MHUI themes.
public struct MHColorToken: Sendable, Equatable {
    public var light: MHColorComponents
    public var dark: MHColorComponents

    public init(
        light: MHColorComponents,
        dark: MHColorComponents
    ) {
        self.light = light
        self.dark = dark
    }

    internal func resolve(for colorScheme: ColorScheme) -> Color {
        switch colorScheme {
        case .dark:
            dark.color
        default:
            light.color
        }
    }
}
