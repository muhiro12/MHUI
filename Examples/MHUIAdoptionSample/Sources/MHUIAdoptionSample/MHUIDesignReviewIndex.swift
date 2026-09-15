import MHUI
import SwiftUI

struct MHUIDesignReviewIndex: View {
    var body: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.section) {
            MHSummary(
                "Review representative states",
                metadata: "PUBLIC API",
                supporting: "Use real navigation to compare content density, empty states, and action hierarchy."
            )

            reviewRoutes
                .mhSection(
                    "States",
                    supporting: "These routes exercise the same theme without proposing separate design directions."
                )
        }
        .mhScreen(
            "Design Review",
            subtitle: "A public-consumer check for the complete MHUI experience."
        )
    }

    private var reviewRoutes: some View {
        MHGroupedRows {
            reviewLink(
                "Reading detail",
                supporting: "Long-form content beneath native navigation.",
                systemImage: "doc.text",
                destination: MHUIReadingSample()
            )

            reviewLink(
                "Empty state",
                supporting: "A quiet pause without decorative framing.",
                systemImage: "tray",
                destination: MHUIEmptyStateSample()
            )

            reviewLink(
                "Action hierarchy",
                supporting: "Primary, secondary, and quiet actions together.",
                systemImage: "cursorarrow.click.2",
                destination: MHUIActionHeavySample()
            )

            reviewLink(
                "Theme baseline",
                supporting: "Native controls with root theme values only.",
                systemImage: "circle.lefthalf.filled",
                destination: MHUIThemeOnlySample()
            )
        }
    }

    private func reviewLink<Destination: View>(
        _ title: LocalizedStringKey,
        supporting: LocalizedStringKey,
        systemImage: String,
        destination: Destination
    ) -> some View {
        NavigationLink {
            destination
        } label: {
            Label {
                VStack(alignment: .leading, spacing: MHTheme.standard.spacing.inline) {
                    Text(title)
                        .mhRowTitle()
                    Text(supporting)
                        .mhRowSupporting()
                }
            } icon: {
                Image(systemName: systemImage)
                    .mhForegroundStyle(.secondaryText)
            }
        }
    }
}
