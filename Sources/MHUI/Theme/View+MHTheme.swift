import SwiftUI

public extension View {
    /// Overrides the active MHUI theme for the current view subtree.
    func mhTheme(_ theme: MHTheme) -> some View {
        environment(\.mhTheme, theme)
    }
}
