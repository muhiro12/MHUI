import CoreGraphics

/// Shared layout thresholds and insets for generic screen and surface composition.
public struct MHLayoutMetrics: Sendable, Equatable {
    /// Maximum readable content width before line lengths become too wide.
    public let readableContentWidth: CGFloat
    /// Width below which screen-level compact layout rules activate.
    public let compactWidthThreshold: CGFloat
    /// Width below which extra narrow fallback behavior may activate.
    public let narrowWidthThreshold: CGFloat
    /// Horizontal outer margin for screen content at regular widths.
    public let screenHorizontalMargin: CGFloat
    /// Vertical outer padding for screen content at regular widths.
    public let screenVerticalPadding: CGFloat
    /// Vertical spacing between major screen sections at regular widths.
    public let screenContentSpacing: CGFloat
    /// Horizontal outer margin for screen content at compact widths.
    public let compactScreenHorizontalMargin: CGFloat
    /// Vertical outer padding for screen content at compact widths.
    public let compactScreenVerticalPadding: CGFloat
    /// Vertical spacing between major screen sections at compact widths.
    public let compactScreenContentSpacing: CGFloat
    /// Horizontal content inset inside standard surfaces at regular widths.
    public let surfaceInsetHorizontal: CGFloat
    /// Vertical content inset inside standard surfaces at regular widths.
    public let surfaceInsetVertical: CGFloat
    /// Horizontal content inset inside standard surfaces at compact widths.
    public let compactSurfaceInsetHorizontal: CGFloat
    /// Vertical content inset inside standard surfaces at compact widths.
    public let compactSurfaceInsetVertical: CGFloat

    public init(
        readableContentWidth: CGFloat,
        compactWidthThreshold: CGFloat,
        narrowWidthThreshold: CGFloat,
        screenHorizontalMargin: CGFloat,
        screenVerticalPadding: CGFloat,
        screenContentSpacing: CGFloat,
        compactScreenHorizontalMargin: CGFloat,
        compactScreenVerticalPadding: CGFloat,
        compactScreenContentSpacing: CGFloat,
        surfaceInsetHorizontal: CGFloat,
        surfaceInsetVertical: CGFloat,
        compactSurfaceInsetHorizontal: CGFloat,
        compactSurfaceInsetVertical: CGFloat
    ) {
        self.readableContentWidth = readableContentWidth
        self.compactWidthThreshold = compactWidthThreshold
        self.narrowWidthThreshold = narrowWidthThreshold
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
    }
}
