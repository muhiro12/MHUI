import SwiftUI

struct MHSummaryLayout<Accessory: View>: View {
    @Environment(\.mhTheme)
    private var theme

    let metadata: Text?
    let title: Text
    let supporting: Text?
    let accessory: Accessory?

    @ViewBuilder var body: some View {
        if let accessory {
            ViewThatFits(in: .horizontal) {
                HStack(alignment: .top, spacing: theme.spacing.content) {
                    MHSummaryText(
                        metadata: metadata,
                        title: title,
                        supporting: supporting
                    )

                    Spacer(minLength: theme.spacing.control)

                    accessory
                }

                VStack(alignment: .leading, spacing: theme.spacing.content) {
                    MHSummaryText(
                        metadata: metadata,
                        title: title,
                        supporting: supporting
                    )

                    accessory
                }
            }
        } else {
            MHSummaryText(
                metadata: metadata,
                title: title,
                supporting: supporting
            )
        }
    }
}
