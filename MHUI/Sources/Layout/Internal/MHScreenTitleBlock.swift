import SwiftUI

struct MHScreenTitleBlock: View {
    @Environment(\.mhTheme)
    private var theme
    let title: Text?
    let subtitle: Text?

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.control) {
            if let title {
                title
                    .mhTextStyle(.screenTitle)
                    .accessibilityAddTraits(.isHeader)
            }
            if let subtitle {
                subtitle
                    .mhTextStyle(.supporting, colorRole: .secondaryText)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
