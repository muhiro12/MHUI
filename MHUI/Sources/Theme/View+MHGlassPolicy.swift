import SwiftUI

public extension View {
    /// Overrides whether MHUI chrome may use Liquid Glass in the current view subtree.
    func mhGlassPolicy(
        _ policy: MHGlassPolicy
    ) -> some View {
        environment(\.mhGlassPolicy, policy)
    }
}
