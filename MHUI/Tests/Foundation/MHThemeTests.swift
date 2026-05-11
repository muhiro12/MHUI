// swiftlint:disable function_body_length
@testable import MHUI
import SwiftUI
import Testing

struct MHThemeTests {
    @Test
    func standard_theme_uses_semantic_defaults() {
        let theme = MHTheme.standard
        let tintTheme = MHTheme.standard(accent: .tint)

        #expect(theme == tintTheme)
        #expect(theme.colors.background == .asset(.mhBackground))
        #expect(theme.colors.surface == .asset(.mhSurface))
        #expect(theme.colors.surfaceTint == .asset(.mhSurfaceTint))
        #expect(theme.colors.surfaceMuted == .asset(.mhSurfaceMuted))
        #expect(theme.colors.surfaceMutedTint == .asset(.mhSurfaceMutedTint))
        #expect(theme.colors.surfaceBorder == .asset(.mhSurfaceBorder))
        #expect(theme.colors.surfaceMutedBorder == .asset(.mhSurfaceMutedBorder))
        #expect(theme.colors.controlBorder == .asset(.mhControlBorder))
        #expect(theme.colors.border == .asset(.mhBorder))
        #expect(theme.colors.divider == .asset(.mhDivider))
        #expect(theme.colors.primaryText == .asset(.mhPrimaryText))
        #expect(theme.colors.secondaryText == .asset(.mhSecondaryText))
        #expect(theme.colors.positive == .asset(.mhPositive))
        #expect(theme.colors.warning == .asset(.mhWarning))
        #expect(theme.colors.destructive == .asset(.mhDestructive))
        #expect(theme.colors.destructiveTint == .asset(.mhDestructiveTint))
        #expect(theme.colors.destructiveBorder == .asset(.mhDestructiveBorder))
        #expect(theme.colors.inputBorder == .asset(.mhInputBorder))
        #expect(theme.colors.inputTint == .asset(.mhInputTint))
        #expect(theme.colors.inputInvalidFill == .asset(.mhInputInvalidFill))
        #expect(theme.colors.inputInvalidTint == .asset(.mhInputInvalidTint))
        #expect(theme.colors.badgeNeutralFill == .asset(.mhBadgeNeutralFill))
        #expect(theme.colors.badgeNeutralBorder == .asset(.mhBadgeNeutralBorder))
        #expect(theme.colors.badgePositiveFill == .asset(.mhBadgePositiveFill))
        #expect(theme.colors.badgePositiveBorder == .asset(.mhBadgePositiveBorder))
        #expect(theme.colors.badgeWarningFill == .asset(.mhBadgeWarningFill))
        #expect(theme.colors.badgeWarningBorder == .asset(.mhBadgeWarningBorder))
        #expect(theme.colors.badgeDestructiveFill == .asset(.mhBadgeDestructiveFill))
        #expect(theme.colors.badgeDestructiveBorder == .asset(.mhBadgeDestructiveBorder))
        #expect(theme.metrics == MHDesignMetrics.standard)
        #expect(theme.colors.accent == .tint)
        #expect(theme.spacing.inline == 8)
        #expect(theme.spacing.control == 16)
        #expect(theme.spacing.content == 24)
        #expect(theme.spacing.section == 32)
        #expect(theme.spacing.screen == 40)
        #expect(theme.cornerRadius.control == 8)
        #expect(theme.cornerRadius.surface == 16)
        #expect(theme.divider.colorRole == .divider)
        #expect(theme.motion.quick == 0.14)
        #expect(theme.motion.regular == 0.22)
        #expect(theme.layout.readableContentWidth == 640)
        #expect(theme.layout.compactWidthThreshold == 600)
        #expect(theme.layout.screen.contentInsetHorizontal == 40)
        #expect(theme.layout.screen.contentInsetVertical == 72)
        #expect(theme.layout.screen.contentSpacing == 48)
        #expect(theme.layout.screen.compactContentInsetHorizontal == 16)
        #expect(theme.layout.screen.compactContentInsetVertical == 32)
        #expect(theme.layout.screen.compactContentSpacing == 24)
        #expect(theme.layout.surface.insetHorizontal == 24)
        #expect(theme.layout.surface.insetVertical == 24)
        #expect(theme.layout.surface.compactInsetHorizontal == 16)
        #expect(theme.layout.surface.compactInsetVertical == 16)
        #expect(theme.layout.control.minimumTouchTarget == 44)
        #expect(theme.presentation.rowHorizontalInset == 24)
        #expect(theme.presentation.rowVerticalPadding == 16)
        #expect(theme.presentation.rowAccessorySpacing == 16)
        #expect(theme.presentation.compactRowHorizontalInset == 16)
        #expect(theme.presentation.compactRowVerticalPadding == 8)
        #expect(theme.presentation.compactRowAccessorySpacing == 8)
        #expect(theme.presentation.compactActionHorizontalPadding == 16)
        #expect(theme.presentation.compactActionVerticalPadding == 8)
        #expect(theme.presentation.regularKeyValueMinimumValueWidth == 160)
        #expect(theme.presentation.compactKeyValueMinimumValueWidth == 120)
        #expect(theme.presentation.compactKeyValueSpacing == 8)
        #expect(theme.presentation.compactActionGroupSpacing == 8)
        #expect(theme.presentation.screenCueWidth == 24)
        #expect(theme.presentation.screenCueHeight == 2)
        #expect(theme.presentation.sectionCueWidth == 16)
        #expect(theme.presentation.sectionCueHeight == 2)
        #expect(!theme.surfaces.canvas.prefersGlass)
        #expect(theme.surfaces.standard.prefersGlass)
        #expect(theme.surfaces.muted.prefersGlass)
        #expect(theme.surfaces.standard.fallbackColorRole == .surface)
        #expect(theme.surfaces.muted.fallbackColorRole == .surfaceMuted)
        #expect(theme.surfaces.standard.glassTintColorRole == .surfaceTint)
        #expect(theme.surfaces.muted.glassTintColorRole == .surfaceMutedTint)
        #expect(theme.surfaces.standard.borderColorRole == .surfaceBorder)
        #expect(theme.surfaces.muted.borderColorRole == .surfaceMutedBorder)
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
            screenContentInsetVertical: 80,
            surfaceContentInsetHorizontal: 28,
            minimumTouchTarget: 52
        )
        custom.colors.accent = .tint

        values.mhTheme = custom

        #expect(values.mhTheme == custom)
        #expect(values.mhTheme.spacing.screen == 44)
        #expect(values.mhTheme.layout.screen.contentInsetVertical == 80)
        #expect(values.mhTheme.layout.surface.insetHorizontal == 28)
        #expect(values.mhTheme.layout.control.minimumTouchTarget == 52)
        #expect(values.mhTheme.colors.accent == .tint)
    }

    @Test
    func environment_values_resolve_theme_with_design_metrics_precedence() {
        var values = EnvironmentValues()
        let customTheme = MHTheme.standard(accent: .fixed(
            lightHex: 0x2473E6,
            darkHex: 0x73ADFF
        ))
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
        #expect(values.mhTheme.resolvedCueStyle(for: .screen).width == customTheme.presentation.screenCueWidth)
        #expect(values.mhTheme.layout.surface.insetHorizontal == 28)
        #expect(values.mhTheme.layout.control.minimumTouchTarget == 52)
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
