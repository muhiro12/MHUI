import SwiftUI

/// Shared visual rules for calm, tool-like sibling apps.
public struct MHTheme: Sendable, Equatable {
    /// Semantic color references used by MHUI components.
    public struct Colors: Sendable, Equatable {
        public var background: MHColorReference
        public var surface: MHColorReference
        public var surfaceMuted: MHColorReference
        public var border: MHColorReference
        public var primaryText: MHColorReference
        public var secondaryText: MHColorReference
        public var accent: MHColorReference
        public var positive: MHColorReference
        public var warning: MHColorReference
        public var destructive: MHColorReference

        public init(
            background: MHColorReference,
            surface: MHColorReference,
            surfaceMuted: MHColorReference,
            border: MHColorReference,
            primaryText: MHColorReference,
            secondaryText: MHColorReference,
            accent: MHColorReference,
            positive: MHColorReference,
            warning: MHColorReference,
            destructive: MHColorReference
        ) {
            self.background = background
            self.surface = surface
            self.surfaceMuted = surfaceMuted
            self.border = border
            self.primaryText = primaryText
            self.secondaryText = secondaryText
            self.accent = accent
            self.positive = positive
            self.warning = warning
            self.destructive = destructive
        }
    }

    /// Semantic typography tokens used by MHUI text roles.
    public struct Typography: Sendable, Equatable {
        public var screenTitle: MHTextMetrics
        public var sectionTitle: MHTextMetrics
        public var body: MHTextMetrics
        public var bodyStrong: MHTextMetrics
        public var supporting: MHTextMetrics
        public var caption: MHTextMetrics

        public init(
            screenTitle: MHTextMetrics,
            sectionTitle: MHTextMetrics,
            body: MHTextMetrics,
            bodyStrong: MHTextMetrics,
            supporting: MHTextMetrics,
            caption: MHTextMetrics
        ) {
            self.screenTitle = screenTitle
            self.sectionTitle = sectionTitle
            self.body = body
            self.bodyStrong = bodyStrong
            self.supporting = supporting
            self.caption = caption
        }
    }

    /// Shared layout spacing for MHUI surfaces and stacks.
    public struct Spacing: Sendable, Equatable {
        public var inline: CGFloat
        public var control: CGFloat
        public var group: CGFloat
        public var section: CGFloat
        public var screen: CGFloat

        public init(
            inline: CGFloat,
            control: CGFloat,
            group: CGFloat,
            section: CGFloat,
            screen: CGFloat
        ) {
            self.inline = inline
            self.control = control
            self.group = group
            self.section = section
            self.screen = screen
        }
    }

    /// Shared radii for controls and calm surfaces.
    public struct Radius: Sendable, Equatable {
        public var control: CGFloat
        public var surface: CGFloat
        public var pill: CGFloat

        public init(
            control: CGFloat,
            surface: CGFloat,
            pill: CGFloat
        ) {
            self.control = control
            self.surface = surface
            self.pill = pill
        }
    }

    /// Divider treatment for grouped rows and sections.
    public struct Divider: Sendable, Equatable {
        public var thickness: CGFloat
        public var opacity: Double

        public init(
            thickness: CGFloat,
            opacity: Double
        ) {
            self.thickness = thickness
            self.opacity = opacity
        }
    }

    /// Small motion values for pressed and focused state changes.
    public struct Motion: Sendable, Equatable {
        public var quick: Double
        public var regular: Double

        public init(
            quick: Double,
            regular: Double
        ) {
            self.quick = quick
            self.regular = regular
        }
    }

    public var colors: Colors
    public var typography: Typography
    public var spacing: Spacing
    public var radius: Radius
    public var divider: Divider
    public var motion: Motion

    public init(
        colors: Colors,
        typography: Typography,
        spacing: Spacing,
        radius: Radius,
        divider: Divider,
        motion: Motion
    ) {
        self.colors = colors
        self.typography = typography
        self.spacing = spacing
        self.radius = radius
        self.divider = divider
        self.motion = motion
    }

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
        case .caption:
            typography.caption
        }
    }
}
