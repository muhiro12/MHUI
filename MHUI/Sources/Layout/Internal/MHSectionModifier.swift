import SwiftUI

struct MHSectionModifier<Accessory: View, Footer: View>: ViewModifier {
    @Environment(\.mhTheme)
    private var theme

    let title: Text
    let supporting: Text?
    let accessory: Accessory?
    let footer: Footer?

    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: theme.spacing.inline) {
            MHSectionHeader(
                title: title,
                supporting: supporting,
                accessory: accessory
            )
            // This header belongs to the stack, even inside a native row.
            .environment(\.mhContainerStyle, nil)

            content

            if let footer {
                footer
                    .mhSectionFooterText()
            }
        }
    }
}
