import SwiftUI

struct MHFeatureGridResizingPreview: View {
    private struct Editor: View {
        @State private var note = ""
        @State private var count = 0

        let title: String

        var body: some View {
            VStack(alignment: .leading) {
                Text(title)
                    .mhTextStyle(.sectionTitle)
                TextField("Note", text: $note)
                    .mhInputChrome()
                Button("Count: \(count)", systemImage: "plus") {
                    count += 1
                }
                .buttonStyle(.mhSecondary)
            }
            .mhSurfaceInset()
            .mhSurface()
        }
    }

    var body: some View {
        NavigationStack {
            MHFeatureGrid {
                Editor(title: "Lead")
            } supporting: {
                Editor(title: "First")
                Editor(title: "Second")
            }
            .mhScreen(
                "Resizing",
                subtitle: "Edit notes and counts, then resize or change text size."
            )
        }
        .mhTheme(.standard)
    }
}

#Preview("Feature Grid / Resizing") {
    MHFeatureGridResizingPreview()
}
