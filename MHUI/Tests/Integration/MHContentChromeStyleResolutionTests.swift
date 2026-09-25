@testable import MHUI
import Testing

struct MHContentChromeStyleResolutionTests {
    @Test
    func input_and_badge_styles_resolve_from_theme_tokens() {
        let theme = MHTheme.standard
        let normalInput = theme.resolvedInputChromeStyle(for: .normal)
        let focusedInput = theme.resolvedInputChromeStyle(for: .focused)
        let invalidInput = theme.resolvedInputChromeStyle(for: .invalid)
        let neutralBadge = theme.resolvedBadgeChromeStyle(for: .neutral)
        let accentBadge = theme.resolvedBadgeChromeStyle(for: .accent)

        #expect(normalInput.backgroundStyle.fillRole == .surface)
        #expect(normalInput.backgroundStyle.borderRole == .border)
        #expect(normalInput.backgroundStyle.borderOpacity == 0.20)
        #expect(focusedInput.backgroundStyle.borderRole == .accent)
        #expect(focusedInput.backgroundStyle.borderOpacity == 0.24)
        #expect(focusedInput.horizontalPadding == theme.spacing.content)
        #expect(focusedInput.minimumHeight == theme.layout.control.minimumTouchTarget)
        #expect(invalidInput.backgroundStyle.fillRole == .destructive)
        #expect(invalidInput.backgroundStyle.borderOpacity == 0.20)
        #expect(neutralBadge.textRole == .caption)
        #expect(neutralBadge.foregroundRole == .secondaryText)
        #expect(neutralBadge.backgroundStyle.fillOpacity == 0.06)
        #expect(accentBadge.foregroundRole == .primaryText)
        #expect(accentBadge.backgroundStyle.fillRole == .accent)
        #expect(accentBadge.backgroundStyle.borderOpacity == 0.14)
        #expect(accentBadge.horizontalPadding == theme.spacing.control)
    }
}
