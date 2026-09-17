import SwiftUI

/// App-wide surface palettes sharing the same MHUI typography and treatments.
///
/// Each palette supplies light, dark, and increased-contrast appearances.
/// Accent and on-accent colors remain independent host-app inputs.
public enum MHPalette: String, CaseIterable, Sendable {
    /// The restrained neutral default.
    case mist
    /// Cool blue-gray surfaces.
    case slate
    /// Warm paper-like surfaces.
    case linen
    /// Muted green-gray surfaces.
    case sage

    internal func colorAsset(_ role: String) -> ColorResource {
        let prefix: String
        switch self {
        case .mist:
            prefix = "MH"
        case .slate:
            prefix = "MHSlate"
        case .linen:
            prefix = "MHLinen"
        case .sage:
            prefix = "MHSage"
        }
        return .init(name: prefix + role, bundle: .module)
    }
}
