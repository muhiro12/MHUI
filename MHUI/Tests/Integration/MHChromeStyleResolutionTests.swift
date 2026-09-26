@testable import MHUI
import Testing

struct MHChromeStyleResolutionTests {
    @Test
    func screen_and_section_chrome_share_layout_tokens() {
        let theme = MHTheme.standard
        let screen = theme.resolvedScreenChromeStyle()
        let section = theme.resolvedSectionChromeStyle()

        #expect(screen.horizontalMargin == theme.layout.screen.contentInsetHorizontal)
        #expect(screen.verticalPadding == theme.layout.screen.contentInsetVertical)
        #expect(section.contentSpacing == theme.spacing.control)
    }
}
