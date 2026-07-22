import CoreGraphics

private enum MHFeatureGridMetrics {
    static let singleColumnCount = 1
    static let compactColumnCount = 2
    static let supportingWidthDivisor: CGFloat = 3
}

extension MHTheme {
    func resolvedFeatureGridStyle(
        for context: MHAdaptiveLayoutContext
    ) -> MHResolvedFeatureGridStyle {
        let usesAccessibilityLayout = context.dynamicTypeSize?.isAccessibilitySize == true
        let isCompactWidth = context.isCompactWidth(
            threshold: layout.compactWidthThreshold
        )

        return .init(
            arrangement: isCompactWidth ? .stacked : .split,
            primarySpacing: isCompactWidth ? spacing.content : spacing.section,
            supportingSpacing: usesAccessibilityLayout ? spacing.content : spacing.control,
            supportingColumnCount: supportingColumnCount(
                isCompactWidth: isCompactWidth,
                usesAccessibilityLayout: usesAccessibilityLayout
            ),
            supportingColumnWidth: layout.readableContentWidth
                / MHFeatureGridMetrics.supportingWidthDivisor
        )
    }

    private func supportingColumnCount(
        isCompactWidth: Bool,
        usesAccessibilityLayout: Bool
    ) -> Int {
        #if os(watchOS)
        MHFeatureGridMetrics.singleColumnCount
        #else
        isCompactWidth && !usesAccessibilityLayout
            ? MHFeatureGridMetrics.compactColumnCount
            : MHFeatureGridMetrics.singleColumnCount
        #endif
    }
}
