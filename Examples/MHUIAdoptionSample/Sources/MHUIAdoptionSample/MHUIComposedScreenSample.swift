import MHUI
import SwiftUI

/// Shows the primary signature composition for an MHUI-forward screen.
public struct MHUIComposedScreenSample: View {
    @Environment(\.mhTheme)
    private var theme

    @State private var isEnabled = true
    @State private var note = ""

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.section) {
            summary
            featureGrid
            overviewSection
            noteSection
        }
        .mhScreen(
            "Settings",
            subtitle: "The primary MHUI composition with an app-owned accent."
        )
    }

    public init() {
        // Uses the sample's initial control values.
    }
}

private extension MHUIComposedScreenSample {
    var summary: some View {
        MHSummary(
            "Review settings",
            metadata: "Overview",
            supporting: "A focused hierarchy distinguishes the screen without replacing native controls."
        ) {
            Text("Ready")
                .mhBadge(style: .accent)
        }
    }

    var overviewSection: some View {
        MHGroupedRows {
            LabeledContent("Plan", value: "Personal")
                .labeledContentStyle(.mhKeyValue)

            Toggle("Daily reminder", isOn: $isEnabled)
        }
        .mhSection(
            "Overview",
            supporting: "Grouped rows own their shared rhythm and separators."
        )
    }

    var featureGrid: some View {
        MHFeatureGrid {
            MHUIFeatureSample(
                metadata: "Storage",
                title: "2.4 GB of 5 GB",
                supporting: "Documents and photos stay in sync across your devices."
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
            supporting: "A leading feature and supporting content adapt as one composition."
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
        .mhSection(
            "Note",
            supporting: "Explicit primary emphasis pairs with the group's secondary default."
        )
    }
}
