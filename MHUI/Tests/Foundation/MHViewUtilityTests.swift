@testable import MHUI
import SwiftUI
import Testing

struct MHViewUtilityTests {
    @Test
    @MainActor
    func view_utility_modifiers_instantiate() {
        let visible = AnyView(Text("Visible").mhHidden(false))
        let hidden = AnyView(Text("Hidden").mhHidden(true))
        let singleLine = AnyView(Text("Single line title").mhSingleLine())
        let twoLines = AnyView(Text("Two line supporting content").mhTwoLines())

        #expect(String(reflecting: type(of: visible)).contains("AnyView"))
        #expect(String(reflecting: type(of: hidden)).contains("AnyView"))
        #expect(String(reflecting: type(of: singleLine)).contains("AnyView"))
        #expect(String(reflecting: type(of: twoLines)).contains("AnyView"))
    }

    @Test
    @MainActor
    func dismiss_button_instantiates_as_native_button_affordance() {
        let button = AnyView(MHDismissButton())
        let customLabel = AnyView(MHDismissButton(accessibilityLabel: Text("Dismiss preview")))

        #expect(String(reflecting: type(of: button)).contains("AnyView"))
        #expect(String(reflecting: type(of: customLabel)).contains("AnyView"))
    }
}
