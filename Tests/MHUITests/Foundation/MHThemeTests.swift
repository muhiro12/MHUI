// swiftlint:disable function_body_length
import MHDesign
@testable import MHUI
import SwiftUI
import Testing

struct MHThemeTests {
    @Test
    func standard_theme_uses_semantic_defaults() {
        let theme = MHTheme.standard
        let tintTheme = MHTheme.standard(accent: .tint)

        #expect(theme == tintTheme)
        #expect(theme.colors.background == .fixed(
            lightHex: 0xF2F2F2,
            darkHex: 0x1F1F21
        ))
        #expect(theme.colors.surface == .fixed(
            lightHex: 0xFBFBFB,
            darkHex: 0x29292B
        ))
        #expect(theme.colors.surfaceMuted == .fixed(
            lightHex: 0xEDEDF0,
            darkHex: 0x363638
        ))
        #expect(theme.colors.border == .fixed(
            lightHex: 0xBABAC2,
            darkHex: 0x666670,
            lightOpacity: 0.60,
            darkOpacity: 0.72
        ))
        #expect(theme.colors.primaryText == .fixed(
            lightHex: 0x212124,
            darkHex: 0xEBEBED
        ))
        #expect(theme.colors.secondaryText == .fixed(
            lightHex: 0x6D6D73,
            darkHex: 0xADADB5
        ))
        #expect(theme.metrics == MHDesignMetrics.standard)
        #expect(theme.colors.accent == .tint)
        #expect(theme.spacing.inline == 4)
        #expect(theme.spacing.control == 12)
        #expect(theme.spacing.group == 20)
        #expect(theme.spacing.section == 32)
        #expect(theme.spacing.screen == 40)
        #expect(theme.radius.control == 8)
        #expect(theme.radius.surface == 12)
        #expect(theme.radius.pill > theme.radius.surface)
        #expect(theme.divider.opacity == 0.50)
        #expect(theme.motion.quick == 0.14)
        #expect(theme.motion.regular == 0.22)
        #expect(theme.layout.readableContentWidth == 640)
        #expect(theme.layout.compactWidthThreshold == 600)
        #expect(theme.layout.narrowWidthThreshold == 360)
        #expect(theme.layout.screenHorizontalMargin == 40)
        #expect(theme.layout.screenVerticalPadding == 72)
        #expect(theme.layout.screenContentSpacing == 44)
        #expect(theme.layout.compactScreenHorizontalMargin == 16)
        #expect(theme.layout.compactScreenVerticalPadding == 32)
        #expect(theme.layout.compactScreenContentSpacing == 24)
        #expect(theme.layout.surfaceInsetHorizontal == 20)
        #expect(theme.layout.surfaceInsetVertical == 24)
        #expect(theme.layout.compactSurfaceInsetHorizontal == 14)
        #expect(theme.layout.compactSurfaceInsetVertical == 16)
        #expect(theme.layout.rowHorizontalInset == 20)
        #expect(theme.layout.rowVerticalPadding == 16)
        #expect(theme.layout.rowAccessorySpacing == 12)
        #expect(theme.layout.compactRowHorizontalInset == 14)
        #expect(theme.layout.compactRowVerticalPadding == 12)
        #expect(theme.layout.compactRowAccessorySpacing == 10)
        #expect(theme.layout.compactActionHorizontalPadding == 12)
        #expect(theme.layout.compactActionVerticalPadding == 9)
        #expect(theme.layout.regularKeyValueMinimumValueWidth == 160)
        #expect(theme.layout.compactKeyValueMinimumValueWidth == 120)
        #expect(theme.layout.compactKeyValueSpacing == 8)
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
    func standard_theme_accepts_fixed_accent_sources() {
        let accent = MHColorReference.fixed(
            lightHex: 0x2473E6,
            darkHex: 0x73ADFF
        )
        let theme = MHTheme.standard(accent: accent)

        #expect(theme.colors.accent == accent)
    }

    @Test
    func environment_values_store_theme_overrides() {
        var values = EnvironmentValues()
        var custom = MHTheme.standard
        custom.metrics = customDesignMetrics(
            spacingScreen: 44,
            screenVerticalPadding: 80
        )
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

private func customDesignMetrics(
    spacingScreen: CGFloat,
    screenVerticalPadding: CGFloat
) -> MHDesignMetrics {
    let standard = MHDesignMetrics.standard

    return .init(
        spacing: .init(
            inline: standard.spacing.inline,
            control: standard.spacing.control,
            group: standard.spacing.group,
            section: standard.spacing.section,
            screen: spacingScreen
        ),
        radius: standard.radius,
        layout: .init(
            readableContentWidth: standard.layout.readableContentWidth,
            compactWidthThreshold: standard.layout.compactWidthThreshold,
            narrowWidthThreshold: standard.layout.narrowWidthThreshold,
            screenHorizontalMargin: standard.layout.screenHorizontalMargin,
            screenVerticalPadding: screenVerticalPadding,
            screenContentSpacing: standard.layout.screenContentSpacing,
            compactScreenHorizontalMargin: standard.layout.compactScreenHorizontalMargin,
            compactScreenVerticalPadding: standard.layout.compactScreenVerticalPadding,
            compactScreenContentSpacing: standard.layout.compactScreenContentSpacing,
            surfaceInsetHorizontal: standard.layout.surfaceInsetHorizontal,
            surfaceInsetVertical: standard.layout.surfaceInsetVertical,
            compactSurfaceInsetHorizontal: standard.layout.compactSurfaceInsetHorizontal,
            compactSurfaceInsetVertical: standard.layout.compactSurfaceInsetVertical,
            rowHorizontalInset: standard.layout.rowHorizontalInset,
            rowVerticalPadding: standard.layout.rowVerticalPadding,
            rowAccessorySpacing: standard.layout.rowAccessorySpacing,
            compactRowHorizontalInset: standard.layout.compactRowHorizontalInset,
            compactRowVerticalPadding: standard.layout.compactRowVerticalPadding,
            compactRowAccessorySpacing: standard.layout.compactRowAccessorySpacing,
            compactActionHorizontalPadding: standard.layout.compactActionHorizontalPadding,
            compactActionVerticalPadding: standard.layout.compactActionVerticalPadding,
            regularKeyValueMinimumValueWidth: standard.layout.regularKeyValueMinimumValueWidth,
            compactKeyValueMinimumValueWidth: standard.layout.compactKeyValueMinimumValueWidth,
            compactKeyValueSpacing: standard.layout.compactKeyValueSpacing,
            compactActionGroupSpacing: standard.layout.compactActionGroupSpacing,
            screenCueWidth: standard.layout.screenCueWidth,
            screenCueHeight: standard.layout.screenCueHeight,
            sectionCueWidth: standard.layout.sectionCueWidth,
            sectionCueHeight: standard.layout.sectionCueHeight
        )
    )
}
