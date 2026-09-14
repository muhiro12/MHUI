extension MHTheme {
    func resolvedSectionChromeStyle(
        for context: MHAdaptiveLayoutContext
    ) -> MHResolvedSectionChromeStyle {
        let isCompactWidth = context.isCompactWidth(
            threshold: layout.compactWidthThreshold
        )

        return .init(
            contentSpacing: isCompactWidth
                ? presentation.compactKeyValueSpacing
                : spacing.control,
            footerTopSpacing: spacing.inline
        )
    }

    func resolvedSectionChromeStyle() -> MHResolvedSectionChromeStyle {
        resolvedSectionChromeStyle(for: .init())
    }
}
