extension MHTheme {
    func resolvedCueStyle(
        for kind: MHCueKind
    ) -> MHResolvedCueStyle {
        switch kind {
        case .screen:
            .init(
                colorRole: .primaryText,
                placement: presentation.screenCuePlacement,
                length: presentation.screenCueLength,
                thickness: presentation.screenCueThickness,
                spacing: spacing.control
            )
        case .section:
            .init(
                colorRole: .border,
                placement: presentation.sectionCuePlacement,
                length: presentation.sectionCueLength,
                thickness: presentation.sectionCueThickness,
                spacing: spacing.inline
            )
        }
    }
}
