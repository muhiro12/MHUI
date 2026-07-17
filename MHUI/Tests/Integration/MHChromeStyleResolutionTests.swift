@testable import MHUI
import Testing

struct MHChromeStyleResolutionTests {
    @Test
    func screen_and_section_chrome_share_theme_tokens() {
        let theme = MHTheme.standard
        let screenCue = theme.resolvedCueStyle(for: .screen)
        let sectionCue = theme.resolvedCueStyle(for: .section)
        let screen = theme.resolvedScreenChromeStyle()
        let section = theme.resolvedSectionChromeStyle()

        #expect(screen.readableContentWidth == Optional(theme.layout.readableContentWidth))
        #expect(screen.horizontalMargin == theme.layout.screen.contentInsetHorizontal)
        #expect(screen.verticalPadding == theme.layout.screen.contentInsetVertical)
        #expect(screenCue.colorRole == .primaryText)
        #expect(screenCue.placement == theme.presentation.screenCuePlacement)
        #expect(screenCue.length == theme.presentation.screenCueLength)
        #expect(screenCue.thickness == theme.presentation.screenCueThickness)
        #expect(sectionCue.colorRole == .border)
        #expect(sectionCue.placement == theme.presentation.sectionCuePlacement)
        #expect(sectionCue.length == theme.presentation.sectionCueLength)
        #expect(sectionCue.thickness == theme.presentation.sectionCueThickness)
        #expect(screen.cueStyle == screenCue)
        #expect(section.cueStyle == sectionCue)
        #expect(section.contentSpacing == theme.spacing.control)
    }

    @Test
    func top_cue_configuration_preserves_legacy_geometry_intent() {
        var theme = MHTheme.standard
        theme.presentation.screenCuePlacement = .top
        theme.presentation.screenCueLength = 24
        theme.presentation.screenCueThickness = 3

        let cue = theme.resolvedCueStyle(for: .screen)

        #expect(cue.placement == .top)
        #expect(cue.length == 24)
        #expect(cue.thickness == 3)
    }
}
