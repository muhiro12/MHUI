@testable import MHUI
import SwiftUI
import Testing

struct MHThemeTests {
    @Test
    func standard_theme_uses_semantic_defaults() {
        let theme = MHTheme.standard

        #expect(theme.colors.accent == .tint)
        #expect(theme.spacing.inline == 4)
        #expect(theme.spacing.control == 12)
        #expect(theme.spacing.group == 18)
        #expect(theme.spacing.section == 32)
        #expect(theme.spacing.screen == 36)
        #expect(theme.spacing.screen > theme.spacing.section)
        #expect(theme.spacing.section > theme.spacing.group)
        #expect(theme.spacing.group > theme.spacing.control)
        #expect(theme.spacing.control > theme.spacing.inline)
        #expect(theme.radius.control == 6)
        #expect(theme.radius.surface == 8)
        #expect(theme.radius.pill > theme.radius.surface)
        #expect(theme.divider.opacity == 0.55)
        #expect(theme.motion.quick == 0.14)
        #expect(theme.motion.regular == 0.22)
        #expect(theme.typography.screenTitle.weight == .medium)
        #expect(theme.typography.sectionTitle.weight == .medium)
        #expect(theme.typography.bodyStrong.weight == .medium)

        let primary = theme.resolvedActionButtonStyle(for: .primary)
        #expect(primary.foregroundRole == .primaryText)
        #expect(primary.accentRuleRole == .accent)
    }

    @Test
    func environment_values_store_theme_overrides() {
        var values = EnvironmentValues()
        var custom = MHTheme.standard
        custom.spacing.screen = 40

        values.mhTheme = custom

        #expect(values.mhTheme == custom)
        #expect(values.mhTheme.spacing.screen == 40)
    }
}
