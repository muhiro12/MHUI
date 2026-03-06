// swiftlint:disable function_body_length
@testable import MHUI
import SwiftUI
import Testing

struct MHThemeTests {
    @Test
    func standard_theme_uses_semantic_defaults() {
        let theme = MHTheme.standard
        let orangeTheme = MHTheme.standard(accentStyle: .orange)
        let accentReferences = MHAccentStyle.allCases.map { accentStyle in
            MHTheme.standard(accentStyle: accentStyle).colors.accent
        }

        #expect(theme == orangeTheme)
        #expect(theme.colors.background == .adaptive(.init(
            light: .init(red: 0.95, green: 0.95, blue: 0.95),
            dark: .init(red: 0.12, green: 0.12, blue: 0.13)
        )))
        #expect(theme.colors.surface == .adaptive(.init(
            light: .init(red: 0.985, green: 0.985, blue: 0.985),
            dark: .init(red: 0.16, green: 0.16, blue: 0.17)
        )))
        #expect(theme.colors.surfaceMuted == .adaptive(.init(
            light: .init(red: 0.93, green: 0.93, blue: 0.94),
            dark: .init(red: 0.21, green: 0.21, blue: 0.22)
        )))
        #expect(theme.colors.border == .adaptive(.init(
            light: .init(red: 0.73, green: 0.73, blue: 0.76, opacity: 0.60),
            dark: .init(red: 0.40, green: 0.40, blue: 0.44, opacity: 0.72)
        )))
        #expect(theme.colors.primaryText == .adaptive(.init(
            light: .init(red: 0.13, green: 0.13, blue: 0.14),
            dark: .init(red: 0.92, green: 0.92, blue: 0.93)
        )))
        #expect(theme.colors.secondaryText == .adaptive(.init(
            light: .init(red: 0.43, green: 0.43, blue: 0.45),
            dark: .init(red: 0.68, green: 0.68, blue: 0.71)
        )))
        #expect(theme.colors.accent == .adaptive(.init(
            light: .init(red: 0.93, green: 0.43, blue: 0.10),
            dark: .init(red: 1.00, green: 0.70, blue: 0.28)
        )))
        #expect(accentReferences == [
            .adaptive(.init(
                light: .init(red: 0.93, green: 0.43, blue: 0.10),
                dark: .init(red: 1.00, green: 0.70, blue: 0.28)
            )),
            .adaptive(.init(
                light: .init(red: 0.14, green: 0.45, blue: 0.90),
                dark: .init(red: 0.45, green: 0.68, blue: 1.00)
            )),
            .adaptive(.init(
                light: .init(red: 0.10, green: 0.58, blue: 0.36),
                dark: .init(red: 0.39, green: 0.82, blue: 0.55)
            )),
            .adaptive(.init(
                light: .init(red: 0.82, green: 0.22, blue: 0.24),
                dark: .init(red: 1.00, green: 0.45, blue: 0.46)
            )),
            .adaptive(.init(
                light: .init(red: 0.45, green: 0.30, blue: 0.86),
                dark: .init(red: 0.72, green: 0.57, blue: 1.00)
            ))
        ])
        #expect(theme.spacing.inline == 4)
        #expect(theme.spacing.control == 12)
        #expect(theme.spacing.group == 20)
        #expect(theme.spacing.section == 32)
        #expect(theme.spacing.screen == 40)
        #expect(theme.spacing.screen > theme.spacing.section)
        #expect(theme.spacing.section > theme.spacing.group)
        #expect(theme.spacing.group > theme.spacing.control)
        #expect(theme.spacing.control > theme.spacing.inline)
        #expect(theme.radius.control == 8)
        #expect(theme.radius.surface == 12)
        #expect(theme.radius.pill > theme.radius.surface)
        #expect(theme.divider.opacity == 0.50)
        #expect(theme.motion.quick == 0.14)
        #expect(theme.motion.regular == 0.22)
        #expect(theme.typography.screenTitle.weight == .semibold)
        #expect(theme.typography.sectionTitle.weight == .semibold)
        #expect(theme.typography.bodyStrong.weight == .medium)
        #expect(theme.typography.supporting.weight == .regular)
        #expect(theme.typography.caption.weight == .medium)

        let primary = theme.resolvedActionButtonStyle(for: .primary)
        #expect(primary.fillRole == .surfaceMuted)
        #expect(primary.foregroundRole == .primaryText)
        #expect(primary.accentRuleRole == nil)
    }

    @Test
    func environment_values_store_theme_overrides() {
        var values = EnvironmentValues()
        var custom = MHTheme.standard
        custom.spacing.screen = 44
        custom.colors.accent = .tint

        values.mhTheme = custom

        #expect(values.mhTheme == custom)
        #expect(values.mhTheme.spacing.screen == 44)
        #expect(values.mhTheme.colors.accent == .tint)
    }
}
// swiftlint:enable function_body_length
