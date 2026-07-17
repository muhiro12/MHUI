import MHUI
import SwiftUI

/// Shows what root theme configuration changes without adopting MHUI composition.
public struct MHUIThemeOnlySample: View {
    @State private var isEnabled = true
    @State private var note = ""

    public var body: some View {
        Form {
            overviewSection
            noteSection
            actionsSection
        }
        .mhTheme(MHUIAdoptionSampleTheme.standard)
    }

    public init() {
        // Uses the sample's initial control values.
    }
}

private extension MHUIThemeOnlySample {
    var overviewSection: some View {
        Section("Overview") {
            LabeledContent("Plan", value: "Personal")
            Toggle("Daily reminder", isOn: $isEnabled)
        }
    }

    var noteSection: some View {
        Section("Note") {
            TextField("Add a note", text: $note)
        }
    }

    var actionsSection: some View {
        Section("Actions") {
            Button("Continue") {
                // no-op
            }

            Button("Review later") {
                // no-op
            }
        }
    }
}
