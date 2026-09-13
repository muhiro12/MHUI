// swiftlint:disable closure_body_length file_types_order no_magic_numbers one_declaration_per_file
import SwiftUI

// Directional studies, not accepted snapshots or app-owned screen components.
private struct MHGlassHarmonyPreview: View {
    @State private var isMarked = false

    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Clothing")
                            .mhTextStyle(.supporting, colorRole: .secondaryText)
                        Text(isMarked ? "Marked Today" : "Not marked")
                            .mhTextStyle(.summaryTitle)
                        Text("The one I reach for on cold mornings.")
                            .mhTextStyle(.supporting, colorRole: .secondaryText)
                    }
                    .padding(.vertical, 8)
                }

                Section {
                    MHGlassHarmonyPhotoPreview()
                        .listRowInsets(EdgeInsets())
                }

                Section("History") {
                    LabeledContent("This month", value: "9 marks")
                    LabeledContent("Last marked", value: "Yesterday")
                }
            }
            .mhListChrome()
            .navigationTitle("Black Wool Coat")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItemGroup(placement: .primaryAction) {
                    Button("Edit", systemImage: "pencil") {
                        // Preview only.
                    }
                    Button("Share", systemImage: "square.and.arrow.up") {
                        // Preview only.
                    }
                }
            }
            .safeAreaInset(edge: .bottom) {
                MHActionGroup(layout: .vertical) {
                    Button {
                        isMarked.toggle()
                    } label: {
                        Label(
                            isMarked ? "Undo Today's Mark" : "Mark Today",
                            systemImage: "checkmark.circle"
                        )
                    }
                    .buttonStyle(.mhPrimary)

                    Button("Adjust History", systemImage: "calendar") {
                        // Preview only.
                    }
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
            }
        }
    }
}

private struct MHGlassHarmonyPhotoPreview: View {
    var body: some View {
        Image(systemName: "tshirt.fill")
            .font(.system(size: 72))
            .foregroundStyle(Color(MHPreviewColorAsset.foregroundLight))
            .frame(maxWidth: .infinity)
            .frame(height: 230)
            .background(Color(MHPreviewColorAsset.teal))
            .accessibilityLabel("Sample clothing image")
    }
}

private struct MHGlassHarmonyFormPreview: View {
    @State private var name = "Black Wool Coat"
    @State private var reminderEnabled = true
    @State private var reviewAfterDays = 14

    var body: some View {
        NavigationStack {
            Form {
                Section("Item") {
                    TextField("Name", text: $name)
                    LabeledContent("Category", value: "Clothing")
                }

                Section {
                    Toggle("Daily reminder", isOn: $reminderEnabled)
                    Stepper("Review after \(reviewAfterDays) days", value: $reviewAfterDays, in: 1 ... 30)
                } header: {
                    Text("Review")
                } footer: {
                    Text("A quiet reminder to notice the things you use.")
                }
            }
            .mhFormChrome()
            .navigationTitle("Edit Item")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        // Preview only.
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        // Preview only.
                    }
                }
            }
        }
    }
}

#Preview("Direction / Glass Harmony / Detail / Light", traits: .fixedLayout(width: 390, height: 844)) {
    MHGlassHarmonyPreview()
        .mhPreviewTint()
}

#Preview("Direction / Glass Harmony / Detail / Dark", traits: .fixedLayout(width: 390, height: 844)) {
    MHGlassHarmonyPreview()
        .mhPreviewTint(MHPreviewStyle.context(colorMode: .dark))
}

#Preview("Direction / Glass Harmony / Native Form", traits: .fixedLayout(width: 390, height: 844)) {
    MHGlassHarmonyFormPreview()
        .mhPreviewTint()
}

#Preview("Direction / Glass Harmony / Detail / Accessibility", traits: .fixedLayout(width: 390, height: 1_180)) {
    MHGlassHarmonyPreview()
        .mhPreviewTint(MHPreviewStyle.context(typeScale: .accessibility))
}

#Preview("Direction / Glass Harmony / Detail / Opaque Fallback", traits: .fixedLayout(width: 390, height: 844)) {
    MHGlassHarmonyPreview()
        .mhPreviewTint(MHPreviewStyle.context(glassPolicy: .disabled))
}
// swiftlint:enable closure_body_length file_types_order no_magic_numbers one_declaration_per_file
