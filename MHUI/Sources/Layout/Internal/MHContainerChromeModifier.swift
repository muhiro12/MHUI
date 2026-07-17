import SwiftUI

struct MHContainerChromeModifier: ViewModifier {
    func body(content: Content) -> some View {
        MHAdaptiveLayoutScope { _ in
            content
                .scrollContentBackground(.hidden)
                .background(MHCanvasBackground())
        }
    }
}
