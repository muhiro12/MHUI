@testable import MHUI
import Testing

struct MHContentChromeStyleResolutionTests {
    @Test
    func input_and_badge_styles_resolve_from_theme_tokens() {
        let theme = MHTheme.standard
        let normalInput = theme.resolvedInputChromeStyle(for: .normal, increasedContrast: false)
        let focusedInput = theme.resolvedInputChromeStyle(for: .focused, increasedContrast: false)
        let invalidInput = theme.resolvedInputChromeStyle(for: .invalid, increasedContrast: false)
        let neutralBadge = theme.resolvedBadgeChromeStyle(for: .neutral, increasedContrast: false)
        let accentBadge = theme.resolvedBadgeChromeStyle(for: .accent, increasedContrast: false)

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
        #expect(neutralBadge.backgroundStyle.borderOpacity == 0)
        #expect(accentBadge.foregroundRole == .primaryText)
        #expect(accentBadge.backgroundStyle.fillRole == .accent)
        #expect(accentBadge.backgroundStyle.borderOpacity == 0)
        #expect(accentBadge.horizontalPadding == theme.spacing.control)
    }

    @Test
    func increased_contrast_strengthens_input_and_badge_outlines() {
        let theme = MHTheme.standard
        let outline = theme.divider.opacity

        for state in MHFieldState.allCases {
            let standardInput = theme.resolvedInputChromeStyle(for: state, increasedContrast: false)
            let input = theme.resolvedInputChromeStyle(for: state, increasedContrast: true)

            #expect(input.backgroundStyle.borderRole == standardInput.backgroundStyle.borderRole)
            #expect(input.backgroundStyle.borderOpacity == outline)
        }

        for style in MHBadgeStyle.allCases {
            let badge = theme.resolvedBadgeChromeStyle(for: style, increasedContrast: true)

            #expect(badge.backgroundStyle.borderRole == badge.backgroundStyle.fillRole)
            #expect(badge.backgroundStyle.borderOpacity == outline)
        }
    }
}
