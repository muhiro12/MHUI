extension MHTheme {
    func resolvedCueStyle(
        for kind: MHCueKind
    ) -> MHResolvedCueStyle {
        switch kind {
        case .screen:
            .init(
                colorRole: .accent,
                placement: presentation.screenCuePlacement,
                length: presentation.screenCueLength,
                thickness: presentation.screenCueThickness,
                spacing: spacing.control
            )
        case .section:
            .init(
                colorRole: .accent,
                placement: presentation.sectionCuePlacement,
                length: presentation.sectionCueLength,
                thickness: presentation.sectionCueThickness,
                spacing: spacing.inline
            )
        }
    }
}
