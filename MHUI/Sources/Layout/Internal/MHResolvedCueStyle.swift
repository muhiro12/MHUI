import SwiftUI

struct MHResolvedCueStyle: Sendable, Equatable {
    var colorRole: MHColorRole
    var placement: MHCuePlacement
    var length: CGFloat
    var thickness: CGFloat
    var spacing: CGFloat

    var isVisible: Bool {
        length > 0 && thickness > 0
    }
}
