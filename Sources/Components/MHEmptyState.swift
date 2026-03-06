// swiftlint:disable one_declaration_per_file file_types_order
import SwiftUI

private enum MHEmptyState {}

private struct MHEmptyStateLayoutModifier: ViewModifier {
    @Environment(\.mhTheme)
    private var theme

    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding(.horizontal, theme.spacing.group)
            .padding(.vertical, theme.spacing.section)
    }
}

public extension View {
    /// Applies calm spacing around a native `ContentUnavailableView`.
    func mhEmptyStateLayout() -> some View {
        modifier(MHEmptyStateLayoutModifier())
    }
}

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
        .padding(MHTheme.standard.spacing.group)
    }
    .mhPreviewSurface()
}
// swiftlint:enable one_declaration_per_file file_types_order
