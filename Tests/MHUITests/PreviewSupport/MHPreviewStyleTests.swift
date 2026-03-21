@testable import MHUI
import Testing

struct MHPreviewStyleTests {
    @Test
    func preview_default_context_matches_runtime_tint_baseline() {
        let context = MHPreviewStyle.context()
        let theme = MHPreviewStyle.theme(for: context)

        #expect(context.accentStyle == nil)
        #expect(context.tintReference == .tint)
        #expect(context.title.contains("Host Tint"))
        #expect(theme.colors.accent == .tint)
    }

    @Test
    func preview_context_tracks_accent_glass_and_enabled_state() {
        let context = MHPreviewStyle.context(
            accentStyle: .blue,
            colorMode: .dark,
            glassPolicy: .enabled,
            typeScale: .accessibility,
            isEnabled: false
        )

        #expect(context.accentStyle == .blue)
        #expect(context.colorMode == .dark)
        #expect(context.glassPolicy == .enabled)
        #expect(context.typeScale == .accessibility)
        #expect(!context.isEnabled)
        #expect(context.tintReference == MHTheme.standard(accentStyle: .blue).colors.accent)
    }

    @Test
    func preview_theme_stays_aligned_with_runtime_tokens() {
        let theme = MHPreviewStyle.theme(for: MHPreviewStyle.context())

        #expect(theme.colors.accent == .tint)
        #expect(theme.spacing.control == MHTheme.standard.spacing.control)
        #expect(theme.layout.screenHorizontalMargin == MHTheme.standard.layout.screenHorizontalMargin)
        #expect(theme.layout.compactScreenHorizontalMargin == MHTheme.standard.layout.compactScreenHorizontalMargin)
    }

    @Test
    func preview_scenarios_stay_explicit_and_canonical() {
        let accentStyles = MHPreviewStyle.accentReviewScenarios()
            .map(\.context.accentStyle)

        #expect(MHPreviewStyle.foundationScenarios().count == 4)
        #expect(MHPreviewStyle.glassReviewScenarios().count == 4)
        #expect(accentStyles == MHAccentStyle.allCases.map(Optional.some))
        #expect(MHPreviewStyle.nativeContainerScenarios().map(\.context.colorMode) == [.light, .dark])
        #expect(MHPreviewStyle.foundationScenarios().map { Int($0.width.rounded()) } == [760, 375, 375, 320])
    }
}
