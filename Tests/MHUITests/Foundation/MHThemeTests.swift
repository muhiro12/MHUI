// swiftlint:disable function_body_length
@testable import MHUI
import SwiftUI
import Testing

struct MHThemeTests {
    @Test
    func color_components_support_hex_color_codes() {
        let components = MHColorComponents(
            hex: 0xF2F2F2,
            opacity: 0.60
        )

        #expect(abs(components.red - (242.0 / 255.0)) < 0.0001)
        #expect(abs(components.green - (242.0 / 255.0)) < 0.0001)
        #expect(abs(components.blue - (242.0 / 255.0)) < 0.0001)
        #expect(components.opacity == 0.60)
    }

    @Test
    func standard_theme_uses_semantic_defaults() {
        let theme = MHTheme.standard
        let tintTheme = MHTheme.standard(accent: .tint)
        let accentReferences = MHAccentStyle.allCases.map { accentStyle in
            MHTheme.standard(accentStyle: accentStyle).colors.accent
        }

        #expect(theme == tintTheme)
        #expect(theme.colors.background == .adaptive(.init(
            light: .init(hex: 0xF2F2F2),
            dark: .init(hex: 0x1F1F21)
        )))
        #expect(theme.colors.surface == .adaptive(.init(
            light: .init(hex: 0xFBFBFB),
            dark: .init(hex: 0x29292B)
        )))
        #expect(theme.colors.surfaceMuted == .adaptive(.init(
            light: .init(hex: 0xEDEDF0),
            dark: .init(hex: 0x363638)
        )))
        #expect(theme.colors.border == .adaptive(.init(
            light: .init(hex: 0xBABAC2, opacity: 0.60),
            dark: .init(hex: 0x666670, opacity: 0.72)
        )))
        #expect(theme.colors.primaryText == .adaptive(.init(
            light: .init(hex: 0x212124),
            dark: .init(hex: 0xEBEBED)
        )))
        #expect(theme.colors.secondaryText == .adaptive(.init(
            light: .init(hex: 0x6D6D73),
            dark: .init(hex: 0xADADB5)
        )))
        #expect(theme.colors.accent == .tint)
        #expect(accentReferences == [
            .adaptive(.init(
                light: .init(hex: 0xED6E1A),
                dark: .init(hex: 0xFFB347)
            )),
            .adaptive(.init(
                light: .init(hex: 0x2473E6),
                dark: .init(hex: 0x73ADFF)
            )),
            .adaptive(.init(
                light: .init(hex: 0x1A945C),
                dark: .init(hex: 0x63D18C)
            )),
            .adaptive(.init(
                light: .init(hex: 0xD1383D),
                dark: .init(hex: 0xFF7375)
            )),
            .adaptive(.init(
                light: .init(hex: 0x734DDB),
                dark: .init(hex: 0xB891FF)
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
        #expect(theme.layout.readableContentWidth == 640)
        #expect(theme.layout.compactWidthThreshold == 600)
        #expect(theme.layout.screenHorizontalMargin == 40)
        #expect(theme.layout.screenVerticalPadding == 72)
        #expect(theme.layout.screenContentSpacing == 44)
        #expect(theme.layout.compactScreenHorizontalMargin == 20)
        #expect(theme.layout.compactScreenVerticalPadding == 40)
        #expect(theme.layout.compactScreenContentSpacing == 28)
        #expect(theme.layout.surfaceInsetHorizontal == 20)
        #expect(theme.layout.surfaceInsetVertical == 24)
        #expect(theme.layout.compactSurfaceInsetHorizontal == 16)
        #expect(theme.layout.compactSurfaceInsetVertical == 18)
        #expect(theme.layout.rowHorizontalInset == 20)
        #expect(theme.layout.rowVerticalPadding == 16)
        #expect(theme.layout.rowAccessorySpacing == 12)
        #expect(theme.layout.compactRowHorizontalInset == 16)
        #expect(theme.layout.compactRowVerticalPadding == 12)
        #expect(theme.layout.compactRowAccessorySpacing == 10)
        #expect(theme.layout.compactActionHorizontalPadding == 14)
        #expect(theme.layout.compactActionVerticalPadding == 10)
        #expect(theme.layout.compactKeyValueSpacing == 6)
        #expect(theme.layout.compactActionGroupSpacing == 8)
        #expect(theme.layout.screenCueWidth == 20)
        #expect(theme.layout.screenCueHeight == 2)
        #expect(theme.layout.sectionCueWidth == 12)
        #expect(theme.layout.sectionCueHeight == 2)
        #expect(!theme.surfaces.canvas.prefersGlass)
        #expect(theme.surfaces.standard.prefersGlass)
        #expect(theme.surfaces.muted.prefersGlass)
        #expect(theme.surfaces.standard.fallbackColorRole == .surface)
        #expect(theme.surfaces.muted.fallbackColorRole == .surfaceMuted)
        #expect(theme.surfaces.standard.glassTintColorRole == .surface)
        #expect(theme.surfaces.muted.glassTintColorRole == .surfaceMuted)
        #expect(theme.typography.screenTitle.weight == .semibold)
        #expect(theme.typography.sectionTitle.weight == .semibold)
        #expect(theme.typography.bodyStrong.weight == .medium)
        #expect(theme.typography.supporting.weight == .regular)
        #expect(theme.typography.metadata.weight == .medium)
        #expect(theme.typography.caption.weight == .medium)

        let primary = theme.resolvedActionButtonStyle(
            for: .primary,
            context: .init(),
            glassPolicy: .disabled,
            reduceTransparency: false,
            supportsGlass: false
        )
        #expect(primary.backgroundStyle?.fallbackFillRole == .surfaceMuted)
        #expect(primary.foregroundRole == .primaryText)
        #expect(primary.backgroundStyle?.borderRole == .accent)
    }

    @Test
    func environment_values_store_theme_overrides() {
        var values = EnvironmentValues()
        var custom = MHTheme.standard
        custom.spacing.screen = 44
        custom.layout.screenVerticalPadding = 80
        custom.colors.accent = .tint

        values.mhTheme = custom

        #expect(values.mhTheme == custom)
        #expect(values.mhTheme.spacing.screen == 44)
        #expect(values.mhTheme.layout.screenVerticalPadding == 80)
        #expect(values.mhTheme.colors.accent == .tint)
    }

    @Test
    func environment_values_store_glass_policy_overrides() {
        var values = EnvironmentValues()

        #expect(values.mhGlassPolicy == .automatic)

        values.mhGlassPolicy = .enabled

        #expect(values.mhGlassPolicy == .enabled)
    }

    @Test
    func environment_values_store_action_and_key_value_policies() {
        var values = EnvironmentValues()

        #expect(values.mhActionPresentation == .automatic)
        #expect(values.mhKeyValueLayout == .automatic)

        values.mhActionPresentation = .fullWidthLeading
        values.mhKeyValueLayout = .vertical

        #expect(values.mhActionPresentation == .fullWidthLeading)
        #expect(values.mhKeyValueLayout == .vertical)
    }
}
// swiftlint:enable function_body_length
