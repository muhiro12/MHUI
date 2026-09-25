import SwiftUI

struct MHContainerChromeModifier: ViewModifier {
    func body(content: Content) -> some View {
        MHAdaptiveLayoutScope { _ in
            content
                .environment(\.mhContainerStyle, .content)
                .scrollContentBackground(.hidden)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .background {
                    MHCanvasBackground()
                }
        }
    }
}
