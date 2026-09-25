import MHUI
import SwiftUI

struct MHUIFeatureSample: View {
    let metadata: LocalizedStringKey
    let title: LocalizedStringKey
    let supporting: LocalizedStringKey
    var isLead = false

    var body: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.inline) {
            Text(metadata)
                .mhTextStyle(.metadata, colorRole: .secondaryText)

            Text(title)
                .mhTextStyle(isLead ? .summaryTitle : .bodyStrong)

            Text(supporting)
                .mhTextStyle(.supporting, colorRole: .secondaryText)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
