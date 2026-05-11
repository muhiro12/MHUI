import SwiftUI

/// Font weights used by MHUI typography tokens.
enum MHFontWeight: String, Sendable, CaseIterable {
    case regular
    case medium
    case semibold
    case bold

    internal var fontWeight: Font.Weight {
        switch self {
        case .regular:
            .regular
        case .medium:
            .medium
        case .semibold:
            .semibold
        case .bold:
            .bold
        }
    }
}
