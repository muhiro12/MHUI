import SwiftUI

struct MHResolvedFeatureGridStyle: Sendable, Equatable {
    enum Arrangement: Sendable, Equatable {
        case split
        case stacked
    }

    var arrangement: Arrangement
    var primarySpacing: CGFloat
    var supportingSpacing: CGFloat
    var supportingColumnCount: Int
    var supportingColumnWidth: CGFloat
}
