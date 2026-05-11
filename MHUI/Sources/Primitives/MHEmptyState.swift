// swiftlint:disable one_declaration_per_file file_types_order
import SwiftUI

private enum MHEmptyState {}

private struct MHResolvedEmptyStateLayoutStyle: Sendable, Equatable {
    var horizontalPadding: CGFloat
    var verticalPadding: CGFloat
}

private struct MHEmptyStateLayoutModifier: ViewModifier {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.mhAdaptiveLayoutContext)
    private var adaptiveLayoutContext
    @Environment(\.horizontalSizeClass)
    private var horizontalSizeClass

    func body(content: Content) -> some View {
        let context = adaptiveLayoutContext.resolved(
            with: horizontalSizeClass,
            threshold: theme.layout.compactWidthThreshold
        )
        let style = theme.resolvedEmptyStateLayoutStyle(for: context)

        content
            .frame(maxWidth: .infinity)
            .padding(.horizontal, style.horizontalPadding)
            .padding(.vertical, style.verticalPadding)
    }
}

private extension MHTheme {
    func resolvedEmptyStateLayoutStyle(
        for context: MHAdaptiveLayoutContext
    ) -> MHResolvedEmptyStateLayoutStyle {
        let isCompactWidth = context.isCompactWidth(
            threshold: layout.compactWidthThreshold
        )

        return .init(
            horizontalPadding: isCompactWidth
                ? layout.surface.compactInsetHorizontal
                : spacing.content,
            verticalPadding: isCompactWidth
                ? spacing.content
                : spacing.section
        )
    }
}

public extension View {
    /// Applies calm spacing around a native `ContentUnavailableView`.
    func mhEmptyStateLayout() -> some View {
        modifier(MHEmptyStateLayoutModifier())
    }
}

// MARK: - Preview

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
// swiftlint:enable one_declaration_per_file file_types_order
