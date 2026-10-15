import SwiftUI

struct MHContainerChromeModifier: ViewModifier {
    var style: MHContainerStyle = .content
    var background: MHContainerBackground = .themed

    func body(content: Content) -> some View {
        MHAdaptiveLayoutScope { _ in
            content
                .environment(\.mhContainerStyle, style)
                .scrollContentBackground(background == .themed ? .hidden : .visible)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .background {
                    if background == .themed {
                        MHCanvasBackground()
                    }
                }
        }
    }
}
