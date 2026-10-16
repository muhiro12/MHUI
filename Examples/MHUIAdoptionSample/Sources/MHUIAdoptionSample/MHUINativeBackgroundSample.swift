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
                    NavigationLink {
                        Form {
                            MHContainerContent {
                                Toggle("Keep offline", isOn: .constant(true))
                            }
                        }
                        .mhFormChrome(background: .native)
                    } label: {
                        Text("Document")
                    }
                }
            }
            .mhListChrome(.content, background: .native)
        }
        .mhTheme(.standard)
    }
}
