@testable import MHUI
import Testing

struct MHBadgeContrastResolutionTests {
    @Test
    func emphasized_badges_use_accessible_text_over_semantic_markers() {
        let theme = MHTheme.standard

        let accent = resolvedBadge(.accent, in: theme)
        let warning = resolvedBadge(.warning, in: theme)
        let destructive = resolvedBadge(.destructive, in: theme)

        #expect(accent.foregroundRole == .primaryText)
        #expect(accent.backgroundStyle.fallbackFillRole == .accent)
        #expect(warning.foregroundRole == .primaryText)
        #expect(warning.backgroundStyle.fallbackFillRole == .warning)
        #expect(destructive.foregroundRole == .primaryText)
        #expect(destructive.backgroundStyle.fallbackFillRole == .destructive)
    }

    private func resolvedBadge(
        _ style: MHBadgeStyle,
        in theme: MHTheme
    ) -> MHResolvedBadgeChromeStyle {
        theme.resolvedBadgeChromeStyle(
            for: style,
            glassPolicy: .disabled,
            reduceTransparency: false,
            supportsGlass: true
        )
    }
}
