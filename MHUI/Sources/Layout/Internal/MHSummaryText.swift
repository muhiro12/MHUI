import SwiftUI

struct MHSummaryText: View {
    @Environment(\.mhTheme)
    private var theme

    let metadata: Text?
    let title: Text
    let supporting: Text?

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.control) {
            if let metadata {
                metadata
                    .mhTextStyle(.metadata, colorRole: .secondaryText)
            }

            VStack(alignment: .leading, spacing: theme.spacing.inline) {
                title
                    .mhTextStyle(.summaryTitle)
                    .accessibilityAddTraits(.isHeader)

                if let supporting {
                    supporting
                        .mhTextStyle(.supporting, colorRole: .secondaryText)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
