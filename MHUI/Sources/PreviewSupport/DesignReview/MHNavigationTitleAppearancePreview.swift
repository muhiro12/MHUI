import SwiftUI

#if os(iOS)
private struct MHNavigationTitleAppearancePreview: View {
    var body: some View {
        NavigationStack {
            Form {
                Section("Preferences") {
                    Toggle("Keep offline", isOn: .constant(true))
                    NavigationLink("Open detail") {
                        Text("A native inline title")
                            .navigationTitle("Detail")
                            .navigationBarTitleDisplayMode(.inline)
                    }
                }
            }
            .mhFormChrome(.native)
            .navigationTitle("Preferences")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Add", systemImage: "plus") {
                        // Preview-only action.
                    }
                }
            }
        }
        .mhTheme(.standard)
    }
}

#Preview("Native Navigation Title Color") {
    MHTheme.standard.configureNavigationTitleAppearance()
    return MHNavigationTitleAppearancePreview()
}
#endif
