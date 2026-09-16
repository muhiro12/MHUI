import SwiftUI

struct MHContainerChromeModifier: ViewModifier {
    var background: MHContainerBackground = .theme

    func body(content: Content) -> some View {
        MHAdaptiveLayoutScope { _ in
            content
                .scrollContentBackground(background == .theme ? .hidden : .automatic)
                .background {
                    if background == .theme {
                        MHCanvasBackground()
                    }
                }
        }
    }
}
