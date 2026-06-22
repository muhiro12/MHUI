import SwiftUI

struct MHSectionModifier<Accessory: View, Footer: View>: ViewModifier {
    @Environment(\.mhTheme)
    private var theme

    let title: Text
    let supporting: Text?
    let accessory: Accessory?
    let footer: Footer?

    private var headerBlock: some View {
        VStack(alignment: .leading, spacing: theme.resolvedSectionChromeStyle().contentSpacing) {
            HStack(alignment: .firstTextBaseline, spacing: theme.presentation.rowAccessorySpacing) {
                title
                    .mhSectionHeaderTitle()
                Spacer(minLength: theme.presentation.rowAccessorySpacing)
                if let accessory {
                    accessory
                }
            }
            if let supporting {
                supporting
                    .mhSectionHeaderSupporting()
            }
        }
        .mhSectionHeader()
    }

    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: theme.spacing.content) {
            headerBlock

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
