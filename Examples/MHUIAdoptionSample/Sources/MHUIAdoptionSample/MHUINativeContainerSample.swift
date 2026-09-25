import MHUI
import SwiftUI

/// Preserves native form controls and grouping on themed content surfaces.
public struct MHUINativeContainerSample: View {
    @State private var isEnabled = true
    @State private var note = ""

    public var body: some View {
        NavigationStack {
            Form {
                MHContainerContent {
                    overviewSection
                    noteSection
                }
            }
            .mhFormChrome(.content)
            .navigationTitle("Settings")
        }
    }

    public init() {
        // Uses the sample's initial control values.
    }
}

private extension MHUINativeContainerSample {
    var overviewSection: some View {
        Section {
            LabeledContent("Plan", value: "Personal")

            Toggle("Daily reminder", isOn: $isEnabled)
        } header: {
            MHSectionHeader("Overview")
        } footer: {
            Text("The app continues to own its data and interaction behavior.")
        }
    }

    var noteSection: some View {
        Section {
            TextField("Add a note", text: $note)

            Button("Continue") {
                // no-op
            }

            Button("Review later") {
                // no-op
            }
        } header: {
            MHSectionHeader("Note")
        }
    }
}
