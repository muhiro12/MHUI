import MHDesign
import SwiftUI

/// Shared visual rules for calm, tool-like sibling apps.
public struct MHTheme: Sendable, Equatable {
    /// Semantic color references used by MHUI components.
    struct Colors: Sendable, Equatable {
        var background: MHColorReference
        var surface: MHColorReference
        var surfaceTint: MHColorReference
        var surfaceMuted: MHColorReference
        var surfaceMutedTint: MHColorReference
        var surfaceBorder: MHColorReference
        var surfaceMutedBorder: MHColorReference
        var controlBorder: MHColorReference
        var border: MHColorReference
        var divider: MHColorReference
        var primaryText: MHColorReference
        var secondaryText: MHColorReference
        var accent: MHColorReference
        var positive: MHColorReference
        var warning: MHColorReference
        var destructive: MHColorReference
        var destructiveTint: MHColorReference
        var destructiveBorder: MHColorReference
        var inputBorder: MHColorReference
        var inputTint: MHColorReference
        var inputInvalidFill: MHColorReference
        var inputInvalidTint: MHColorReference
        var badgeNeutralFill: MHColorReference
        var badgeNeutralBorder: MHColorReference
        var badgePositiveFill: MHColorReference
        var badgePositiveBorder: MHColorReference
        var badgeWarningFill: MHColorReference
        var badgeWarningBorder: MHColorReference
        var badgeDestructiveFill: MHColorReference
        var badgeDestructiveBorder: MHColorReference
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
        var colorRole: MHColorRole
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
        var glassTintColorRole: MHColorRole?
        var borderColorRole: MHColorRole?
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

    internal func colorReference(for role: MHColorRole) -> MHColorReference {
        switch role {
        case .background,
             .surface,
             .surfaceTint,
             .surfaceMuted,
             .surfaceMutedTint:
            surfaceFillColorReference(for: role)
        case .surfaceBorder,
             .surfaceMutedBorder,
             .controlBorder,
             .border,
             .divider:
            surfaceLineColorReference(for: role)
        case .primaryText,
             .secondaryText:
            textColorReference(for: role)
        case .accent:
            colors.accent
        case .positive,
             .warning,
             .destructive,
             .destructiveTint,
             .destructiveBorder,
             .inputBorder,
             .inputTint,
             .inputInvalidFill,
             .inputInvalidTint:
            semanticStateColorReference(for: role)
        case .badgeNeutralFill,
             .badgeNeutralBorder,
             .badgePositiveFill,
             .badgePositiveBorder,
             .badgeWarningFill,
             .badgeWarningBorder,
             .badgeDestructiveFill,
             .badgeDestructiveBorder:
            badgeColorReference(for: role)
        }
    }

    private func surfaceFillColorReference(for role: MHColorRole) -> MHColorReference {
        switch role {
        case .background:
            colors.background
        case .surface:
            colors.surface
        case .surfaceTint:
            colors.surfaceTint
        case .surfaceMuted:
            colors.surfaceMuted
        case .surfaceMutedTint:
            colors.surfaceMutedTint
        default:
            colors.background
        }
    }

    private func surfaceLineColorReference(for role: MHColorRole) -> MHColorReference {
        switch role {
        case .surfaceBorder:
            colors.surfaceBorder
        case .surfaceMutedBorder:
            colors.surfaceMutedBorder
        case .controlBorder:
            colors.controlBorder
        case .border:
            colors.border
        case .divider:
            colors.divider
        default:
            colors.background
        }
    }

    private func textColorReference(for role: MHColorRole) -> MHColorReference {
        switch role {
        case .primaryText:
            colors.primaryText
        case .secondaryText:
            colors.secondaryText
        default:
            colors.primaryText
        }
    }

    private func semanticStateColorReference(for role: MHColorRole) -> MHColorReference {
        switch role {
        case .positive:
            colors.positive
        case .warning:
            colors.warning
        case .destructive:
            colors.destructive
        case .destructiveTint:
            colors.destructiveTint
        case .destructiveBorder:
            colors.destructiveBorder
        case .inputBorder:
            colors.inputBorder
        case .inputTint:
            colors.inputTint
        case .inputInvalidFill:
            colors.inputInvalidFill
        case .inputInvalidTint:
            colors.inputInvalidTint
        default:
            colors.destructive
        }
    }

    private func badgeColorReference(for role: MHColorRole) -> MHColorReference {
        switch role {
        case .badgeNeutralFill:
            colors.badgeNeutralFill
        case .badgeNeutralBorder:
            colors.badgeNeutralBorder
        case .badgePositiveFill:
            colors.badgePositiveFill
        case .badgePositiveBorder:
            colors.badgePositiveBorder
        case .badgeWarningFill:
            colors.badgeWarningFill
        case .badgeWarningBorder:
            colors.badgeWarningBorder
        case .badgeDestructiveFill:
            colors.badgeDestructiveFill
        case .badgeDestructiveBorder:
            colors.badgeDestructiveBorder
        default:
            colors.badgeNeutralFill
        }
    }

    internal func resolvedColor(
        for role: MHColorRole,
        in colorScheme: ColorScheme
    ) -> Color {
        colorReference(for: role).resolve(for: colorScheme)
    }

    internal func resolvedColor(
        for role: MHColorRole,
        in colorScheme: ColorScheme,
        accentOpacity: Double?
    ) -> Color {
        let color = resolvedColor(for: role, in: colorScheme)

        guard role == .accent,
              let accentOpacity else {
            return color
        }

        return color.opacity(accentOpacity)
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
