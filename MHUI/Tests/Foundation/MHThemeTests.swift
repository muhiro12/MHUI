// swiftlint:disable function_body_length
@testable import MHUI
import SwiftUI
import Testing

struct MHThemeTests {
    @Test
    func standard_theme_uses_semantic_defaults() {
        let theme = MHTheme.standard

        #expect(theme.colors.background == .asset(MHColorAsset.background))
        #expect(theme.colors.surface == .asset(MHColorAsset.surface))
        #expect(theme.colors.surfaceElevated == .asset(MHColorAsset.surfaceElevated))
        #expect(theme.colors.surfaceMuted == .asset(MHColorAsset.surfaceMuted))
        #expect(theme.colors.border == .asset(MHColorAsset.border))
        #expect(theme.colors.primaryText == .asset(MHColorAsset.primaryText))
        #expect(theme.colors.secondaryText == .asset(MHColorAsset.secondaryText))
        #expect(theme.colors.tertiaryText == .asset(MHColorAsset.tertiaryText))
        #expect(theme.colors.accent == .tint)
        #expect(theme.colors.onAccent == .asset(MHColorAsset.onAccent))
        #expect(theme.colors.warning == .asset(MHColorAsset.warning))
        #expect(theme.colors.destructive == .asset(MHColorAsset.destructive))
        #expect(theme.nativeTintOverride(in: .light) == nil)
        #expect(theme.metrics == MHDesignMetrics.standard)
        #expect(theme == MHTheme.standard())
        #expect(theme.spacing.inline == 8)
        #expect(theme.spacing.control == 16)
        #expect(theme.spacing.content == 24)
        #expect(theme.spacing.section == 32)
        #expect(theme.spacing.screen == 40)
        #expect(theme.cornerRadius.control == 8)
        #expect(theme.cornerRadius.surface == 12)
        #expect(theme.divider.opacity == 0.75)
        #expect(theme.motion.quick == 0.14)
        #expect(theme.motion.regular == 0.22)
        #if os(watchOS)
        #expect(theme.layout.readableContentWidth == 320)
        #expect(theme.layout.compactWidthThreshold == 300)
        #expect(theme.layout.screen.contentInsetHorizontal == 16)
        #expect(theme.layout.screen.contentInsetVertical == 20)
        #expect(theme.layout.screen.contentSpacing == 16)
        #expect(theme.layout.screen.compactContentInsetHorizontal == 12)
        #expect(theme.layout.screen.compactContentInsetVertical == 12)
        #expect(theme.layout.screen.compactContentSpacing == 12)
        #expect(theme.layout.surface.insetHorizontal == 12)
        #expect(theme.layout.surface.insetVertical == 12)
        #expect(theme.layout.surface.compactInsetHorizontal == 12)
        #expect(theme.layout.surface.compactInsetVertical == 12)
        #else
        #expect(theme.layout.readableContentWidth == 640)
        #expect(theme.layout.compactWidthThreshold == 600)
        #expect(theme.layout.screen.contentInsetHorizontal == 40)
        #expect(theme.layout.screen.contentInsetVertical == 72)
        #expect(theme.layout.screen.contentSpacing == 48)
        #expect(theme.layout.screen.compactContentInsetHorizontal == 20)
        #expect(theme.layout.screen.compactContentInsetVertical == 32)
        #expect(theme.layout.screen.compactContentSpacing == 32)
        #expect(theme.layout.surface.insetHorizontal == 24)
        #expect(theme.layout.surface.insetVertical == 24)
        #expect(theme.layout.surface.compactInsetHorizontal == 20)
        #expect(theme.layout.surface.compactInsetVertical == 16)
        #endif
        #if os(macOS)
        #expect(theme.layout.control.minimumTouchTarget == 28)
        #else
        #expect(theme.layout.control.minimumTouchTarget == 44)
        #endif
        #expect(theme.presentation.rowHorizontalInset == 24)
        #expect(theme.presentation.rowVerticalPadding == 16)
        #expect(theme.presentation.rowAccessorySpacing == 16)
        #expect(theme.presentation.compactRowHorizontalInset == 20)
        #expect(theme.presentation.compactRowVerticalPadding == 12)
        #expect(theme.presentation.compactRowAccessorySpacing == 12)
        #expect(theme.presentation.compactActionHorizontalPadding == 20)
        #expect(theme.presentation.compactActionVerticalPadding == 12)
        #expect(theme.presentation.regularKeyValueMinimumValueWidth == 160)
        #expect(theme.presentation.compactKeyValueMinimumValueWidth == 120)
        #expect(theme.presentation.compactKeyValueSpacing == 8)
        #expect(theme.presentation.compactActionGroupSpacing == 12)
        #expect(theme.presentation.screenCuePlacement == .leading)
        #expect(theme.presentation.screenCueLength == 72)
        #expect(theme.presentation.screenCueThickness == 2)
        #expect(theme.presentation.sectionCuePlacement == .leading)
        #expect(theme.presentation.sectionCueLength == 40)
        #expect(theme.presentation.sectionCueThickness == 2)
        #expect(!theme.surfaces.canvas.prefersGlass)
        #expect(!theme.surfaces.standard.prefersGlass)
        #expect(!theme.surfaces.elevated.prefersGlass)
        #expect(!theme.surfaces.muted.prefersGlass)
        #expect(theme.surfaces.standard.fallbackColorRole == .surface)
        #expect(theme.surfaces.elevated.fallbackColorRole == .surfaceElevated)
        #expect(theme.surfaces.muted.fallbackColorRole == .surfaceMuted)
        #expect(theme.surfaces.standard.glassTintColorRole == nil)
        #expect(theme.surfaces.standard.borderOpacity == 0.65)
        #expect(theme.surfaces.elevated.borderOpacity == 0.8)
        #expect(theme.surfaces.muted.glassTintColorRole == nil)
        #expect(theme.surfaces.muted.borderOpacity == 0.35)
        let primary = theme.resolvedActionButtonStyle(
            for: .primary,
            context: .init(),
            glassPolicy: .disabled,
            reduceTransparency: false,
            supportsGlass: false
        )
        #expect(primary.backgroundStyle?.fallbackFillRole == .accent)
        #expect(primary.backgroundStyle?.isGlassInteractive == false)
        #expect(primary.foregroundRole == .onAccent)
        #expect(primary.backgroundStyle?.borderRole == .accent)
    }

    @Test
    func standard_theme_accepts_asset_accent_sources() {
        let accent = MHColorReference.asset(
            MHColorAsset.warning
        )
        let theme = MHTheme.standard(accent: accent)

        #expect(theme.colors.accent == accent)
        #expect(theme.nativeTintOverride(in: .light) != nil)
        #expect(theme.nativeTintOverride(in: .dark) != nil)
    }

    @Test
    func standard_theme_accepts_custom_design_metrics() {
        let metrics = customDesignMetrics(
            spacingScreen: 52,
            screenContentInsetVertical: 88,
            surfaceContentInsetHorizontal: 30,
            minimumTouchTarget: 48
        )
        let accent = MHColorReference.asset(
            MHColorAsset.warning
        )
        let theme = MHTheme.standard(
            metrics: metrics,
            accent: accent
        )

        #expect(theme.metrics == metrics)
        #expect(theme.colors.accent == accent)
        #expect(theme.colors.onAccent == .asset(MHColorAsset.onAccent))
        #expect(theme.spacing.screen == 52)
        #expect(theme.layout.screen.contentInsetVertical == 88)
        #expect(theme.layout.surface.insetHorizontal == 30)
        #expect(theme.layout.control.minimumTouchTarget == 48)
    }

    @Test
    func standard_theme_accepts_on_accent_overrides() {
        let accent = MHColorReference.asset(
            MHColorAsset.warning
        )
        let onAccent = MHColorReference.asset(
            MHColorAsset.primaryText
        )
        let theme = MHTheme.standard(
            accent: accent,
            onAccent: onAccent
        )
        let standardTheme = MHTheme.standard(onAccent: onAccent)

        #expect(theme.colors.accent == accent)
        #expect(theme.colors.onAccent == onAccent)
        #expect(standardTheme.colors.accent == .tint)
        #expect(standardTheme.colors.onAccent == onAccent)
    }

    @Test
    func environment_values_store_theme_overrides() {
        var values = EnvironmentValues()
        var custom = MHTheme.standard
        custom.metrics = customDesignMetrics(
            spacingScreen: 44,
            screenContentInsetVertical: 80,
            surfaceContentInsetHorizontal: 28,
            minimumTouchTarget: 52
        )
        custom.colors.accent = .tint

        values.mhTheme = custom

        #expect(values.mhTheme == custom)
        #expect(values.mhDesignMetrics == custom.metrics)
        #expect(!values.mhHasExplicitDesignMetrics)
        #expect(values.mhTheme.spacing.screen == 44)
        #expect(values.mhTheme.layout.screen.contentInsetVertical == 80)
        #expect(values.mhTheme.layout.surface.insetHorizontal == 28)
        #expect(values.mhTheme.layout.control.minimumTouchTarget == 52)
        #expect(values.mhTheme.colors.accent == .tint)
    }

    @Test
    func environment_values_resolve_theme_with_design_metrics_precedence() {
        var values = EnvironmentValues()
        let customTheme = MHTheme.standard(
            accent: .asset(MHColorAsset.warning)
        )
        let otherMetrics = customDesignMetrics(
            spacingScreen: 44,
            screenContentInsetVertical: 80,
            surfaceContentInsetHorizontal: 28,
            minimumTouchTarget: 52
        )

        values.mhTheme = customTheme

        #expect(values.mhTheme.metrics == customTheme.metrics)
        #expect(values.mhTheme.colors == customTheme.colors)
        #expect(values.mhTheme.typography == customTheme.typography)

        values.mhDesignMetrics = otherMetrics

        #expect(values.mhDesignMetrics == otherMetrics)
        #expect(values.mhHasExplicitDesignMetrics)
        #expect(values.mhTheme.metrics == otherMetrics)
        #expect(values.mhTheme.presentation == customTheme.presentation)
        #expect(values.mhTheme.colors == customTheme.colors)
        #expect(values.mhTheme.typography == customTheme.typography)

        let compactContext = MHAdaptiveLayoutContext(
            availableWidth: 375,
            horizontalSizeClass: .compact
        )

        #expect(values.mhTheme.resolvedScreenChromeStyle().verticalPadding == 80)
        #expect(values.mhTheme.resolvedRowChromeStyle().verticalPadding == customTheme.presentation.rowVerticalPadding)
        #expect(
            values.mhTheme.resolvedActionGroupStyle(for: compactContext).spacing
                == customTheme.presentation.compactActionGroupSpacing
        )
        #expect(
            values.mhTheme.resolvedCueStyle(for: .screen).length
                == customTheme.presentation.screenCueLength
        )
        #expect(values.mhTheme.layout.surface.insetHorizontal == 28)
        #expect(values.mhTheme.layout.control.minimumTouchTarget == 52)

        values.mhTheme = customTheme

        #expect(values.mhDesignMetrics == customTheme.metrics)
        #expect(!values.mhHasExplicitDesignMetrics)
        #expect(values.mhTheme == customTheme)
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
    screenContentInsetVertical: CGFloat,
    surfaceContentInsetHorizontal: CGFloat,
    minimumTouchTarget: CGFloat
) -> MHDesignMetrics {
    let standard = MHDesignMetrics.standard

    return .init(
        spacing: .init(
            inline: standard.spacing.inline,
            control: standard.spacing.control,
            content: standard.spacing.content,
            section: standard.spacing.section,
            screen: spacingScreen
        ),
        cornerRadius: .init(
            control: standard.cornerRadius.control,
            surface: standard.cornerRadius.surface
        ),
        layout: .init(
            readableContentWidth: standard.layout.readableContentWidth,
            compactWidthThreshold: standard.layout.compactWidthThreshold,
            screen: .init(
                contentInsetHorizontal: standard.layout.screen.contentInsetHorizontal,
                contentInsetVertical: screenContentInsetVertical,
                contentSpacing: standard.layout.screen.contentSpacing,
                compactContentInsetHorizontal: standard.layout.screen.compactContentInsetHorizontal,
                compactContentInsetVertical: standard.layout.screen.compactContentInsetVertical,
                compactContentSpacing: standard.layout.screen.compactContentSpacing
            ),
            surface: .init(
                insetHorizontal: surfaceContentInsetHorizontal,
                insetVertical: standard.layout.surface.insetVertical,
                compactInsetHorizontal: standard.layout.surface.compactInsetHorizontal,
                compactInsetVertical: standard.layout.surface.compactInsetVertical
            ),
            control: .init(
                minimumTouchTarget: minimumTouchTarget
            )
        )
    )
}
