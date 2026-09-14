import SwiftUI

struct MHSectionHeaderModifier: ViewModifier {
    @Environment(\.mhTheme)
    private var theme

    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, theme.spacing.inline)
            .textCase(nil)
    }
}
