extension MHTheme {
    func resolvedCueStyle(
        for kind: MHCueKind
    ) -> MHResolvedCueStyle {
        switch kind {
        case .screen:
            .init(
                colorRole: .accent,
                width: presentation.screenCueWidth,
                height: presentation.screenCueHeight,
                spacing: spacing.control
            )
        case .section:
            .init(
                colorRole: .accent,
                width: presentation.sectionCueWidth,
                height: presentation.sectionCueHeight,
                spacing: spacing.inline
            )
        }
    }
}
