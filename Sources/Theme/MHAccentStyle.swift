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
            .init(hex: 0xED6E1A)
        case .blue:
            .init(hex: 0x2473E6)
        case .green:
            .init(hex: 0x1A945C)
        case .red:
            .init(hex: 0xD1383D)
        case .purple:
            .init(hex: 0x734DDB)
        }
    }

    private var darkComponents: MHColorComponents {
        switch self {
        case .orange:
            .init(hex: 0xFFB347)
        case .blue:
            .init(hex: 0x73ADFF)
        case .green:
            .init(hex: 0x63D18C)
        case .red:
            .init(hex: 0xFF7375)
        case .purple:
            .init(hex: 0xB891FF)
        }
    }
}
// swiftlint:enable no_magic_numbers
