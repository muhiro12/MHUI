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
        .mhTheme(MHUIAdoptionSampleTheme.standard)
    }

    public init() {
        // Uses the sample's initial control values.
    }
}

private extension MHUIComposedScreenSample {
    var summary: some View {
        MHSummary(
            "Review settings",
            metadata: "OVERVIEW",
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
                metadata: "01",
                title: "Overview",
                supporting: "The leading feature establishes the screen's primary context."
            )
        } supporting: {
            MHUIFeatureSample(
                metadata: "02",
                title: "Status",
                supporting: "Supporting content stays concise."
            )

            MHUIFeatureSample(
                metadata: "03",
                title: "Actions",
                supporting: "Native controls keep their platform behavior."
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
