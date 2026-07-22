import SwiftUI

struct MHFeatureSupportingGrid<Content: View>: View {
    let content: Content
    let columnCount: Int
    let spacing: CGFloat

    var body: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing
        ) {
            ForEach(subviews: content) { subview in
                subview
                    .frame(maxWidth: .infinity, alignment: .topLeading)
            }
        }
    }

    private var columns: [GridItem] {
        Array(
            repeating: GridItem(.flexible(), spacing: spacing),
            count: columnCount
        )
    }
}
