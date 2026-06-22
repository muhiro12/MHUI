extension MHTheme {
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
