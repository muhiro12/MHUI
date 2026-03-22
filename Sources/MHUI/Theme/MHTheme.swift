import SwiftUI

/// Shared visual rules for calm, tool-like sibling apps.
public struct MHTheme: Sendable, Equatable {
    /// Semantic color references used by MHUI components.
    struct Colors: Sendable, Equatable {
        var background: MHColorReference
        var surface: MHColorReference
        var surfaceMuted: MHColorReference
        var border: MHColorReference
        var primaryText: MHColorReference
        var secondaryText: MHColorReference
        var accent: MHColorReference
        var positive: MHColorReference
        var warning: MHColorReference
        var destructive: MHColorReference
    }

    /// Semantic typography tokens used by MHUI text roles.
    struct Typography: Sendable, Equatable {
        var screenTitle: MHTextMetrics
        var sectionTitle: MHTextMetrics
        var body: MHTextMetrics
        var bodyStrong: MHTextMetrics
        var supporting: MHTextMetrics
        var metadata: MHTextMetrics
        var caption: MHTextMetrics
    }

    /// Shared layout spacing for MHUI surfaces and stacks.
    struct Spacing: Sendable, Equatable {
        var inline: CGFloat
        var control: CGFloat
        var group: CGFloat
        var section: CGFloat
        var screen: CGFloat
    }

    /// Shared radii for controls and calm surfaces.
    struct Radius: Sendable, Equatable {
        var control: CGFloat
        var surface: CGFloat
        var pill: CGFloat
    }

    /// Divider treatment for grouped rows and sections.
    struct Divider: Sendable, Equatable {
        var thickness: CGFloat
        var opacity: Double
    }

    /// Small motion values for pressed and focused state changes.
    struct Motion: Sendable, Equatable {
        var quick: Double
        var regular: Double
    }

    /// Shared layout tokens for screen composition and row rhythm.
    struct Layout: Sendable, Equatable {
        var readableContentWidth: CGFloat
        var compactWidthThreshold: CGFloat
        var narrowWidthThreshold: CGFloat
        var screenHorizontalMargin: CGFloat
        var screenVerticalPadding: CGFloat
        var screenContentSpacing: CGFloat
        var compactScreenHorizontalMargin: CGFloat
        var compactScreenVerticalPadding: CGFloat
        var compactScreenContentSpacing: CGFloat
        var surfaceInsetHorizontal: CGFloat
        var surfaceInsetVertical: CGFloat
        var compactSurfaceInsetHorizontal: CGFloat
        var compactSurfaceInsetVertical: CGFloat
        var rowHorizontalInset: CGFloat
        var rowVerticalPadding: CGFloat
        var rowAccessorySpacing: CGFloat
        var compactRowHorizontalInset: CGFloat
        var compactRowVerticalPadding: CGFloat
        var compactRowAccessorySpacing: CGFloat
        var compactActionHorizontalPadding: CGFloat
        var compactActionVerticalPadding: CGFloat
        var regularKeyValueMinimumValueWidth: CGFloat
        var compactKeyValueMinimumValueWidth: CGFloat
        var compactKeyValueSpacing: CGFloat
        var compactActionGroupSpacing: CGFloat
        var screenCueWidth: CGFloat
        var screenCueHeight: CGFloat
        var sectionCueWidth: CGFloat
        var sectionCueHeight: CGFloat
    }

    /// Surface recipes used by calm containers and screen chrome.
    struct SurfaceTreatment: Sendable, Equatable {
        var prefersGlass: Bool
        var fallbackColorRole: MHColorRole
        var fallbackOpacity: Double
        var glassTintColorRole: MHColorRole?
        var glassTintOpacity: Double
        var borderColorRole: MHColorRole
        var borderOpacity: Double
    }

    /// Shared surface tokens for the screen canvas and grouped content.
    struct Surfaces: Sendable, Equatable {
        var canvas: SurfaceTreatment
        var standard: SurfaceTreatment
        var muted: SurfaceTreatment
    }

    var colors: Colors
    var typography: Typography
    var spacing: Spacing
    var radius: Radius
    var divider: Divider
    var motion: Motion
    var layout: Layout
    var surfaces: Surfaces

    internal func colorReference(for role: MHColorRole) -> MHColorReference {
        switch role {
        case .background:
            colors.background
        case .surface:
            colors.surface
        case .surfaceMuted:
            colors.surfaceMuted
        case .border:
            colors.border
        case .primaryText:
            colors.primaryText
        case .secondaryText:
            colors.secondaryText
        case .accent:
            colors.accent
        case .positive:
            colors.positive
        case .warning:
            colors.warning
        case .destructive:
            colors.destructive
        }
    }

    internal func resolvedColor(
        for role: MHColorRole,
        in colorScheme: ColorScheme
    ) -> Color {
        colorReference(for: role).resolve(for: colorScheme)
    }

    internal func textMetrics(for role: MHTextRole) -> MHTextMetrics {
        switch role {
        case .screenTitle:
            typography.screenTitle
        case .sectionTitle:
            typography.sectionTitle
        case .body:
            typography.body
        case .bodyStrong:
            typography.bodyStrong
        case .supporting:
            typography.supporting
        case .metadata:
            typography.metadata
        case .caption:
            typography.caption
        }
    }
}
