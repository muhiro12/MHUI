import MHDesign
import SwiftUI

/// Shared visual rules for calm, tool-like sibling apps.
public struct MHTheme: Sendable, Equatable {
    /// Semantic color references used by MHUI components.
    struct Colors: Sendable, Equatable {
        var background: MHColorReference
        var surface: MHColorReference
        var surfaceElevated: MHColorReference
        var surfaceMuted: MHColorReference
        var border: MHColorReference
        var primaryText: MHColorReference
        var secondaryText: MHColorReference
        var tertiaryText: MHColorReference
        var accent: MHColorReference
        var onAccent: MHColorReference
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
    var metrics: MHDesignMetrics
    var presentation: MHPresentationMetrics
    var divider: Divider
    var motion: Motion
    var surfaces: Surfaces

    var spacing: MHSpacingMetrics {
        metrics.spacing
    }

    var cornerRadius: MHCornerRadiusMetrics {
        metrics.cornerRadius
    }

    var layout: MHLayoutMetrics {
        metrics.layout
    }

    // swiftlint:disable:next cyclomatic_complexity
    internal func colorReference(for role: MHColorRole) -> MHColorReference {
        switch role {
        case .background:
            colors.background
        case .surface:
            colors.surface
        case .surfaceElevated:
            colors.surfaceElevated
        case .surfaceMuted:
            colors.surfaceMuted
        case .border:
            colors.border
        case .primaryText:
            colors.primaryText
        case .secondaryText:
            colors.secondaryText
        case .tertiaryText:
            colors.tertiaryText
        case .accent:
            colors.accent
        case .onAccent:
            colors.onAccent
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
