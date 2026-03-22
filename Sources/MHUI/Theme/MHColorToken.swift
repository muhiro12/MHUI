import SwiftUI

/// Adaptive color ingredients used by MHUI themes.
struct MHColorToken: Sendable, Equatable {
    var light: MHColorComponents
    var dark: MHColorComponents

    internal func resolve(for colorScheme: ColorScheme) -> Color {
        switch colorScheme {
        case .dark:
            dark.color
        default:
            light.color
        }
    }
}
