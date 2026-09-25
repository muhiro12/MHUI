import MHUI
import SwiftUI

/// Exercises native navigation, deletion, and reordering with styled rows.
public struct MHUIContentContainerSample: View {
    @State private var documents = ["Field notes", "Reading list", "Project index"]

    private let style: MHContainerStyle

    public var body: some View {
        List {
            MHContainerContent {
                Section {
                    MHSummary(
                        "A place for everyday work",
                        metadata: "Your collection",
                        supporting: "Notes, reading, and projects worth returning to."
                    )
                    .listRowSeparator(.hidden)
                }
                Section {
                    ForEach(documents, id: \.self) { title in
                        NavigationLink(value: title) {
                            VStack(alignment: .leading) {
                                Text(title).mhRowTitle()
                                Text("Updated today").mhRowSupporting()
                            }
                        }
                    }
                    .onDelete(perform: delete)
                    .onMove(perform: move)
                } header: {
                    MHSectionHeader("In use", supporting: "Keep what matters close.")
                }
            }
        }
        .mhListChrome(style)
        .navigationTitle("Collection")
        .navigationDestination(for: String.self) { title in
            MHUIContentFormSample(style: style)
                .navigationTitle(title)
        }
        #if os(iOS)
        .toolbar {
            EditButton()
        }
        #endif
    }

    public init(style: MHContainerStyle = .content) {
        self.style = style
    }

    private func delete(at offsets: IndexSet) {
        documents.remove(atOffsets: offsets)
    }

    private func move(from offsets: IndexSet, to destination: Int) {
        documents.move(fromOffsets: offsets, toOffset: destination)
    }
}
