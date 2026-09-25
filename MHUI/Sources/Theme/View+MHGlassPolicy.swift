import SwiftUI

public extension View {
    /// Overrides whether MHUI action buttons may use Liquid Glass in the current view subtree.
    func mhGlassPolicy(
        _ policy: MHGlassPolicy
    ) -> some View {
        environment(\.mhGlassPolicy, policy)
    }
}
