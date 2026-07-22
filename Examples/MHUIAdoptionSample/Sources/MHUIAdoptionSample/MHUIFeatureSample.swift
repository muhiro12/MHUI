import MHUI
import SwiftUI

struct MHUIFeatureSample: View {
    let metadata: LocalizedStringKey
    let title: LocalizedStringKey
    let supporting: LocalizedStringKey

    var body: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.inline) {
            Text(metadata)
                .mhTextStyle(.metadata, colorRole: .tertiaryText)

            Text(title)
                .mhTextStyle(.bodyStrong)

            Text(supporting)
                .mhTextStyle(.supporting, colorRole: .secondaryText)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .mhSurfaceInset()
        .mhSurface(role: .muted)
    }
}
