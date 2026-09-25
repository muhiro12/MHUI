import SwiftUI

public extension View {
    /// Applies the MHUI canvas while preserving native list rows, sections, and style.
    ///
    /// Use native controls and section text without additional MHUI row decoration.
    /// Omit this modifier for fully system-owned containers, including split-view sidebars.
    func mhListChrome() -> some View {
        modifier(MHContainerChromeModifier())
    }

    /// Applies the MHUI canvas while preserving native form controls, sections, and style.
    ///
    /// The root theme supplies the colors. No per-screen visual tuning is needed.
    func mhFormChrome() -> some View {
        modifier(MHContainerChromeModifier())
    }
}
