import SwiftUI

extension EnvironmentValues {
    var mhRowChromeScope: MHRowChromeScope {
        get {
            self[MHRowChromeScopeKey.self]
        }
        set {
            self[MHRowChromeScopeKey.self] = newValue
        }
    }
}
