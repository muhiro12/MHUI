import SwiftUI

/// A semantic color source used by MHUI roles.
public struct MHColorReference: Sendable, Equatable {
    private enum Storage: Sendable, Equatable {
        case tint
        case asset(ColorResource)
        case fixed(light: MHColorComponents, dark: MHColorComponents)
    }

    public static let tint = Self(storage: .tint)

    private let storage: Storage

    public static func fixed(
        lightHex: UInt32,
        darkHex: UInt32
    ) -> Self {
        Self(
            storage: .fixed(
                light: .init(hex: lightHex),
                dark: .init(hex: darkHex)
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
        _ asset: ColorResource
    ) -> Self {
        Self(storage: .asset(asset))
    }

    internal func resolve(for colorScheme: ColorScheme) -> Color {
        switch storage {
        case .tint:
            .accentColor
        case let .asset(resource):
            Color(resource)
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
