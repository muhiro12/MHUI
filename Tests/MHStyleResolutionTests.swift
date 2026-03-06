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

        #expect(style.metrics == theme.typography.sectionTitle)
        #expect(style.colorRole == .secondaryText)
    }

    @Test
    func action_button_resolution_stays_quiet_and_semantic() {
        let theme = MHTheme.standard

        let primary = theme.resolvedActionButtonStyle(for: .primary)
        let quiet = theme.resolvedActionButtonStyle(for: .quiet)
        let destructive = theme.resolvedActionButtonStyle(for: .destructive)

        #expect(primary.fillRole == .accent)
        #expect(primary.foregroundRole == .accent)
        #expect(quiet.fillRole == nil)
        #expect(quiet.borderRole == nil)
        #expect(destructive.foregroundRole == .destructive)
        #expect(primary.horizontalPadding == theme.spacing.group)
        #expect(quiet.verticalPadding < primary.verticalPadding)
    }
}
