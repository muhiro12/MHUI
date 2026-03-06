import SwiftUI

// swiftlint:disable no_magic_numbers

/// Built-in accent styles that apps can apply to the standard MHUI theme.
public enum MHAccentStyle: String, Sendable, CaseIterable {
    case orange
    case blue
    case green
    case red
    case purple
}

internal extension MHAccentStyle {
    var colorReference: MHColorReference {
        .adaptive(
            .init(
                light: lightComponents,
                dark: darkComponents
            )
        )
    }

    private var lightComponents: MHColorComponents {
        switch self {
        case .orange:
            .init(red: 0.93, green: 0.43, blue: 0.10)
        case .blue:
            .init(red: 0.14, green: 0.45, blue: 0.90)
        case .green:
            .init(red: 0.10, green: 0.58, blue: 0.36)
        case .red:
            .init(red: 0.82, green: 0.22, blue: 0.24)
        case .purple:
            .init(red: 0.45, green: 0.30, blue: 0.86)
        }
    }

    private var darkComponents: MHColorComponents {
        switch self {
        case .orange:
            .init(red: 1.00, green: 0.70, blue: 0.28)
        case .blue:
            .init(red: 0.45, green: 0.68, blue: 1.00)
        case .green:
            .init(red: 0.39, green: 0.82, blue: 0.55)
        case .red:
            .init(red: 1.00, green: 0.45, blue: 0.46)
        case .purple:
            .init(red: 0.72, green: 0.57, blue: 1.00)
        }
    }
}
// swiftlint:enable no_magic_numbers
