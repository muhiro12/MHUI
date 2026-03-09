import SwiftUI

struct MHAdaptiveLayoutScope<Content: View>: View {
    @Environment(\.horizontalSizeClass)
    private var horizontalSizeClass

    let content: (MHAdaptiveLayoutContext) -> Content

    var body: some View {
        GeometryReader { geometry in
            let context = MHAdaptiveLayoutContext(
                availableWidth: geometry.size.width,
                horizontalSizeClass: horizontalSizeClass
            )

            content(context)
                .environment(\.mhAdaptiveLayoutContext, context)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .topLeading
                )
        }
    }
}
