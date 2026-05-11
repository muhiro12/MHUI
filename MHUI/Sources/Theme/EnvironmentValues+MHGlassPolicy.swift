import SwiftUI

public extension EnvironmentValues {
    /// The active MHUI glass policy for the current view subtree.
    var mhGlassPolicy: MHGlassPolicy {
        get {
            self[MHGlassPolicyKey.self]
        }
        set {
            self[MHGlassPolicyKey.self] = newValue
        }
    }
}
