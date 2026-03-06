import SwiftUI

/// A semantic color source used by MHUI roles.
public enum MHColorReference: Sendable, Equatable {
    case adaptive(MHColorToken)
    case tint

    internal func resolve(for colorScheme: ColorScheme) -> Color {
        switch self {
        case .adaptive(let token):
            token.resolve(for: colorScheme)
        case .tint:
            .accentColor
        }
    }
}
