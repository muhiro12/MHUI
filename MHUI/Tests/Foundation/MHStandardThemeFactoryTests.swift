import MHUI
import Testing

struct MHStandardThemeFactoryTests {
    @Test
    func standard_factories_remain_usable_as_function_values() {
        let accentFactory = MHTheme.standard(accent:)
        let foregroundFactory = MHTheme.standard(onAccent:)
        let metricsFactory = MHTheme.standard(metrics:accent:)
        let colorsFactory = MHTheme.standard(accent:onAccent:)
        let completeFactory = MHTheme.standard(metrics:accent:onAccent:)
        let theme = MHTheme.standard
        let accent = theme.colors.warning
        let foreground = theme.colors.primaryText
        let metrics = theme.metrics

        #expect(accentFactory(accent) == completeFactory(metrics, accent, theme.colors.onAccent))
        #expect(foregroundFactory(foreground) == completeFactory(metrics, .tint, foreground))
        #expect(metricsFactory(metrics, accent) == completeFactory(metrics, accent, theme.colors.onAccent))
        #expect(colorsFactory(accent, foreground) == completeFactory(metrics, accent, foreground))
        #expect(completeFactory(metrics, .tint, theme.colors.onAccent) == theme)
    }

    @Test
    func host_accent_pairs_leave_the_neutral_foundation_unchanged() {
        let standard = MHTheme.standard
        let accent = MHColorReference.asset(MHUITestColorAsset.accent)
        let onAccent = MHColorReference.asset(MHUITestColorAsset.surface)
        let branded = MHTheme.standard(
            accent: accent,
            onAccent: onAccent
        )
        var neutralColors = branded.colors
        neutralColors.accent = standard.colors.accent
        neutralColors.onAccent = standard.colors.onAccent

        #expect(standard.colors.accent == .tint)
        #expect(branded.colors.accent == accent)
        #expect(branded.colors.onAccent == onAccent)
        #expect(neutralColors == standard.colors)
        #expect(branded.typography == standard.typography)
        #expect(branded.metrics == standard.metrics)
        #expect(branded.presentation == standard.presentation)
        #expect(branded.surfaces == standard.surfaces)
        #expect(branded.divider == standard.divider)
        #expect(branded.motion == standard.motion)
    }
}
