import MHUI
import SwiftUI
import Testing

@MainActor
struct MHSectionOverloadTests {
    @Test
    func footer_and_accessory_calls_compile_after_trailing_closure_formatting() {
        let sections: [AnyView] = [
            AnyView(Text("Content").mhSectionWithFooter(title: Text("Ideas")) {
                Text("Footer")
            }),
            AnyView(Text("Content").mhSectionWithFooter("Ideas", supporting: "Notes") {
                Text("Footer")
            }),
            AnyView(Text("Content").mhSection(title: Text("Ideas")) {
                Image(systemName: "star")
            }),
            AnyView(Text("Content").mhSection("Ideas", supporting: "Notes") {
                Image(systemName: "star")
            }),
            AnyView(Text("Content").mhSection(title: Text("Ideas")) {
                Image(systemName: "star")
            } footer: {
                Text("Footer")
            }),
            AnyView(Text("Content").mhSection("Ideas") {
                Image(systemName: "star")
            } footer: {
                Text("Footer")
            })
        ]
        #expect(!sections.isEmpty)
    }
}
