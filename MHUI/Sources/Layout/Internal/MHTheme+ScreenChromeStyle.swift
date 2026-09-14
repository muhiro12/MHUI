extension MHTheme {
    func resolvedScreenChromeStyle(
        for context: MHAdaptiveLayoutContext
    ) -> MHResolvedScreenChromeStyle {
        let isCompactWidth = context.isCompactWidth(
            threshold: layout.compactWidthThreshold
        )

        return .init(
            readableContentWidth: isCompactWidth
                ? nil
                : layout.readableContentWidth,
            horizontalMargin: isCompactWidth
                ? layout.screen.compactContentInsetHorizontal
                : layout.screen.contentInsetHorizontal,
            verticalPadding: isCompactWidth
                ? layout.screen.compactContentInsetVertical
                : layout.screen.contentInsetVertical,
            contentSpacing: isCompactWidth
                ? layout.screen.compactContentSpacing
                : layout.screen.contentSpacing
        )
    }

    func resolvedScreenChromeStyle() -> MHResolvedScreenChromeStyle {
        resolvedScreenChromeStyle(for: .init())
    }
}
