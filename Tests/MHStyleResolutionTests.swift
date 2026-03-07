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
        #expect(destructive.foregroundRole == .destructive)
        #expect(destructive.accentRuleRole == nil)
        #expect(destructive.accentRuleOpacity == 0)
        #expect(primary.horizontalPadding == theme.spacing.group)
        #expect(quiet.verticalPadding < primary.verticalPadding)
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
        let materialSurface = theme.resolvedSurfaceStyle(
            for: .standard,
            reduceTransparency: false
        )
        let solidSurface = theme.resolvedSurfaceStyle(
            for: .standard,
            reduceTransparency: true
        )
        let canvas = theme.resolvedCanvasSurfaceStyle(
            reduceTransparency: false
        )

        #expect(theme.surfaceColorRole(for: .standard) == .surface)
        #expect(theme.surfaceColorRole(for: .muted) == .surfaceMuted)
        #expect(grouped.showsDividers)
        #expect(grouped.dividerLeadingInset == theme.layout.surfaceInsetHorizontal + theme.spacing.inline)
        #expect(grouped.dividerThickness == theme.divider.thickness)
        #expect(grouped.dividerOpacity == theme.divider.opacity)
        #expect(grouped.spacerHeight == theme.layout.rowVerticalPadding)
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
        let style = theme.resolvedKeyValueStyle()

        #expect(style.labelColorRole == .primaryText)
        #expect(style.valueColorRole == .secondaryText)
        #expect(style.verticalPadding == theme.layout.rowVerticalPadding)
        #expect(style.horizontalInset == theme.layout.rowHorizontalInset)
        #expect(style.accessorySpacing == theme.layout.rowAccessorySpacing)
    }

    @Test
    func screen_and_section_chrome_share_theme_tokens() {
        let theme = MHTheme.standard
        let screen = theme.resolvedScreenChromeStyle()
        let section = theme.resolvedSectionChromeStyle()

        #expect(screen.readableContentWidth == theme.layout.readableContentWidth)
        #expect(screen.horizontalMargin == theme.layout.screenHorizontalMargin)
        #expect(screen.verticalPadding == theme.layout.screenVerticalPadding)
        #expect(screen.cueWidth == theme.layout.screenCueWidth)
        #expect(screen.cueHeight == theme.layout.screenCueHeight)
        #expect(section.cueWidth == theme.layout.sectionCueWidth)
        #expect(section.cueHeight == theme.layout.sectionCueHeight)
        #expect(section.contentSpacing == theme.spacing.control)
        #expect(section.leadingInset == theme.spacing.inline)
    }
}
