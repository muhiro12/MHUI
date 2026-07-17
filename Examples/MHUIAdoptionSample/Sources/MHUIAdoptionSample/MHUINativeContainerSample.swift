import MHUI
import SwiftUI

/// Shows MHUI chrome applied around a native `Form` without replacing its controls.
public struct MHUINativeContainerSample: View {
    @State private var isEnabled = true
    @State private var note = ""

    public var body: some View {
        Form {
            overviewSection
            noteSection
        }
        .mhFormChrome(
            "Settings",
            subtitle: "Native container behavior with shared visual hierarchy."
        ) {
            MHSummary(
                "Native first",
                metadata: "FORM",
                supporting: "The host app keeps Form semantics while MHUI supplies the surrounding chrome."
            )
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
                supporting: "Section hierarchy stays consistent across native containers."
            )
        } footer: {
            MHSectionFooter("The app continues to own its data and interaction behavior.")
        }
    }

    var noteSection: some View {
        Section {
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
        } header: {
            MHSectionHeader(
                "Note",
                supporting: "Controls remain native while actions share package-owned fallback behavior."
            )
        }
    }
}
