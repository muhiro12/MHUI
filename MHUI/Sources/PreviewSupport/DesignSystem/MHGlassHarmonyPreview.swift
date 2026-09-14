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
                        Text("Archive")
                            .mhTextStyle(.supporting, colorRole: .secondaryText)
                        Text(isMarked ? "Marked Today" : "Not marked")
                            .mhTextStyle(.summaryTitle)
                        Text("A quiet record held in changing light.")
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
            .navigationTitle("Field Note")
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
            .mhPreviewActionBar {
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

private extension View {
    @ViewBuilder
    func mhPreviewActionBar<Bar: View>(
        @ViewBuilder content: () -> Bar
    ) -> some View {
        let bar = content()

        #if os(iOS)
        if #available(iOS 26, *) {
            safeAreaBar(edge: .bottom) {
                bar
            }
        } else {
            safeAreaInset(edge: .bottom) {
                bar
            }
        }
        #else
        safeAreaInset(edge: .bottom) {
            bar
        }
        #endif
    }
}

private struct MHGlassHarmonyPhotoPreview: View {
    var body: some View {
        Image(systemName: "photo.on.rectangle.angled")
            .font(.system(size: 64, weight: .light))
            .mhForegroundStyle(.primaryText)
            .opacity(0.64)
            .frame(maxWidth: .infinity)
            .frame(height: 230)
            .background(Color(MHPreviewColorAsset.atmosphericMedia))
            .accessibilityLabel("Sample archive image")
    }
}

private struct MHGlassHarmonyFormPreview: View {
    @State private var name = "Field Note"
    @State private var reminderEnabled = true
    @State private var reviewAfterDays = 14

    var body: some View {
        NavigationStack {
            Form {
                Section("Item") {
                    TextField("Name", text: $name)
                    LabeledContent("Category", value: "Archive")
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

#Preview("Direction / Atmospheric Continuity / Detail / Light", traits: .fixedLayout(width: 390, height: 844)) {
    MHGlassHarmonyPreview()
        .mhPreviewTint()
}

#Preview("Direction / Atmospheric Continuity / Detail / Dark", traits: .fixedLayout(width: 390, height: 844)) {
    MHGlassHarmonyPreview()
        .mhPreviewTint(MHPreviewStyle.context(colorMode: .dark))
}

#Preview("Direction / Atmospheric Continuity / Native Form", traits: .fixedLayout(width: 390, height: 844)) {
    MHGlassHarmonyFormPreview()
        .mhPreviewTint()
}

#Preview("Direction / Atmospheric Continuity / Accessibility", traits: .fixedLayout(width: 390, height: 1_180)) {
    MHGlassHarmonyPreview()
        .mhPreviewTint(MHPreviewStyle.context(typeScale: .accessibility))
}

#Preview("Direction / Atmospheric Continuity / Fallback", traits: .fixedLayout(width: 390, height: 844)) {
    MHGlassHarmonyPreview()
        .mhPreviewTint(MHPreviewStyle.context(glassPolicy: .disabled))
}
// swiftlint:enable closure_body_length file_types_order no_magic_numbers one_declaration_per_file
