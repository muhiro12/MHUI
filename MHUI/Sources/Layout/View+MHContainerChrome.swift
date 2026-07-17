import SwiftUI

public extension View {
    /// Applies the MHUI canvas to a native `List` without changing its viewport or list style.
    func mhListChrome() -> some View {
        modifier(MHContainerChromeModifier())
    }

    /// Applies the MHUI canvas to a native `Form` without changing its viewport or form style.
    func mhFormChrome() -> some View {
        modifier(MHContainerChromeModifier())
    }
}
