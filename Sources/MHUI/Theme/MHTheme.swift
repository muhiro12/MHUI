// swiftlint:disable type_body_length
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
        public var metadata: MHTextMetrics
        public var caption: MHTextMetrics

        public init(
            screenTitle: MHTextMetrics,
            sectionTitle: MHTextMetrics,
            body: MHTextMetrics,
            bodyStrong: MHTextMetrics,
            supporting: MHTextMetrics,
            metadata: MHTextMetrics,
            caption: MHTextMetrics
        ) {
            self.screenTitle = screenTitle
            self.sectionTitle = sectionTitle
            self.body = body
            self.bodyStrong = bodyStrong
            self.supporting = supporting
            self.metadata = metadata
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

    /// Shared layout tokens for screen composition and row rhythm.
    public struct Layout: Sendable, Equatable {
        public var readableContentWidth: CGFloat
        public var compactWidthThreshold: CGFloat
        public var screenHorizontalMargin: CGFloat
        public var screenVerticalPadding: CGFloat
        public var screenContentSpacing: CGFloat
        public var compactScreenHorizontalMargin: CGFloat
        public var compactScreenVerticalPadding: CGFloat
        public var compactScreenContentSpacing: CGFloat
        public var surfaceInsetHorizontal: CGFloat
        public var surfaceInsetVertical: CGFloat
        public var compactSurfaceInsetHorizontal: CGFloat
        public var compactSurfaceInsetVertical: CGFloat
        public var rowHorizontalInset: CGFloat
        public var rowVerticalPadding: CGFloat
        public var rowAccessorySpacing: CGFloat
        public var compactRowHorizontalInset: CGFloat
        public var compactRowVerticalPadding: CGFloat
        public var compactRowAccessorySpacing: CGFloat
        public var compactActionHorizontalPadding: CGFloat
        public var compactActionVerticalPadding: CGFloat
        public var compactKeyValueSpacing: CGFloat
        public var compactActionGroupSpacing: CGFloat
        public var screenCueWidth: CGFloat
        public var screenCueHeight: CGFloat
        public var sectionCueWidth: CGFloat
        public var sectionCueHeight: CGFloat

        public init(
            readableContentWidth: CGFloat,
            compactWidthThreshold: CGFloat,
            screenHorizontalMargin: CGFloat,
            screenVerticalPadding: CGFloat,
            screenContentSpacing: CGFloat,
            compactScreenHorizontalMargin: CGFloat,
            compactScreenVerticalPadding: CGFloat,
            compactScreenContentSpacing: CGFloat,
            surfaceInsetHorizontal: CGFloat,
            surfaceInsetVertical: CGFloat,
            compactSurfaceInsetHorizontal: CGFloat,
            compactSurfaceInsetVertical: CGFloat,
            rowHorizontalInset: CGFloat,
            rowVerticalPadding: CGFloat,
            rowAccessorySpacing: CGFloat,
            compactRowHorizontalInset: CGFloat,
            compactRowVerticalPadding: CGFloat,
            compactRowAccessorySpacing: CGFloat,
            compactActionHorizontalPadding: CGFloat,
            compactActionVerticalPadding: CGFloat,
            compactKeyValueSpacing: CGFloat,
            compactActionGroupSpacing: CGFloat,
            screenCueWidth: CGFloat,
            screenCueHeight: CGFloat,
            sectionCueWidth: CGFloat,
            sectionCueHeight: CGFloat
        ) {
            self.readableContentWidth = readableContentWidth
            self.compactWidthThreshold = compactWidthThreshold
            self.screenHorizontalMargin = screenHorizontalMargin
            self.screenVerticalPadding = screenVerticalPadding
            self.screenContentSpacing = screenContentSpacing
            self.compactScreenHorizontalMargin = compactScreenHorizontalMargin
            self.compactScreenVerticalPadding = compactScreenVerticalPadding
            self.compactScreenContentSpacing = compactScreenContentSpacing
            self.surfaceInsetHorizontal = surfaceInsetHorizontal
            self.surfaceInsetVertical = surfaceInsetVertical
            self.compactSurfaceInsetHorizontal = compactSurfaceInsetHorizontal
            self.compactSurfaceInsetVertical = compactSurfaceInsetVertical
            self.rowHorizontalInset = rowHorizontalInset
            self.rowVerticalPadding = rowVerticalPadding
            self.rowAccessorySpacing = rowAccessorySpacing
            self.compactRowHorizontalInset = compactRowHorizontalInset
            self.compactRowVerticalPadding = compactRowVerticalPadding
            self.compactRowAccessorySpacing = compactRowAccessorySpacing
            self.compactActionHorizontalPadding = compactActionHorizontalPadding
            self.compactActionVerticalPadding = compactActionVerticalPadding
            self.compactKeyValueSpacing = compactKeyValueSpacing
            self.compactActionGroupSpacing = compactActionGroupSpacing
            self.screenCueWidth = screenCueWidth
            self.screenCueHeight = screenCueHeight
            self.sectionCueWidth = sectionCueWidth
            self.sectionCueHeight = sectionCueHeight
        }
    }

    /// Surface recipes used by calm containers and screen chrome.
    public struct SurfaceTreatment: Sendable, Equatable {
        public var material: MHMaterialStyle
        public var fallbackColorRole: MHColorRole
        public var overlayColorRole: MHColorRole
        public var overlayOpacity: Double
        public var borderColorRole: MHColorRole
        public var borderOpacity: Double

        public init(
            material: MHMaterialStyle,
            fallbackColorRole: MHColorRole,
            overlayColorRole: MHColorRole,
            overlayOpacity: Double,
            borderColorRole: MHColorRole,
            borderOpacity: Double
        ) {
            self.material = material
            self.fallbackColorRole = fallbackColorRole
            self.overlayColorRole = overlayColorRole
            self.overlayOpacity = overlayOpacity
            self.borderColorRole = borderColorRole
            self.borderOpacity = borderOpacity
        }
    }

    /// Shared surface tokens for the screen canvas and grouped content.
    public struct Surfaces: Sendable, Equatable {
        public var canvas: SurfaceTreatment
        public var standard: SurfaceTreatment
        public var muted: SurfaceTreatment

        public init(
            canvas: SurfaceTreatment,
            standard: SurfaceTreatment,
            muted: SurfaceTreatment
        ) {
            self.canvas = canvas
            self.standard = standard
            self.muted = muted
        }
    }

    public var colors: Colors
    public var typography: Typography
    public var spacing: Spacing
    public var radius: Radius
    public var divider: Divider
    public var motion: Motion
    public var layout: Layout
    public var surfaces: Surfaces

    public init(
        colors: Colors,
        typography: Typography,
        spacing: Spacing,
        radius: Radius,
        divider: Divider,
        motion: Motion,
        layout: Layout,
        surfaces: Surfaces
    ) {
        self.colors = colors
        self.typography = typography
        self.spacing = spacing
        self.radius = radius
        self.divider = divider
        self.motion = motion
        self.layout = layout
        self.surfaces = surfaces
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
        case .metadata:
            typography.metadata
        case .caption:
            typography.caption
        }
    }
}
// swiftlint:enable type_body_length
