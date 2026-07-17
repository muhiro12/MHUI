import SwiftUI

/// A semantic color source used by MHUI roles.
public struct MHColorReference: Sendable, Equatable {
    private enum Storage: Sendable, Equatable {
        case tint
        case asset(ColorResource)
    }

    /// Uses the host app's accent color without installing a tint override.
    public static let tint = Self(storage: .tint)

    private let storage: Storage

    /// Uses a color managed by an asset catalog.
    public static func asset(
        _ asset: ColorResource
    ) -> Self {
        Self(storage: .asset(asset))
    }

    internal func resolve(for _: ColorScheme) -> Color {
        switch storage {
        case .tint:
            .accentColor
        case let .asset(resource):
            Color(resource)
        }
    }

    internal func nativeTintOverride(
        for colorScheme: ColorScheme
    ) -> Color? {
        switch storage {
        case .tint:
            nil
        default:
            resolve(for: colorScheme)
        }
    }
}
