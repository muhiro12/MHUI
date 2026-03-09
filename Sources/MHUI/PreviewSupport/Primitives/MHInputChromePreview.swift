import SwiftUI

#Preview("Input Chrome", traits: .sizeThatFitsLayout) {
    VStack(spacing: MHTheme.standard.spacing.group) {
        TextField("Name", text: .constant(""))
            .mhInputChrome()
        TextField("Focused", text: .constant("Focused"))
            .mhInputChrome(state: .focused)
        TextEditor(text: .constant("Validation message owned by the app."))
            .frame(height: 120)
            .mhInputChrome(state: .invalid)
    }
    .mhPreviewSurface()
}
