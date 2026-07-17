extension MHTheme {
    func resolvedGroupedRowsStyle(
        showsDividers: Bool,
        for context: MHAdaptiveLayoutContext
    ) -> MHResolvedGroupedRowsStyle {
        let rowChrome = resolvedRowChromeStyle(for: context)

        return .init(
            rowChrome: rowChrome,
            showsDividers: showsDividers,
            dividerLeadingInset: rowChrome.horizontalInset,
            dividerThickness: divider.thickness,
            dividerOpacity: divider.opacity,
            spacerHeight: rowChrome.verticalPadding
        )
    }

    func resolvedGroupedRowsStyle(
        showsDividers: Bool
    ) -> MHResolvedGroupedRowsStyle {
        resolvedGroupedRowsStyle(
            showsDividers: showsDividers,
            for: .init()
        )
    }
}
