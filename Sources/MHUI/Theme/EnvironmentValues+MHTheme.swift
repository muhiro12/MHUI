import SwiftUI

public extension EnvironmentValues {
    /// The active MHUI theme available to the current view subtree.
    var mhTheme: MHTheme {
        get {
            self[MHThemeKey.self]
        }
        set {
            self[MHThemeKey.self] = newValue
        }
    }
}
