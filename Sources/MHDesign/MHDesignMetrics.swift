import CoreGraphics

/// Shared design parameters that sibling apps can adopt without taking MHUI chrome.
public struct MHDesignMetrics: Sendable, Equatable {
    /// Shared spacing values for rhythm and separation.
    public let spacing: MHSpacingMetrics

    /// Shared corner radii for controls and calm surfaces.
    public let cornerRadius: MHCornerRadiusMetrics

    /// Shared layout thresholds and role-based layout metrics.
    public let layout: MHLayoutMetrics

    public init(
        spacing: MHSpacingMetrics,
        cornerRadius: MHCornerRadiusMetrics,
        layout: MHLayoutMetrics
    ) {
        self.spacing = spacing
        self.cornerRadius = cornerRadius
        self.layout = layout
    }
}
