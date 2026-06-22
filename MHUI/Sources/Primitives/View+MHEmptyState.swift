import SwiftUI

public extension View {
    /// Applies calm spacing around a native `ContentUnavailableView`.
    func mhEmptyStateLayout() -> some View {
        modifier(MHEmptyStateLayoutModifier())
    }
}

// MARK: - Preview

#if !MHUI_DISABLE_PACKAGE_PREVIEWS
#Preview("Empty State", traits: .sizeThatFitsLayout) {
    ContentUnavailableView {
        Label("Nothing here yet", systemImage: "square.grid.2x2")
    } description: {
        Text("Start by creating a first surface or screen block.")
    } actions: {
        Button("Create Sample") {
            // no-op
        }
        .buttonStyle(.mhSecondary)
    }
    .mhEmptyStateLayout()
    .mhSurfaceInset()
    .mhSurface()
    .mhPreviewSurface()
}
#endif
