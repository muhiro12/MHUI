import SwiftUI

struct MHResolvedTextStyle: Sendable, Equatable {
    var metrics: MHTextMetrics
    var colorRole: MHColorRole
    var design: Font.Design
    var size: CGFloat
    var tracking: CGFloat
}
