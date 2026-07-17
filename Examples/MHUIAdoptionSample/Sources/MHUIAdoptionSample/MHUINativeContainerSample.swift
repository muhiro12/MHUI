import MHUI
import SwiftUI

/// Shows the secondary bridge for a screen that requires native `Form` semantics.
public struct MHUINativeContainerSample: View {
    @State private var isEnabled = true
    @State private var note = ""

    public var body: some View {
        NavigationStack {
            Form {
                overviewSection
                noteSection
            }
            .mhFormChrome()
            .navigationTitle("Settings")
        }
        .mhTheme(MHUIAdoptionSampleTheme.standard)
    }

    public init() {
        // Uses the sample's initial control values.
    }
}

private extension MHUINativeContainerSample {
    var overviewSection: some View {
        Section {
            LabeledContent("Plan", value: "Personal")
                .labeledContentStyle(.mhKeyValue)

            Toggle("Daily reminder", isOn: $isEnabled)
                .mhRow()
        } header: {
            MHSectionHeader(
                "Overview",
                supporting: "Use the native bridge only when its container semantics matter."
            )
        } footer: {
            MHSectionFooter("The app continues to own its data and interaction behavior.")
        }
    }

    var noteSection: some View {
        Section {
            TextField("Add a note", text: $note)

            MHActionGroup {
                Button("Continue") {
                    // no-op
                }
                .buttonStyle(.mhPrimary)

                Button("Review later") {
                    // no-op
                }
            }
        } header: {
            MHSectionHeader(
                "Note",
                supporting: "Controls remain native while actions share package-owned fallback behavior."
            )
        }
    }
}
