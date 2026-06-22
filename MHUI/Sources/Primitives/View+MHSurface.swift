import SwiftUI

public extension View {
    /// Applies calm surface chrome without changing the wrapped layout.
    func mhSurface(role: MHSurfaceRole = .standard) -> some View {
        modifier(MHSurfaceModifier(role: role))
    }

    /// Applies the standard interior inset used for grouped surfaces.
    func mhSurfaceInset() -> some View {
        modifier(MHSurfaceInsetModifier())
    }
}
