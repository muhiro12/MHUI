// swiftlint:disable function_body_length type_body_length
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

        let primary = theme.resolvedActionButtonStyle(
            for: .primary,
            context: .init(),
            glassPolicy: .enabled,
            reduceTransparency: false,
            supportsGlass: true
        )
        let quiet = theme.resolvedActionButtonStyle(
            for: .quiet,
            context: .init(),
            glassPolicy: .enabled,
            reduceTransparency: false,
            supportsGlass: true
        )
        let destructive = theme.resolvedActionButtonStyle(
            for: .destructive,
            context: .init(),
            glassPolicy: .enabled,
            reduceTransparency: false,
            supportsGlass: true
        )

        #expect(primary.backgroundStyle?.usesGlass == true)
        #expect(primary.backgroundStyle?.fallbackFillRole == .accent)
        #expect(primary.backgroundStyle?.borderRole == .accent)
        #expect(primary.foregroundRole == .primaryText)
        #expect(quiet.backgroundStyle == nil)
        #expect(quiet.foregroundRole == .accent)
        #expect(quiet.pressedOpacity == 0.72)
        #expect(quiet.disabledOpacity == 0.50)
        #expect(destructive.foregroundRole == .destructive)
        #expect(destructive.backgroundStyle?.borderRole == .destructive)
        #expect(primary.horizontalPadding == theme.spacing.content)
        #expect(primary.minimumHeight == theme.layout.control.minimumTouchTarget)
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
            context: compactContext,
            glassPolicy: .disabled,
            reduceTransparency: false,
            supportsGlass: false
        )
        let grouped = theme.resolvedGroupedRowsStyle(
            showsDividers: true,
            for: compactContext
        )
        let section = theme.resolvedSectionChromeStyle(for: compactContext)
        let actionGroup = theme.resolvedActionGroupStyle(for: compactContext)
        let keyValue = theme.resolvedKeyValueStyle(for: compactContext)

        #expect(screen.readableContentWidth == nil)
        #expect(screen.horizontalMargin == theme.layout.screen.compactContentInsetHorizontal)
        #expect(screen.verticalPadding == theme.layout.screen.compactContentInsetVertical)
        #expect(screen.contentSpacing == theme.layout.screen.compactContentSpacing)
        #expect(row.horizontalInset == theme.presentation.compactRowHorizontalInset)
        #expect(row.verticalPadding == theme.presentation.compactRowVerticalPadding)
        #expect(row.accessorySpacing == theme.presentation.compactRowAccessorySpacing)
        #expect(action.horizontalPadding == theme.presentation.compactActionHorizontalPadding)
        #expect(action.verticalPadding == theme.presentation.compactActionVerticalPadding)
        #expect(action.minimumHeight == theme.layout.control.minimumTouchTarget)
        #expect(grouped.dividerLeadingInset == row.horizontalInset + theme.spacing.inline)
        #expect(grouped.spacerHeight == row.verticalPadding)
        #expect(section.contentSpacing == theme.presentation.compactKeyValueSpacing)
        #expect(actionGroup.spacing == theme.presentation.compactActionGroupSpacing)
        #expect(keyValue.minimumValueWidth == theme.presentation.compactKeyValueMinimumValueWidth)
    }

    @Test
    func compact_screen_chrome_uses_compact_metrics_without_a_narrow_fallback() {
        let theme = MHTheme.standard
        let compactContext = MHAdaptiveLayoutContext(
            availableWidth: 320,
            horizontalSizeClass: .compact
        )
        let screen = theme.resolvedScreenChromeStyle(for: compactContext)

        #expect(screen.readableContentWidth == nil)
        #expect(screen.horizontalMargin == theme.layout.screen.compactContentInsetHorizontal)
        #expect(screen.verticalPadding == theme.layout.screen.compactContentInsetVertical)
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
        let automaticSurface = theme.resolvedSurfaceStyle(
            for: .standard,
            glassPolicy: .automatic,
            reduceTransparency: false,
            supportsGlass: true
        )
        let enabledSurface = theme.resolvedSurfaceStyle(
            for: .standard,
            glassPolicy: .enabled,
            reduceTransparency: false,
            supportsGlass: true
        )
        let disabledSurface = theme.resolvedSurfaceStyle(
            for: .standard,
            glassPolicy: .disabled,
            reduceTransparency: false,
            supportsGlass: true
        )
        let unsupportedSurface = theme.resolvedSurfaceStyle(
            for: .standard,
            glassPolicy: .enabled,
            reduceTransparency: false,
            supportsGlass: false
        )
        let reducedTransparencySurface = theme.resolvedSurfaceStyle(
            for: .standard,
            glassPolicy: .enabled,
            reduceTransparency: true
        )
        let canvas = theme.resolvedCanvasSurfaceStyle(
            glassPolicy: .enabled,
            reduceTransparency: false,
            supportsGlass: true
        )

        #expect(theme.surfaceColorRole(for: .standard) == .surface)
        #expect(theme.surfaceColorRole(for: .muted) == .surfaceMuted)
        #expect(grouped.showsDividers)
        #expect(grouped.dividerLeadingInset == theme.layout.surface.insetHorizontal + theme.spacing.inline)
        #expect(grouped.dividerThickness == theme.divider.thickness)
        #expect(grouped.dividerOpacity == theme.divider.opacity)
        #expect(grouped.spacerHeight == theme.presentation.rowVerticalPadding)
        #expect(automaticSurface.usesGlass)
        #expect(enabledSurface.usesGlass)
        #expect(!disabledSurface.usesGlass)
        #expect(!unsupportedSurface.usesGlass)
        #expect(!reducedTransparencySurface.usesGlass)
        #expect(disabledSurface.fallbackFillRole == .surface)
        #expect(enabledSurface.glassTintRole == .surface)
        #expect(canvas.fallbackFillRole == .background)
        #expect(!canvas.usesGlass)
    }

    @Test
    func key_value_style_defaults_stay_primary_to_secondary() {
        let theme = MHTheme.standard
        let rowChrome = theme.resolvedRowChromeStyle()
        let style = theme.resolvedKeyValueStyle()

        #expect(style.labelColorRole == .primaryText)
        #expect(style.valueColorRole == .secondaryText)
        #expect(rowChrome.verticalPadding == theme.presentation.rowVerticalPadding)
        #expect(rowChrome.horizontalInset == theme.presentation.rowHorizontalInset)
        #expect(rowChrome.accessorySpacing == theme.presentation.rowAccessorySpacing)
        #expect(rowChrome.minimumHeight == theme.layout.control.minimumTouchTarget)
        #expect(style.rowChrome == rowChrome)
        #expect(style.minimumValueWidth == theme.presentation.regularKeyValueMinimumValueWidth)
        #expect(style.stackedSpacing == theme.presentation.compactKeyValueSpacing)
    }

    @Test
    func action_presentation_policies_resolve_expected_behaviors() {
        let theme = MHTheme.standard
        let compactContext = MHAdaptiveLayoutContext(
            availableWidth: 320,
            horizontalSizeClass: .compact
        )
        let regularContext = MHAdaptiveLayoutContext(
            availableWidth: 760,
            horizontalSizeClass: .regular
        )

        let automatic = theme.resolvedActionPresentation(
            .automatic,
            for: compactContext
        )
        let regularAutomatic = theme.resolvedActionPresentation(
            .automatic,
            for: regularContext
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

        #expect(automatic.lineLimit == nil)
        #expect(!automatic.usesFixedHorizontalSize)
        #expect(automatic.expandsHorizontally)
        #expect(automatic.alignment == .leading)
        #expect(automatic.allowsTightening)
        #expect(regularAutomatic.lineLimit == 1)
        #expect(regularAutomatic.usesFixedHorizontalSize)
        #expect(!regularAutomatic.expandsHorizontally)
        #expect(intrinsic.lineLimit == 1)
        #expect(intrinsic.usesFixedHorizontalSize)
        #expect(!intrinsic.expandsHorizontally)
        #expect(fullWidth.lineLimit == nil)
        #expect(fullWidth.expandsHorizontally)
        #expect(fullWidth.alignment == .center)
        #expect(fullWidthLeading.lineLimit == nil)
        #expect(fullWidthLeading.expandsHorizontally)
        #expect(fullWidthLeading.alignment == .leading)
    }

    @Test
    func action_group_horizontal_measurement_stays_explicit() {
        #expect(
            MHActionLayoutMetrics.requiredHorizontalWidth(
                itemWidths: [120, 140, 100],
                spacing: 8
            ) == 376
        )
    }

    @Test
    func key_value_horizontal_measurement_requires_a_real_value_column() {
        #expect(
            MHKeyValueLayoutMetrics.requiredHorizontalWidth(
                labelWidth: 110,
                valueWidth: 84,
                spacing: 12,
                minimumValueWidth: 160
            ) == 282
        )
    }

    @Test
    func input_and_badge_styles_resolve_from_theme_tokens() {
        let theme = MHTheme.standard
        let focusedInput = theme.resolvedInputChromeStyle(
            for: .focused,
            glassPolicy: .enabled,
            reduceTransparency: false,
            supportsGlass: true
        )
        let invalidInput = theme.resolvedInputChromeStyle(
            for: .invalid,
            glassPolicy: .enabled,
            reduceTransparency: true,
            supportsGlass: true
        )
        let neutralBadge = theme.resolvedBadgeChromeStyle(
            for: .neutral,
            glassPolicy: .enabled,
            reduceTransparency: false,
            supportsGlass: true
        )
        let accentBadge = theme.resolvedBadgeChromeStyle(
            for: .accent,
            glassPolicy: .disabled,
            reduceTransparency: false,
            supportsGlass: true
        )

        #expect(focusedInput.backgroundStyle.usesGlass)
        #expect(focusedInput.backgroundStyle.borderRole == .accent)
        #expect(focusedInput.backgroundStyle.borderOpacity == 0.24)
        #expect(focusedInput.horizontalPadding == theme.spacing.content)
        #expect(focusedInput.minimumHeight == theme.layout.control.minimumTouchTarget)
        #expect(invalidInput.backgroundStyle.fallbackFillRole == .destructive)
        #expect(!invalidInput.backgroundStyle.usesGlass)
        #expect(invalidInput.backgroundStyle.borderOpacity == 0.20)
        #expect(neutralBadge.textRole == .caption)
        #expect(neutralBadge.foregroundRole == .secondaryText)
        #expect(neutralBadge.backgroundStyle.usesGlass)
        #expect(neutralBadge.backgroundStyle.fallbackFillOpacity == 0.06)
        #expect(accentBadge.foregroundRole == .accent)
        #expect(accentBadge.backgroundStyle.borderOpacity == 0.14)
        #expect(!accentBadge.backgroundStyle.usesGlass)
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
        #expect(screen.horizontalMargin == theme.layout.screen.contentInsetHorizontal)
        #expect(screen.verticalPadding == theme.layout.screen.contentInsetVertical)
        #expect(screenCue.colorRole == .accent)
        #expect(screenCue.width == theme.presentation.screenCueWidth)
        #expect(screenCue.height == theme.presentation.screenCueHeight)
        #expect(sectionCue.colorRole == .accent)
        #expect(sectionCue.width == theme.presentation.sectionCueWidth)
        #expect(sectionCue.height == theme.presentation.sectionCueHeight)
        #expect(screen.cueStyle == screenCue)
        #expect(section.cueStyle == sectionCue)
        #expect(section.contentSpacing == theme.spacing.control)
        #expect(section.leadingInset == theme.spacing.inline)
    }
}
// swiftlint:enable function_body_length type_body_length
