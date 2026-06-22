import SwiftUI

struct MHResolvedActionPresentation: Sendable, Equatable {
    var lineLimit: Int?
    var usesFixedHorizontalSize: Bool
    var expandsHorizontally: Bool
    var alignment: Alignment
    var allowsTightening: Bool
}
