import SwiftUI

public extension View {
    /// Applies MHUI container support without selecting a list style or overriding row metrics.
    ///
    /// Use `.system` to retain the contextual platform background, especially in sidebars.
    /// The default `.theme` preserves the existing MHUI canvas treatment. Neither option
    /// changes row insets, section typography, separators, or selection appearance.
    func mhListChrome(background: MHContainerBackground = .theme) -> some View {
        modifier(MHContainerChromeModifier(background: background))
    }

    /// Applies MHUI container support without selecting a form style or overriding row metrics.
    ///
    /// Use `.system` for platform-owned backgrounds. Keep standard controls, `LabeledContent`,
    /// and `Section` text when the form should also retain native row and header styling.
    func mhFormChrome(background: MHContainerBackground = .theme) -> some View {
        modifier(MHContainerChromeModifier(background: background))
    }
}
