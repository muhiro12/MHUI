import MHUI
import SwiftUI

/// Chooses content presentation for an editor independently of its native Form behavior.
public struct MHUIContentFormSample: View {
    @State private var name = "Field notes"
    @State private var keepsOffline = true

    public var body: some View {
        Form {
            Section {
                TextField("Name", text: $name)
                    .mhRow()
                Toggle("Keep offline", isOn: $keepsOffline)
                    .mhRow()
                LabeledContent("Documents", value: "3")
                    .labeledContentStyle(.mhKeyValue)
                    .mhRow()
            } header: {
                MHSectionHeader("Collection", supporting: "Your working copy")
            }
        }
        .formStyle(.grouped)
        .mhFormChrome(.content)
    }

    public init() {
        // State belongs to the example, not to MHUI.
    }
}
