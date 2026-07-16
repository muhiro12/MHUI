import SwiftUI

/// System font designs available to MHUI typography tokens.
public enum MHFontDesign: String, Sendable, Equatable, CaseIterable {
    /// The platform's standard system font design.
    case standard

    /// The platform's monospaced system font design.
    case monospaced

    internal var fontDesign: Font.Design {
        switch self {
        case .standard:
            .default
        case .monospaced:
            .monospaced
        }
    }
}
