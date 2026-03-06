@testable import MHUI
import SwiftUI
import Testing

struct MHComponentSmokeTests {
    @Test
    @MainActor
    func public_components_instantiate() {
        let smokeView = AnyView(
            MHScreen(
                title: "Foundation",
                subtitle: "Quiet composition"
            ) {
                MHSectionBlock("Section") {
                    MHRowGroup {
                        MHListRow(
                            "Tokens",
                            subtitle: "Typography and spacing"
                        )
                        MHKeyValueRow("Theme", value: "Standard")
                    }
                }

                MHSurface {
                    HStack {
                        MHBadge("Accent", style: .accent)
                        MHBadge("Quiet", style: .neutral)
                    }
                }

                MHEmptyState(
                    "Empty",
                    message: "No content",
                    symbolSystemName: "tray"
                ) {
                    Button("Create") {
                        // no-op
                    }
                    .buttonStyle(MHActionButtonStyle(role: .secondary))
                }

                TextField("Name", text: .constant(""))
                    .mhInputChrome(state: .focused)
            }
        )

        #expect(!String(reflecting: type(of: smokeView)).isEmpty)
    }
}
