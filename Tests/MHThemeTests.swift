@testable import MHUI
import SwiftUI
import Testing

struct MHThemeTests {
    @Test
    func standard_theme_uses_semantic_defaults() {
        let theme = MHTheme.standard

        #expect(theme.colors.accent == .tint)
        #expect(theme.spacing.screen > theme.spacing.section)
        #expect(theme.spacing.section > theme.spacing.group)
        #expect(theme.radius.pill > theme.radius.surface)
        #expect(theme.typography.screenTitle.weight == .semibold)
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
