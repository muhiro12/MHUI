import SwiftUI

struct MHResolvedActionButtonStyle: Sendable, Equatable {
    var backgroundStyle: MHResolvedGlassBackgroundStyle?
    var foregroundRole: MHColorRole
    var horizontalPadding: CGFloat
    var verticalPadding: CGFloat
    var minimumHeight: CGFloat
    var pressedOpacity: Double
    var disabledOpacity: Double
}
