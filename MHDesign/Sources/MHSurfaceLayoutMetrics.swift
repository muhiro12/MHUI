import CoreGraphics

/// Shared surface layout metrics for detached content containers.
public struct MHSurfaceLayoutMetrics: Sendable, Equatable {
    /// Horizontal inset applied inside standard surfaces at regular widths.
    public let insetHorizontal: CGFloat
    /// Vertical inset applied inside standard surfaces at regular widths.
    public let insetVertical: CGFloat
    /// Horizontal inset applied inside standard surfaces at compact widths.
    public let compactInsetHorizontal: CGFloat
    /// Vertical inset applied inside standard surfaces at compact widths.
    public let compactInsetVertical: CGFloat

    public init(
        insetHorizontal: CGFloat,
        insetVertical: CGFloat,
        compactInsetHorizontal: CGFloat,
        compactInsetVertical: CGFloat
    ) {
        self.insetHorizontal = insetHorizontal
        self.insetVertical = insetVertical
        self.compactInsetHorizontal = compactInsetHorizontal
        self.compactInsetVertical = compactInsetVertical
    }
}
