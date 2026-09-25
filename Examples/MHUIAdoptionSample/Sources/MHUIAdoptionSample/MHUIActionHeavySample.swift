import MHUI
import SwiftUI

struct MHUIActionHeavySample: View {
    @Environment(\.mhTheme)
    private var theme

    @State private var notificationsEnabled = true
    @State private var automaticReviewEnabled = false

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.section) {
            MHSummary(
                "Ready to publish",
                metadata: "3 changes",
                supporting: "One action leads. Alternatives remain available without competing for attention."
            ) {
                Text("Draft")
                    .mhBadge(style: .accent)
            }

            MHGroupedRows {
                Toggle("Notify collaborators", isOn: $notificationsEnabled)
                Toggle("Review automatically", isOn: $automaticReviewEnabled)
            }
            .mhSection("Options")

            MHActionGroup {
                Button("Publish") {
                    // no-op
                }
                .buttonStyle(.mhPrimary)

                Button("Save Draft") {
                    // no-op
                }
                .buttonStyle(.mhSecondary)

                Button("Discard") {
                    // no-op
                }
                .buttonStyle(.mhQuiet)
            }
            .mhSection(
                "Actions",
                supporting: "The group adapts at compact widths and accessibility text sizes."
            )
        }
        .mhScreen("Publish")
        .toolbar {
            Menu("More", systemImage: "ellipsis.circle") {
                Button("Duplicate", systemImage: "plus.square.on.square") {
                    // no-op
                }
                Button("Archive", systemImage: "archivebox") {
                    // no-op
                }
            }
        }
    }
}
