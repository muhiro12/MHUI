import SwiftUI

/// Apple platform system colors that are useful as interface accents.
public enum MHSystemColor: String, Sendable, CaseIterable, Identifiable {
    case red
    case orange
    case yellow
    case green
    case mint
    case teal
    case cyan
    case blue
    case indigo
    case purple
    case pink
    case brown
    case gray

    public var id: String {
        rawValue
    }

    public var color: Color {
        switch self {
        case .red:
            .red
        case .orange:
            .orange
        case .yellow:
            .yellow
        case .green:
            .green
        case .mint:
            .mint
        case .teal:
            .teal
        case .cyan:
            .cyan
        case .blue:
            .blue
        case .indigo:
            .indigo
        case .purple:
            .purple
        case .pink:
            .pink
        case .brown:
            .brown
        case .gray:
            .gray
        }
    }

    var title: String {
        rawValue.capitalized
    }
}
