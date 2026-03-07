import SwiftUI

public extension View {
    /// Overrides whether MHUI surfaces may use material in the current view subtree.
    func mhMaterialPolicy(
        _ policy: MHMaterialPolicy
    ) -> some View {
        environment(\.mhMaterialPolicy, policy)
    }
}
