extension MHTheme {
    func resolvedSectionChromeStyle(
        for context: MHAdaptiveLayoutContext
    ) -> MHResolvedSectionChromeStyle {
        let cue = resolvedCueStyle(for: .section)
        let isCompactWidth = context.isCompactWidth(
            threshold: layout.compactWidthThreshold
        )

        return .init(
            cueColorRole: cue.colorRole,
            cuePlacement: cue.placement,
            cueLength: cue.length,
            cueThickness: cue.thickness,
            cueSpacing: cue.spacing,
            contentSpacing: isCompactWidth
                ? presentation.compactKeyValueSpacing
                : spacing.control,
            leadingInset: spacing.inline,
            footerTopSpacing: spacing.inline
        )
    }

    func resolvedSectionChromeStyle() -> MHResolvedSectionChromeStyle {
        resolvedSectionChromeStyle(for: .init())
    }
}
