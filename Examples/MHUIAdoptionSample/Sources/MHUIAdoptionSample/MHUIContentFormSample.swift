import MHUI
import SwiftUI

/// Chooses presentation independently of native form behavior.
public struct MHUIContentFormSample: View {
    @State private var name = "Field notes"
    @State private var keepsOffline = true

    private let style: MHContainerStyle

    public var body: some View {
        Form {
            MHContainerContent {
                Section {
                    TextField("Name", text: $name)
                    Toggle("Keep offline", isOn: $keepsOffline)
                    LabeledContent("Documents", value: "3")
                } header: {
                    MHSectionHeader("Collection", supporting: "Your working copy")
                }
            }
        }
        .formStyle(.grouped)
        .mhFormChrome(style)
    }

    public init(style: MHContainerStyle = .content) {
        self.style = style
    }
}
