import SwiftUI

#if os(iOS)
private struct MHNativeSplitViewPreview: View {
    @State private var category: String? = "General"
    @State private var selection: String? = "Account"
    @State private var name = "Personal"
    @State private var notificationsEnabled = true

    var body: some View {
        NavigationSplitView(columnVisibility: .constant(.all)) {
            List(["General", "Privacy"], id: \.self, selection: $category) { category in
                NavigationLink(category, value: category)
            }
            .navigationTitle("Settings")
        } content: {
            List(["Account", "Notifications"], id: \.self, selection: $selection) { item in
                NavigationLink(item, value: item)
            }
            .mhListChrome()
            .navigationTitle(category ?? "Settings")
        } detail: {
            Form {
                Section("Preferences") {
                    TextField("Name", text: $name)
                    Toggle("Notifications", isOn: $notificationsEnabled)
                    LabeledContent("Account", value: "Personal")
                }
                Section {
                    Text("Native selection, row spacing, and section hierarchy remain system-owned.")
                }
            }
            .mhFormChrome()
            .navigationTitle(selection ?? "Account")
        }
        .mhTheme(.standard)
    }
}

// swiftlint:disable no_magic_numbers
@available(iOS 26.0, *)
#Preview(
    "Native Styles / Split View",
    traits: .fixedLayout(width: 1_194, height: 834)
) {
    MHNativeSplitViewPreview()
}
// swiftlint:enable no_magic_numbers
#endif
