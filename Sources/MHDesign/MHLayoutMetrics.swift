import CoreGraphics

/// Shared layout thresholds and insets for generic screen and surface composition.
public struct MHLayoutMetrics: Sendable, Equatable {
    public let readableContentWidth: CGFloat
    public let compactWidthThreshold: CGFloat
    public let narrowWidthThreshold: CGFloat
    public let screenHorizontalMargin: CGFloat
    public let screenVerticalPadding: CGFloat
    public let screenContentSpacing: CGFloat
    public let compactScreenHorizontalMargin: CGFloat
    public let compactScreenVerticalPadding: CGFloat
    public let compactScreenContentSpacing: CGFloat
    public let surfaceInsetHorizontal: CGFloat
    public let surfaceInsetVertical: CGFloat
    public let compactSurfaceInsetHorizontal: CGFloat
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
