import SwiftUI

public extension View {
    /// Overrides how MHUI key-value rows fall back under width pressure.
    func mhKeyValueLayout(
        _ policy: MHKeyValueLayoutPolicy
    ) -> some View {
        environment(\.mhKeyValueLayout, policy)
    }
}
