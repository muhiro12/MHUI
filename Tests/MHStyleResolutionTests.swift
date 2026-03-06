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
        #expect(style.tracking == 0)
        #expect(screenTitle.design == .default)
        #expect(screenTitle.tracking == 0)
        #expect(supporting.metrics.weight == .regular)
        #expect(supporting.tracking == 0.1)
        #expect(caption.metrics.weight == .medium)
        #expect(caption.tracking == 0.2)
    }

    @Test
    func action_button_resolution_stays_quiet_and_semantic() {
        let theme = MHTheme.standard

        let primary = theme.resolvedActionButtonStyle(for: .primary)
        let quiet = theme.resolvedActionButtonStyle(for: .quiet)
        let destructive = theme.resolvedActionButtonStyle(for: .destructive)

        #expect(primary.fillRole == .surfaceMuted)
        #expect(primary.borderRole == .border)
        #expect(primary.foregroundRole == .primaryText)
        #expect(primary.accentRuleRole == nil)
        #expect(primary.accentRuleOpacity == 0)
        #expect(quiet.fillRole == nil)
        #expect(quiet.borderRole == nil)
        #expect(quiet.foregroundRole == .accent)
        #expect(destructive.foregroundRole == .destructive)
        #expect(destructive.accentRuleRole == nil)
        #expect(destructive.accentRuleOpacity == 0)
        #expect(primary.horizontalPadding == theme.spacing.group)
        #expect(quiet.verticalPadding < primary.verticalPadding)
    }
}
