import MHDesign
import SwiftUI

/// Shared visual rules for calm, tool-like sibling apps.
public struct MHTheme: Sendable, Equatable {
    /// Semantic colors resolved by MHUI presentation primitives.
    public var colors: Colors

    /// Semantic text styles resolved by MHUI typography modifiers.
    public var typography: Typography

    /// Shared spacing, corner-radius, and layout metrics.
    public var metrics: MHDesignMetrics

    /// Component layout values that only have meaning with MHUI chrome.
    public var presentation: Presentation

    /// Divider treatment used by grouped rows and surfaces.
    public var divider: Divider

    /// Motion durations used by package-owned state transitions.
    public var motion: Motion

    /// Surface treatments used by screens and content containers.
    public var surfaces: Surfaces

    /// The spacing scale carried by this theme.
    public var spacing: MHSpacingMetrics {
        metrics.spacing
    }

    /// The corner-radius scale carried by this theme.
    public var cornerRadius: MHCornerRadiusMetrics {
        metrics.cornerRadius
    }

    /// The generic layout metrics carried by this theme.
    public var layout: MHLayoutMetrics {
        metrics.layout
    }

    /// Creates a complete theme that can be applied at an app or subtree root.
    public init(
        colors: Colors,
        typography: Typography,
        metrics: MHDesignMetrics,
        presentation: Presentation,
        divider: Divider,
        motion: Motion,
        surfaces: Surfaces
    ) {
        self.colors = colors
        self.typography = typography
        self.metrics = metrics
        self.presentation = presentation
        self.divider = divider
        self.motion = motion
        self.surfaces = surfaces
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

    internal func nativeTintOverride(
        in colorScheme: ColorScheme
    ) -> Color? {
        colors.accent.nativeTintOverride(for: colorScheme)
    }

    internal func textStyle(for role: MHTextRole) -> TextStyle {
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
