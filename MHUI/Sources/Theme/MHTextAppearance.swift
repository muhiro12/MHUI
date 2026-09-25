import SwiftUI

/// Chooses the MHUI text hierarchy for a screen or subtree.
public enum MHTextAppearance: Sendable, Equatable {
    /// Uses the theme's text colors, adapting to prominent native backgrounds.
    case themed

    /// Uses the platform's foreground hierarchy.
    case native
}

extension EnvironmentValues {
    @Entry var mhTextAppearance: MHTextAppearance = .themed
}

public extension View {
    /// Chooses the foreground hierarchy used by MHUI text in this subtree.
    ///
    /// Native container chrome applies `.native` automatically. This does not
    /// override arbitrary SwiftUI controls or platform navigation titles.
    func mhTextAppearance(_ appearance: MHTextAppearance) -> some View {
        environment(\.mhTextAppearance, appearance)
    }
}
