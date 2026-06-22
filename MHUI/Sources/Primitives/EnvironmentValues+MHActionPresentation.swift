import SwiftUI

public extension EnvironmentValues {
    /// The active MHUI action presentation policy for the current view subtree.
    var mhActionPresentation: MHActionPresentation {
        get {
            self[MHActionPresentationKey.self]
        }
        set {
            self[MHActionPresentationKey.self] = newValue
        }
    }
}
