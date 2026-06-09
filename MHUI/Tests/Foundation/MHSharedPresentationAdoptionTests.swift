import MHUI
import SwiftUI
import Testing

struct MHSharedPresentationAdoptionTests {
    @Test
    @MainActor
    func shared_presentation_utilities_are_available_from_public_import() {
        let adjustedColor = Color.red.mhAdjusted(by: 50)
        let view = AnyView(
            VStack {
                Text("Primary")
                    .mhSingleLine()
                Text("Supporting")
                    .mhTwoLines()
                Rectangle()
                    .fill(adjustedColor)
                    .mhHidden(false)
                MHDismissButton()
            }
        )

        #expect(String(reflecting: type(of: view)).contains("AnyView"))
    }

    @Test
    @MainActor
    func migrated_swiftutilities_presentation_call_sites_compile_with_mhui_only() {
        let view = AnyView(
            VStack {
                MHDismissButton(accessibilityLabel: Text("Close sheet"))

                Text("A compact title that should stay on one line")
                    .mhSingleLine(minimumScaleFactor: 0.75)

                Text("Supporting copy that can wrap once without app-local helpers")
                    .mhTwoLines(minimumScaleFactor: 0.65)

                Rectangle()
                    .fill(Color.blue.mhAdjusted(by: 25))
                    .mhHidden(true)

                Text("Hidden by default")
                    .mhHidden()
            }
        )

        #expect(String(reflecting: type(of: view)).contains("AnyView"))
    }

    @Test
    @MainActor
    func common_sibling_app_presentation_patterns_compile_with_mhui_only() {
        let view = AnyView(
            NavigationStack {
                List {
                    Text("Upcoming balance")
                        .mhSingleLine()

                    Text("Optional focus hint")
                        .mhHidden(false)
                }
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        MHDismissButton()
                    }
                }
            }
        )

        #expect(String(reflecting: type(of: view)).contains("AnyView"))
    }
}
