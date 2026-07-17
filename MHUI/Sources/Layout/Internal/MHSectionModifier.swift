import SwiftUI

struct MHSectionModifier<Accessory: View, Footer: View>: ViewModifier {
    @Environment(\.mhTheme)
    private var theme

    let title: Text
    let supporting: Text?
    let accessory: Accessory?
    let footer: Footer?

    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: theme.spacing.content) {
            MHSectionHeader(
                title: title,
                supporting: supporting,
                accessory: accessory
            )

            content
                .mhSurfaceInset()
                .mhSurface()

            if let footer {
                footer
                    .mhSectionFooterText()
            }
        }
    }
}
