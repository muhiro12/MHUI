import SwiftUI

/// Dynamic type friendly base styles used by MHUI typography.
public enum MHFontStyle: String, Sendable, CaseIterable {
    case title2
    case title3
    case body
    case subheadline
    case footnote
    case caption

    internal var font: Font {
        switch self {
        case .title2:
            .title2
        case .title3:
            .title3
        case .body:
            .body
        case .subheadline:
            .subheadline
        case .footnote:
            .footnote
        case .caption:
            .caption
        }
    }
}
