extension MHResolvedSectionChromeStyle {
    var cueStyle: MHResolvedCueStyle {
        .init(
            colorRole: cueColorRole,
            placement: cuePlacement,
            length: cueLength,
            thickness: cueThickness,
            spacing: cueSpacing
        )
    }
}
