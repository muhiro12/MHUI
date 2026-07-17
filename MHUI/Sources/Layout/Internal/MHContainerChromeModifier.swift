import SwiftUI

struct MHContainerChromeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scrollContentBackground(.hidden)
            .background(MHCanvasBackground())
    }
}
