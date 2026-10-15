import MHUI
import SwiftUI

struct MHUINativeBackgroundSample: View {
    var body: some View {
        NavigationSplitView {
            VStack {
                Text("Library")
            }
            .mhScreen(background: .native)
        } detail: {
            List {
                MHContainerContent {
                    Text("Document")
                }
            }
            .mhListChrome(.content, background: .native)
        }
        .mhTheme(.standard)
    }
}
