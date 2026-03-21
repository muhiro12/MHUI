import SwiftUI

struct MHResolvedGlassBackgroundStyle: Sendable, Equatable {
    var usesGlass: Bool
    var fallbackFillRole: MHColorRole?
    var fallbackFillOpacity: Double
    var glassTintRole: MHColorRole?
    var glassTintOpacity: Double
    var borderRole: MHColorRole?
    var borderOpacity: Double
}
