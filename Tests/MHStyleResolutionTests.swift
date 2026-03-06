@testable import MHUI
import Testing

struct MHStyleResolutionTests {
    @Test
    func text_style_resolution_maps_roles() {
        let theme = MHTheme.standard

        let style = theme.resolvedTextStyle(
            for: .sectionTitle,
            colorRole: .secondaryText
        )
        let screenTitle = theme.resolvedTextStyle(
            for: .screenTitle,
            colorRole: .primaryText
        )
        let supporting = theme.resolvedTextStyle(
            for: .supporting,
            colorRole: .secondaryText
        )
        let caption = theme.resolvedTextStyle(
            for: .caption,
            colorRole: .secondaryText
        )

        #expect(style.metrics == theme.typography.sectionTitle)
        #expect(style.colorRole == .secondaryText)
        #expect(style.design == .default)
        #expect(style.size == 20)
        #expect(style.tracking == -0.15)
        #expect(screenTitle.design == .serif)
        #expect(screenTitle.size == 28)
        #expect(screenTitle.tracking == -0.3)
        #expect(supporting.metrics.weight == .medium)
        #expect(supporting.tracking == 0.15)
        #expect(caption.metrics.weight == .semibold)
        #expect(caption.tracking == 0.45)
    }

    @Test
    func action_button_resolution_stays_quiet_and_semantic() {
        let theme = MHTheme.standard

        let primary = theme.resolvedActionButtonStyle(for: .primary)
        let quiet = theme.resolvedActionButtonStyle(for: .quiet)
        let destructive = theme.resolvedActionButtonStyle(for: .destructive)

        #expect(primary.fillRole == .surface)
        #expect(primary.foregroundRole == .primaryText)
        #expect(primary.accentRuleRole == .accent)
        #expect(primary.accentRuleOpacity == 0.75)
        #expect(quiet.fillRole == nil)
        #expect(quiet.borderRole == nil)
        #expect(destructive.foregroundRole == .destructive)
        #expect(destructive.accentRuleRole == .destructive)
        #expect(destructive.accentRuleOpacity == 0.55)
        #expect(primary.horizontalPadding == theme.spacing.group)
        #expect(quiet.verticalPadding < primary.verticalPadding)
    }
}
