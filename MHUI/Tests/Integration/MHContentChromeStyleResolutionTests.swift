@testable import MHUI
import Testing

struct MHContentChromeStyleResolutionTests {
    @Test
    func input_and_badge_styles_resolve_from_theme_tokens() {
        let theme = MHTheme.standard
        let focusedInput = theme.resolvedInputChromeStyle(
            for: .focused,
            glassPolicy: .enabled,
            reduceTransparency: false,
            supportsGlass: true
        )
        let invalidInput = theme.resolvedInputChromeStyle(
            for: .invalid,
            glassPolicy: .enabled,
            reduceTransparency: true,
            supportsGlass: true
        )
        let neutralBadge = theme.resolvedBadgeChromeStyle(
            for: .neutral,
            glassPolicy: .enabled,
            reduceTransparency: false,
            supportsGlass: true
        )
        let accentBadge = theme.resolvedBadgeChromeStyle(
            for: .accent,
            glassPolicy: .disabled,
            reduceTransparency: false,
            supportsGlass: true
        )

        #expect(!focusedInput.backgroundStyle.usesGlass)
        #expect(focusedInput.backgroundStyle.borderRole == .accent)
        #expect(focusedInput.backgroundStyle.borderOpacity == 0.24)
        #expect(focusedInput.backgroundStyle.glassTintRole == nil)
        #expect(!focusedInput.backgroundStyle.isGlassInteractive)
        #expect(focusedInput.horizontalPadding == theme.spacing.content)
        #expect(focusedInput.minimumHeight == theme.layout.control.minimumTouchTarget)
        #expect(invalidInput.backgroundStyle.fallbackFillRole == .destructive)
        #expect(!invalidInput.backgroundStyle.usesGlass)
        #expect(invalidInput.backgroundStyle.borderOpacity == 0.20)
        #expect(neutralBadge.textRole == .caption)
        #expect(neutralBadge.foregroundRole == .secondaryText)
        #expect(!neutralBadge.backgroundStyle.usesGlass)
        #expect(neutralBadge.backgroundStyle.glassTintRole == nil)
        #expect(neutralBadge.backgroundStyle.fallbackFillOpacity == 0.06)
        #expect(accentBadge.foregroundRole == .primaryText)
        #expect(accentBadge.backgroundStyle.fallbackFillRole == .accent)
        #expect(accentBadge.backgroundStyle.borderOpacity == 0.14)
        #expect(!accentBadge.backgroundStyle.usesGlass)
        #expect(accentBadge.horizontalPadding == theme.spacing.control)
    }
}
