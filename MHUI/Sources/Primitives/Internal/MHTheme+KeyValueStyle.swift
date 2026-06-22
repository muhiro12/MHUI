extension MHTheme {
    func resolvedKeyValueStyle(
        for context: MHAdaptiveLayoutContext
    ) -> MHResolvedKeyValueStyle {
        .init(
            labelColorRole: .primaryText,
            valueColorRole: .secondaryText,
            rowChrome: resolvedRowChromeStyle(for: context),
            minimumValueWidth: context.isCompactWidth(
                threshold: layout.compactWidthThreshold
            )
            ? presentation.compactKeyValueMinimumValueWidth
            : presentation.regularKeyValueMinimumValueWidth,
            stackedSpacing: presentation.compactKeyValueSpacing
        )
    }

    func resolvedKeyValueStyle() -> MHResolvedKeyValueStyle {
        resolvedKeyValueStyle(for: .init())
    }
}
