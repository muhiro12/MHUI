extension MHTheme {
    func resolvedActionGroupStyle(
        for context: MHAdaptiveLayoutContext
    ) -> MHResolvedActionGroupStyle {
        let isCompactWidth = context.isCompactWidth(
            threshold: layout.compactWidthThreshold
        )

        return .init(
            spacing: isCompactWidth
                ? presentation.compactActionGroupSpacing
                : spacing.control
        )
    }
}
