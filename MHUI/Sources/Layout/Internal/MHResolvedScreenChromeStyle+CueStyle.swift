extension MHResolvedScreenChromeStyle {
    var cueStyle: MHResolvedCueStyle {
        .init(
            colorRole: cueColorRole,
            width: cueWidth,
            height: cueHeight,
            spacing: cueSpacing
        )
    }
}
