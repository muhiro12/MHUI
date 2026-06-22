import SwiftUI

struct MHResolvedGlassBackgroundStyle: Sendable, Equatable {
    var usesGlass: Bool
    var fallbackFillRole: MHColorRole?
    var fallbackFillOpacity: Double
    var glassTintRole: MHColorRole?
    var glassTintOpacity: Double
    var isGlassInteractive: Bool
    var borderRole: MHColorRole?
    var borderOpacity: Double
}
