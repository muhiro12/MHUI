import SwiftUI

private struct MHThemedNativeReviewPreview: View {
    @State private var isEnabled = true
    @State private var name = "Personal"
    @State private var items = ["First", "Second"]

    let isForm: Bool

    var body: some View {
        NavigationStack {
            Group {
                if isForm {
                    Form {
                        settingsContent
                    }
                    .mhFormChrome(.native)
                } else {
                    List {
                        settingsContent
                    }
                    .mhListChrome(.native)
                }
            }
            .navigationTitle("Settings")
        }
        .mhTheme(.standard)
    }

    private var settingsContent: some View {
        MHContainerContent {
            Section("Preferences") {
                TextField("Name", text: $name)
                Toggle("Daily reminder", isOn: $isEnabled)
                LabeledContent("Plan", value: "Personal")
                Text("Themed explanation")
                    .mhForegroundStyle(.secondaryText)
            }
            Section("Management") {
                Button("Export") {
                    // Preview action.
                }
                Button("Delete", role: .destructive) {
                    // Preview action.
                }
                Button("Unavailable") {
                    // Preview action.
                }
                .disabled(true)
            }
            Section("Order") {
                ForEach(items, id: \.self) { item in
                    Text(item)
                }
                .onMove { source, destination in
                    items.move(fromOffsets: source, toOffset: destination)
                }
                .onDelete { offsets in
                    items.remove(atOffsets: offsets)
                }
            }
        }
    }

    init(isForm: Bool = false) {
        self.isForm = isForm
        #if os(iOS)
        MHTheme.standard.configureNavigationTitleAppearance()
        #endif
    }
}

#Preview("Themed native settings") {
    MHThemedNativeReviewPreview()
}

#Preview("Themed native form") {
    MHThemedNativeReviewPreview(isForm: true)
}

#Preview("Aligned action styles") {
    VStack {
        MHActionGroup(layout: .vertical) {
            Button("Duplicate", systemImage: "document.on.document") {
                // Preview action.
            }
            .buttonStyle(.mhQuiet)
            Button("Delete", systemImage: "trash", role: .destructive) {
                // Preview action.
            }
            .buttonStyle(.mhDestructive)
        }
        MHActionGroup(layout: .horizontal) {
            Button("Duplicate", systemImage: "document.on.document") {
                // Preview action.
            }
            .buttonStyle(.mhQuiet)
            Button("Delete", systemImage: "trash", role: .destructive) {
                // Preview action.
            }
            .buttonStyle(.mhDestructive)
        }
    }
    .mhScreen("Actions", titlePlacement: .content)
    .mhTheme(.standard)
}
