@testable import MHUI
import SwiftUI
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
        let metadata = theme.resolvedTextStyle(
            for: .metadata,
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
        #expect(metadata.metrics == theme.typography.metadata)
        #expect(metadata.tracking == 0.18)
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
        #expect(quiet.pressedOpacity == 0.72)
        #expect(quiet.disabledOpacity == 0.50)
        #expect(destructive.foregroundRole == .destructive)
        #expect(destructive.accentRuleRole == nil)
        #expect(destructive.accentRuleOpacity == 0)
        #expect(primary.horizontalPadding == theme.spacing.group)
        #expect(quiet.verticalPadding < primary.verticalPadding)
        #expect(primary.pressedOpacity == 0.88)
        #expect(primary.disabledOpacity == 0.55)
    }

    @Test
    func compact_layout_resolution_uses_theme_owned_fallbacks() {
        let theme = MHTheme.standard
        let compactContext = MHAdaptiveLayoutContext(
            availableWidth: 375,
            horizontalSizeClass: .compact
        )

        let screen = theme.resolvedScreenChromeStyle(for: compactContext)
        let row = theme.resolvedRowChromeStyle(for: compactContext)
        let action = theme.resolvedActionButtonStyle(
            for: .primary,
            context: compactContext
        )
        let grouped = theme.resolvedGroupedRowsStyle(
            showsDividers: true,
            for: compactContext
        )
        let section = theme.resolvedSectionChromeStyle(for: compactContext)
        let actionGroup = theme.resolvedActionGroupStyle(for: compactContext)

        #expect(screen.readableContentWidth == nil)
        #expect(screen.horizontalMargin == theme.layout.compactScreenHorizontalMargin)
        #expect(screen.verticalPadding == theme.layout.compactScreenVerticalPadding)
        #expect(screen.contentSpacing == theme.layout.compactScreenContentSpacing)
        #expect(row.horizontalInset == theme.layout.compactRowHorizontalInset)
        #expect(row.verticalPadding == theme.layout.compactRowVerticalPadding)
        #expect(row.accessorySpacing == theme.layout.compactRowAccessorySpacing)
        #expect(action.horizontalPadding == theme.layout.compactActionHorizontalPadding)
        #expect(action.verticalPadding == theme.layout.compactActionVerticalPadding)
        #expect(grouped.dividerLeadingInset == row.horizontalInset + theme.spacing.inline)
        #expect(grouped.spacerHeight == row.verticalPadding)
        #expect(section.contentSpacing == theme.layout.compactKeyValueSpacing)
        #expect(actionGroup.spacing == theme.layout.compactActionGroupSpacing)
    }

    @Test
    @MainActor
    func button_style_static_members_resolve_roles() {
        let primary: MHActionButtonStyle = .mhPrimary
        let secondary: MHActionButtonStyle = .mhSecondary
        let quiet: MHActionButtonStyle = .mhQuiet
        let destructive: MHActionButtonStyle = .mhDestructive
        let custom: MHActionButtonStyle = .mhAction(.secondary)

        #expect(primary.buttonRole == .primary)
        #expect(secondary.buttonRole == .secondary)
        #expect(quiet.buttonRole == .quiet)
        #expect(destructive.buttonRole == .destructive)
        #expect(custom.buttonRole == .secondary)
    }

    @Test
    func surface_and_group_styles_resolve_from_theme_tokens() {
        let theme = MHTheme.standard
        let grouped = theme.resolvedGroupedRowsStyle(showsDividers: true)
        let disabledSurface = theme.resolvedSurfaceStyle(
            for: .standard,
            materialPolicy: .disabled,
            reduceTransparency: false
        )
        let materialSurface = theme.resolvedSurfaceStyle(
            for: .standard,
            materialPolicy: .enabled,
            reduceTransparency: false
        )
        let solidSurface = theme.resolvedSurfaceStyle(
            for: .standard,
            materialPolicy: .enabled,
            reduceTransparency: true
        )
        let canvas = theme.resolvedCanvasSurfaceStyle(
            materialPolicy: .enabled,
            reduceTransparency: false
        )

        #expect(theme.surfaceColorRole(for: .standard) == .surface)
        #expect(theme.surfaceColorRole(for: .muted) == .surfaceMuted)
        #expect(grouped.showsDividers)
        #expect(grouped.dividerLeadingInset == theme.layout.surfaceInsetHorizontal + theme.spacing.inline)
        #expect(grouped.dividerThickness == theme.divider.thickness)
        #expect(grouped.dividerOpacity == theme.divider.opacity)
        #expect(grouped.spacerHeight == theme.layout.rowVerticalPadding)
        #expect(!disabledSurface.usesMaterial)
        #expect(disabledSurface.materialStyle == nil)
        #expect(disabledSurface.fillColorRole == .surface)
        #expect(materialSurface.usesMaterial)
        #expect(materialSurface.materialStyle == .regular)
        #expect(materialSurface.fillColorRole == .surface)
        #expect(materialSurface.overlayColorRole == .surface)
        #expect(!solidSurface.usesMaterial)
        #expect(solidSurface.materialStyle == nil)
        #expect(solidSurface.fillColorRole == .surface)
        #expect(canvas.materialStyle == .ultraThin)
    }

    @Test
    func key_value_style_defaults_stay_primary_to_secondary() {
        let theme = MHTheme.standard
        let rowChrome = theme.resolvedRowChromeStyle()
        let style = theme.resolvedKeyValueStyle()

        #expect(style.labelColorRole == .primaryText)
        #expect(style.valueColorRole == .secondaryText)
        #expect(rowChrome.verticalPadding == theme.layout.rowVerticalPadding)
        #expect(rowChrome.horizontalInset == theme.layout.rowHorizontalInset)
        #expect(rowChrome.accessorySpacing == theme.layout.rowAccessorySpacing)
        #expect(style.rowChrome == rowChrome)
        #expect(style.stackedSpacing == theme.layout.compactKeyValueSpacing)
    }

    @Test
    func action_presentation_policies_resolve_expected_behaviors() {
        let theme = MHTheme.standard
        let compactContext = MHAdaptiveLayoutContext(
            availableWidth: 320,
            horizontalSizeClass: .compact
        )

        let automatic = theme.resolvedActionPresentation(
            .automatic,
            for: compactContext
        )
        let intrinsic = theme.resolvedActionPresentation(
            .singleLineIntrinsic,
            for: compactContext
        )
        let fullWidth = theme.resolvedActionPresentation(
            .fullWidth,
            for: compactContext
        )
        let fullWidthLeading = theme.resolvedActionPresentation(
            .fullWidthLeading,
            for: compactContext
        )

        #expect(automatic.lineLimit == 1)
        #expect(!automatic.usesFixedHorizontalSize)
        #expect(!automatic.expandsHorizontally)
        #expect(intrinsic.lineLimit == 1)
        #expect(intrinsic.usesFixedHorizontalSize)
        #expect(!intrinsic.expandsHorizontally)
        #expect(fullWidth.expandsHorizontally)
        #expect(fullWidth.alignment == .center)
        #expect(fullWidthLeading.expandsHorizontally)
        #expect(fullWidthLeading.alignment == .leading)
    }

    @Test
    func input_and_badge_styles_resolve_from_theme_tokens() {
        let theme = MHTheme.standard
        let focusedInput = theme.resolvedInputChromeStyle(for: .focused)
        let invalidInput = theme.resolvedInputChromeStyle(for: .invalid)
        let neutralBadge = theme.resolvedBadgeChromeStyle(for: .neutral)
        let accentBadge = theme.resolvedBadgeChromeStyle(for: .accent)

        #expect(focusedInput.fillRole == .surface)
        #expect(focusedInput.borderRole == .accent)
        #expect(focusedInput.borderOpacity == 0.24)
        #expect(focusedInput.horizontalPadding == theme.spacing.group)
        #expect(invalidInput.fillRole == .destructive)
        #expect(invalidInput.fillOpacity == 0.04)
        #expect(invalidInput.borderOpacity == 0.18)
        #expect(neutralBadge.textRole == .caption)
        #expect(neutralBadge.foregroundRole == .secondaryText)
        #expect(neutralBadge.fillOpacity == 0.03)
        #expect(accentBadge.foregroundRole == .accent)
        #expect(accentBadge.borderOpacity == 0.10)
        #expect(accentBadge.horizontalPadding == theme.spacing.control)
    }

    @Test
    func screen_and_section_chrome_share_theme_tokens() {
        let theme = MHTheme.standard
        let screenCue = theme.resolvedCueStyle(for: .screen)
        let sectionCue = theme.resolvedCueStyle(for: .section)
        let screen = theme.resolvedScreenChromeStyle()
        let section = theme.resolvedSectionChromeStyle()

        #expect(screen.readableContentWidth == Optional(theme.layout.readableContentWidth))
        #expect(screen.horizontalMargin == theme.layout.screenHorizontalMargin)
        #expect(screen.verticalPadding == theme.layout.screenVerticalPadding)
        #expect(screenCue.colorRole == .accent)
        #expect(screenCue.width == theme.layout.screenCueWidth)
        #expect(screenCue.height == theme.layout.screenCueHeight)
        #expect(sectionCue.colorRole == .accent)
        #expect(sectionCue.width == theme.layout.sectionCueWidth)
        #expect(sectionCue.height == theme.layout.sectionCueHeight)
        #expect(screen.cueStyle == screenCue)
        #expect(section.cueStyle == sectionCue)
        #expect(section.contentSpacing == theme.spacing.control)
        #expect(section.leadingInset == theme.spacing.inline)
    }
}
