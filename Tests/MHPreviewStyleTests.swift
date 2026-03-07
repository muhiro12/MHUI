@testable import MHUI
import Testing

struct MHPreviewStyleTests {
    @Test
    func preview_context_tracks_accent_material_and_enabled_state() {
        let context = MHPreviewStyle.context(
            accentStyle: .blue,
            colorMode: .dark,
            materialPolicy: .enabled,
            density: .compact,
            typeScale: .accessibility,
            isEnabled: false
        )

        #expect(context.accentStyle == .blue)
        #expect(context.colorMode == .dark)
        #expect(context.materialPolicy == .enabled)
        #expect(context.density == .compact)
        #expect(context.typeScale == .accessibility)
        #expect(!context.isEnabled)
        #expect(context.tintReference == MHTheme.standard(accentStyle: .blue).colors.accent)
    }

    @Test
    func preview_theme_compact_density_overrides_spacing_and_layout() {
        let theme = MHPreviewStyle.theme(
            for: MHPreviewStyle.context(density: .compact)
        )

        #expect(theme.colors.accent == .tint)
        #expect(theme.spacing.control == 10)
        #expect(theme.spacing.group == 16)
        #expect(theme.spacing.section == 24)
        #expect(theme.spacing.screen == 32)
        #expect(theme.layout.screenHorizontalMargin == 28)
        #expect(theme.layout.screenVerticalPadding == 56)
        #expect(theme.layout.surfaceInsetHorizontal == 16)
        #expect(theme.layout.rowVerticalPadding == 12)
        #expect(theme.layout.rowAccessorySpacing == 10)
    }
}
