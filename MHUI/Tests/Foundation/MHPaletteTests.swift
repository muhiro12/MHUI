import MHUI
import Testing

struct MHPaletteTests {
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
            accent: standard.colors.warning,
            onAccent: standard.colors.primaryText,
            palette: palette
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
