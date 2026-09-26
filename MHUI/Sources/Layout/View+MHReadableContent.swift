import SwiftUI

private struct MHReadableContentModifier: ViewModifier {
    @Environment(\.mhTheme)
    private var theme

    func body(content: Content) -> some View {
        content
            .frame(maxWidth: theme.layout.readableContentWidth, alignment: .leading)
    }
}

public extension View {
    /// Limits prose to the theme's readable width within the available space.
    ///
    /// Apply to reading content inside a screen, leaving images and grids free
    /// to use the full column. This modifier does not add scrolling or margins.
    func mhReadableContent() -> some View {
        modifier(MHReadableContentModifier())
    }
}
