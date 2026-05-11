import SwiftUI

/// A semantic color source used by MHUI roles.
public struct MHColorReference: Sendable, Equatable {
    private enum Storage: Sendable, Equatable {
        case tint
        case asset(name: String)
        case fixed(light: MHColorComponents, dark: MHColorComponents)
    }

    public static let tint = Self(storage: .tint)

    private let storage: Storage

    public static func fixed(
        lightHex: UInt32,
        darkHex: UInt32,
        lightOpacity: Double = 1,
        darkOpacity: Double = 1
    ) -> Self {
        Self(
            storage: .fixed(
                light: .init(
                    hex: lightHex,
                    opacity: lightOpacity
                ),
                dark: .init(
                    hex: darkHex,
                    opacity: darkOpacity
                )
            )
        )
    }

    static func adaptive(
        light: MHColorComponents,
        dark: MHColorComponents
    ) -> Self {
        Self(
            storage: .fixed(
                light: light,
                dark: dark
            )
        )
    }

    static func asset(
        name: String
    ) -> Self {
        Self(storage: .asset(name: name))
    }

    internal func resolve(for colorScheme: ColorScheme) -> Color {
        switch storage {
        case .tint:
            .accentColor
        case let .asset(name):
            Color(name, bundle: .module)
        case let .fixed(light, dark):
            switch colorScheme {
            case .dark:
                dark.color
            default:
                light.color
            }
        }
    }
}
