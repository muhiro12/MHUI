@testable import MHUI
import SwiftUI
import Testing

struct MHThemeTests {
    @Test
    func standard_theme_uses_semantic_defaults() {
        let theme = MHTheme.standard

        #expect(
            theme.colors.accent == .adaptive(
                .init(
                    light: .init(red: 0.94, green: 0.40, blue: 0.05),
                    dark: .init(red: 1.00, green: 0.72, blue: 0.28)
                )
            )
        )
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
        #expect(theme.divider.opacity == 0.62)
        #expect(theme.motion.quick == 0.14)
        #expect(theme.motion.regular == 0.22)
        #expect(theme.typography.screenTitle.weight == .semibold)
        #expect(theme.typography.sectionTitle.weight == .semibold)
        #expect(theme.typography.bodyStrong.weight == .semibold)
        #expect(theme.typography.supporting.weight == .medium)
        #expect(theme.typography.caption.weight == .semibold)

        let primary = theme.resolvedActionButtonStyle(for: .primary)
        #expect(primary.fillRole == .surface)
        #expect(primary.foregroundRole == .primaryText)
        #expect(primary.accentRuleRole == .accent)
    }

    @Test
    func environment_values_store_theme_overrides() {
        var values = EnvironmentValues()
        var custom = MHTheme.standard
        custom.spacing.screen = 40
        custom.colors.accent = .tint

        values.mhTheme = custom

        #expect(values.mhTheme == custom)
        #expect(values.mhTheme.spacing.screen == 40)
        #expect(values.mhTheme.colors.accent == .tint)
    }
}
