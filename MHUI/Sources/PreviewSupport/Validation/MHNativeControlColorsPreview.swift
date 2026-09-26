import SwiftUI

private struct MHNativeControlColorsPreview: View {
    @State private var isEnabled = true
    @State private var name = "Personal"
    let theme: MHTheme

    var body: some View {
        TabView {
            Tab("Settings", systemImage: "gearshape") {
                NavigationStack {
                    Form {
                        settingsContent
                    }
                    .mhFormChrome(.native)
                    .navigationTitle("Settings")
                    .toolbar {
                        Button("Add", systemImage: "plus") {
                            // Preview action.
                        }
                    }
                }
            }
            Tab("Library", systemImage: "books.vertical") {
                Text("Library").mhRowTitle()
            }
        }
        .mhTheme(theme)
    }

    private var settingsContent: some View {
        MHContainerContent {
            Section("Preferences") {
                Toggle("Daily reminder", isOn: $isEnabled)
                Toggle("Disabled reminder", isOn: .constant(true))
                    .disabled(true)
                TextField("Name", text: $name)
                LabeledContent("Plan", value: "Personal")
            }
            Section("Actions") {
                Button("Export", systemImage: "square.and.arrow.up") {
                    // Preview action.
                }
                Button("Delete", role: .destructive) {
                    // Preview action.
                }
                Button("Unavailable") {
                    // Preview action.
                }
                .disabled(true)
                Button("Prominent action") {
                    // Preview action.
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }

    init(theme: MHTheme = .standard) {
        self.theme = theme
        #if os(iOS)
        theme.configureNativeAppearance()
        #endif
    }
}

#Preview("Native control colors") {
    MHNativeControlColorsPreview()
}

#Preview("Branded native control colors") {
    MHNativeControlColorsPreview(theme: .standard(accent: .asset(MHPreviewColorAsset.hostAccent)))
}
