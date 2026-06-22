import SwiftUI

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
