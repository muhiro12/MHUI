import CoreGraphics

/// Shared layout thresholds and role-based metrics for screen composition.
public struct MHLayoutMetrics: Sendable, Equatable {
    /// Maximum readable content width before line lengths become too wide.
    public let readableContentWidth: CGFloat
    /// Width below which compact layout rules activate.
    public let compactWidthThreshold: CGFloat
    /// Shared screen layout metrics.
    public let screen: MHScreenLayoutMetrics
    /// Shared surface layout metrics.
    public let surface: MHSurfaceLayoutMetrics
    /// Shared control layout metrics.
    public let control: MHControlLayoutMetrics

    public init(
        readableContentWidth: CGFloat,
        compactWidthThreshold: CGFloat,
        screen: MHScreenLayoutMetrics,
        surface: MHSurfaceLayoutMetrics,
        control: MHControlLayoutMetrics
    ) {
        self.readableContentWidth = readableContentWidth
        self.compactWidthThreshold = compactWidthThreshold
        self.screen = screen
        self.surface = surface
        self.control = control
    }

    public func mode(
        for width: CGFloat
    ) -> MHLayoutMode {
        width < compactWidthThreshold ? .compact : .regular
    }
}
