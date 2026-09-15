import MHUI
import SwiftUI

struct MHUIEmptyStateSample: View {
    var body: some View {
        ContentUnavailableView {
            Label("Nothing queued", systemImage: "tray")
        } description: {
            Text("New items will appear here without introducing another decorative container.")
        } actions: {
            Button("Create Item") {
                // no-op
            }
            .buttonStyle(.mhPrimary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .mhScreen("Queue")
    }
}
