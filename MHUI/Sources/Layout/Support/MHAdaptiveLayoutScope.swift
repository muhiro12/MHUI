import SwiftUI

struct MHAdaptiveLayoutScope<Content: View>: View {
    @Environment(\.horizontalSizeClass)
    private var horizontalSizeClass
    @Environment(\.dynamicTypeSize)
    private var dynamicTypeSize

    let content: (MHAdaptiveLayoutContext) -> Content

    var body: some View {
        GeometryReader { geometry in
            let context = MHAdaptiveLayoutContext(
                availableWidth: geometry.size.width,
                horizontalSizeClass: horizontalSizeClass,
                dynamicTypeSize: dynamicTypeSize
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
