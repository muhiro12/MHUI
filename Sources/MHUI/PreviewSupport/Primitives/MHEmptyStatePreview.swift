import SwiftUI

#Preview("Empty State", traits: .sizeThatFitsLayout) {
    ContentUnavailableView(
        "Nothing here yet",
        systemImage: "square.grid.2x2",
        description: Text("Start by creating a first surface or screen block.")
    )
    .mhEmptyStateLayout()
    .mhSurfaceInset()
    .mhSurface()
    .overlay(alignment: .bottomLeading) {
        Button("Create Sample") {
            // no-op
        }
        .buttonStyle(.mhSecondary)
        .padding(MHTheme.standard.spacing.content)
    }
    .mhPreviewSurface()
}
