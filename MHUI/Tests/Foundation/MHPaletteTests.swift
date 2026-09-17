import MHUI
import Testing

struct MHPaletteTests {
    @Test
    func existing_standard_factories_remain_usable_as_function_values() {
        let accentFactory = MHTheme.standard(accent:)
        let foregroundFactory = MHTheme.standard(onAccent:)
        let metricsFactory = MHTheme.standard(metrics:accent:)
        let colorsFactory = MHTheme.standard(accent:onAccent:)
        let completeFactory = MHTheme.standard(metrics:accent:onAccent:)
        let theme = MHTheme.standard
        let accent = theme.colors.warning
        let foreground = theme.colors.primaryText
        let metrics = theme.metrics

        #expect(accentFactory(accent) == MHTheme.standard(palette: .mist, accent: accent))
        #expect(foregroundFactory(foreground) == MHTheme.standard(palette: .mist, onAccent: foreground))
        #expect(metricsFactory(metrics, accent) == MHTheme.standard(palette: .mist, metrics: metrics, accent: accent))
        #expect(colorsFactory(accent, foreground) == MHTheme.standard(
            palette: .mist, accent: accent, onAccent: foreground
        ))
        #expect(completeFactory(metrics, accent, foreground) == MHTheme.standard(
            palette: .mist, metrics: metrics, accent: accent, onAccent: foreground
        ))
    }

    @Test
    func mist_preserves_the_existing_default() {
        #expect(MHTheme.standard(palette: .mist) == MHTheme.standard)
    }

    @Test(arguments: MHPalette.allCases)
    func palettes_preserve_shared_design_and_host_colors(_ palette: MHPalette) {
        let standard = MHTheme.standard
        let theme = MHTheme.standard(palette: palette)

        #expect(theme.colors.accent == .tint)
        #expect(theme.colors.onAccent == standard.colors.onAccent)
        #expect(theme.typography == standard.typography)
        #expect(theme.metrics == standard.metrics)
        #expect(theme.presentation == standard.presentation)
        #expect(theme.surfaces == standard.surfaces)
        #expect(theme.divider == standard.divider)
        #expect(theme.motion == standard.motion)
        #expect(theme.colors.primaryText == standard.colors.primaryText)
        #expect(theme.colors.destructive == standard.colors.destructive)

        let branded = MHTheme.standard(
            palette: palette,
            accent: standard.colors.warning,
            onAccent: standard.colors.primaryText
        )
        #expect(branded.colors.accent == standard.colors.warning)
        #expect(branded.colors.onAccent == standard.colors.primaryText)
        #expect(branded.colors.background == theme.colors.background)
    }

    @Test
    func each_palette_changes_all_four_surfaces() {
        for (index, palette) in MHPalette.allCases.enumerated() {
            for other in MHPalette.allCases.dropFirst(index + 1) {
                let first = MHTheme.standard(palette: palette).colors
                let second = MHTheme.standard(palette: other).colors
                #expect(first.background != second.background)
                #expect(first.surface != second.surface)
                #expect(first.surfaceElevated != second.surfaceElevated)
                #expect(first.surfaceMuted != second.surfaceMuted)
            }
        }
    }
}
