import MHUI
import SwiftUI

/// Uses MHUI presentation while retaining native list navigation and form controls.
public struct MHUIContentContainerSample: View {
    public var body: some View {
        List {
            Section {
                MHSummary(
                    "A place for everyday work",
                    metadata: "3 documents",
                    supporting: "Notes, reading, and projects worth returning to."
                )
                .mhRow()
                .listRowSeparator(.hidden)
            }
            Section {
                ForEach(["Field notes", "Reading list", "Project index"], id: \.self) { title in
                    NavigationLink {
                        MHUIContentFormSample()
                            .navigationTitle(title)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(title).mhRowTitle()
                            Text("Updated today").mhRowSupporting()
                        }
                    }
                    .mhRow()
                }
            } header: {
                MHSectionHeader("In use", supporting: "Keep what matters close.")
            }
        }
        .mhListChrome(.content)
        .navigationTitle("Collection")
    }

    public init() {
        // Uses stable, immutable example identities.
    }
}
