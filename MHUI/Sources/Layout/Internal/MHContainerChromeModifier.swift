import SwiftUI

struct MHContainerChromeModifier: ViewModifier {
    var style: MHContainerStyle = .content

    func body(content: Content) -> some View {
        MHAdaptiveLayoutScope { _ in
            content
                .environment(\.mhContainerStyle, style)
                .scrollContentBackground(.hidden)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .background {
                    MHCanvasBackground()
                }
        }
    }
}
