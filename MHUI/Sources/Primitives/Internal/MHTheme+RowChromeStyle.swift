extension MHTheme {
    func resolvedRowChromeStyle(
        for context: MHAdaptiveLayoutContext
    ) -> MHResolvedRowChromeStyle {
        let isCompactWidth = context.isCompactWidth(
            threshold: layout.compactWidthThreshold
        )

        return .init(
            verticalPadding: isCompactWidth
                ? presentation.compactRowVerticalPadding
                : presentation.rowVerticalPadding,
            horizontalInset: isCompactWidth
                ? presentation.compactRowHorizontalInset
                : presentation.rowHorizontalInset,
            accessorySpacing: isCompactWidth
                ? presentation.compactRowAccessorySpacing
                : presentation.rowAccessorySpacing,
            minimumHeight: layout.control.minimumTouchTarget
        )
    }

    func resolvedRowChromeStyle() -> MHResolvedRowChromeStyle {
        resolvedRowChromeStyle(for: .init())
    }
}
