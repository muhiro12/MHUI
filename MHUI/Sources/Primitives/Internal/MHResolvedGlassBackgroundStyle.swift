import SwiftUI

struct MHResolvedGlassBackgroundStyle: Sendable, Equatable {
    var usesGlass: Bool
    var fallbackFillRole: MHColorRole?
    var accentFallbackFillOpacity: Double?
    var glassTintRole: MHColorRole?
    var accentGlassTintOpacity: Double?
    var borderRole: MHColorRole?
    var accentBorderOpacity: Double?
}
