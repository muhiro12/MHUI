// swiftlint:disable file_types_order one_declaration_per_file
import SwiftUI

/// Width-sensitive layout choices for MHUI key-value rows.
public enum MHKeyValueLayoutPolicy: String, Sendable, CaseIterable {
    case automatic
    case horizontal
    case vertical
}

private struct MHKeyValueLayoutPolicyKey: EnvironmentKey {
    static let defaultValue = MHKeyValueLayoutPolicy.automatic
}

public extension EnvironmentValues {
    /// The active MHUI key-value layout policy for the current view subtree.
    var mhKeyValueLayout: MHKeyValueLayoutPolicy {
        get {
            self[MHKeyValueLayoutPolicyKey.self]
        }
        set {
            self[MHKeyValueLayoutPolicyKey.self] = newValue
        }
    }
}

public extension View {
    /// Overrides how MHUI key-value rows fall back under width pressure.
    func mhKeyValueLayout(
        _ policy: MHKeyValueLayoutPolicy
    ) -> some View {
        environment(\.mhKeyValueLayout, policy)
    }
}
// swiftlint:enable file_types_order one_declaration_per_file
