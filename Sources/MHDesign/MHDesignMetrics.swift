import CoreGraphics

/// Shared design parameters that sibling apps can adopt without taking MHUI chrome.
public struct MHDesignMetrics: Sendable, Equatable {
    /// Shared spacing values for rhythm and separation.
    public let spacing: MHSpacingMetrics

    /// Shared radii for controls and calm surfaces.
    public let radius: MHRadiusMetrics

    /// Shared layout thresholds and insets for screen composition.
    public let layout: MHLayoutMetrics

    package init(
        spacing: MHSpacingMetrics,
        radius: MHRadiusMetrics,
        layout: MHLayoutMetrics
    ) {
        self.spacing = spacing
        self.radius = radius
        self.layout = layout
    }
}
