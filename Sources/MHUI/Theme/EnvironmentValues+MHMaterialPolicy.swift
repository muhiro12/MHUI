import SwiftUI

public extension EnvironmentValues {
    /// The active MHUI material policy for the current view subtree.
    var mhMaterialPolicy: MHMaterialPolicy {
        get {
            self[MHMaterialPolicyKey.self]
        }
        set {
            self[MHMaterialPolicyKey.self] = newValue
        }
    }
}
