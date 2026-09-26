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

    /// Shared adaptive value-column metrics.
    public let column: MHColumnLayoutMetrics

    public init(
        readableContentWidth: CGFloat,
        compactWidthThreshold: CGFloat,
        screen: MHScreenLayoutMetrics,
        surface: MHSurfaceLayoutMetrics,
        control: MHControlLayoutMetrics
    ) {
        self.init(
            readableContentWidth: readableContentWidth,
            compactWidthThreshold: compactWidthThreshold,
            screen: screen,
            surface: surface,
            control: control,
            column: .standard
        )
    }

    public init(
        readableContentWidth: CGFloat,
        compactWidthThreshold: CGFloat,
        screen: MHScreenLayoutMetrics,
        surface: MHSurfaceLayoutMetrics,
        control: MHControlLayoutMetrics,
        column: MHColumnLayoutMetrics
    ) {
        self.readableContentWidth = readableContentWidth
        self.compactWidthThreshold = compactWidthThreshold
        self.screen = screen
        self.surface = surface
        self.control = control
        self.column = column
    }

    public func mode(
        for width: CGFloat
    ) -> MHLayoutMode {
        width < compactWidthThreshold ? .compact : .regular
    }
}
