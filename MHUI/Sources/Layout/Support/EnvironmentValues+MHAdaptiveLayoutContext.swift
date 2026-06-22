import SwiftUI

extension EnvironmentValues {
    var mhAdaptiveLayoutContext: MHAdaptiveLayoutContext {
        get {
            self[MHAdaptiveLayoutContextKey.self]
        }
        set {
            self[MHAdaptiveLayoutContextKey.self] = newValue
        }
    }
}
