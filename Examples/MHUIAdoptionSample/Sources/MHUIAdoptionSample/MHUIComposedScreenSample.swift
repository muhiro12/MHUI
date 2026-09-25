import MHUI
import SwiftUI

/// Shows the primary signature composition for an MHUI-forward screen.
public struct MHUIComposedScreenSample: View {
    @Environment(\.mhTheme)
    private var theme

    @State private var isEnabled = true
    @State private var note = ""

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.screen) {
            summary
            featureGrid
            overviewSection
            noteSection
        }
        .mhScreen(
            "Library",
            subtitle: "Useful things, kept in one place."
        )
    }

    public init() {
        // Uses the sample's initial control values.
    }
}

private extension MHUIComposedScreenSample {
    var summary: some View {
        MHSummary(
            "Ready for the week ahead",
            metadata: "Overview",
            supporting: "Your documents are up to date and available across your devices."
        )
    }

    var overviewSection: some View {
        MHGroupedRows {
            LabeledContent("Plan", value: "Personal")
                .labeledContentStyle(.mhKeyValue)

            Toggle("Daily reminder", isOn: $isEnabled)
        }
        .mhSection(
            "Overview",
            supporting: "Access and reminders for this collection."
        )
    }

    var featureGrid: some View {
        MHFeatureGrid {
            MHUIFeatureSample(
                metadata: "Storage",
                title: "2.4 GB of 5 GB",
                supporting: "Documents and photos stay in sync across your devices.",
                isLead: true
            )
        } supporting: {
            MHUIFeatureSample(
                metadata: "Devices",
                title: "3 connected",
                supporting: "Last synced a minute ago."
            )

            MHUIFeatureSample(
                metadata: "Backup",
                title: "Today at 9:41",
                supporting: "Runs nightly on Wi-Fi."
            )
        }
        .mhSection(
            "Highlights",
            supporting: "Space, devices, and your latest backup."
        )
    }

    var noteSection: some View {
        VStack(alignment: .leading, spacing: theme.spacing.control) {
            TextField("Add a note", text: $note)
                .mhInputChrome()

            MHActionGroup {
                Button("Continue") {
                    // no-op
                }
                .buttonStyle(.mhPrimary)

                Button("Review later") {
                    // no-op
                }
            }
        }
        .mhSurfaceInset()
        .mhSurface(role: .muted)
        .mhSection(
            "Note",
            supporting: "Leave a reminder for your next visit."
        )
    }
}
