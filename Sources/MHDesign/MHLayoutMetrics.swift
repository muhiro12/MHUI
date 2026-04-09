import CoreGraphics

/// Shared layout thresholds and insets for screen composition.
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
    public let rowHorizontalInset: CGFloat
    public let rowVerticalPadding: CGFloat
    public let rowAccessorySpacing: CGFloat
    public let compactRowHorizontalInset: CGFloat
    public let compactRowVerticalPadding: CGFloat
    public let compactRowAccessorySpacing: CGFloat
    public let compactActionHorizontalPadding: CGFloat
    public let compactActionVerticalPadding: CGFloat
    public let regularKeyValueMinimumValueWidth: CGFloat
    public let compactKeyValueMinimumValueWidth: CGFloat
    public let compactKeyValueSpacing: CGFloat
    public let compactActionGroupSpacing: CGFloat
    public let screenCueWidth: CGFloat
    public let screenCueHeight: CGFloat
    public let sectionCueWidth: CGFloat
    public let sectionCueHeight: CGFloat

    package init(
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
        compactSurfaceInsetVertical: CGFloat,
        rowHorizontalInset: CGFloat,
        rowVerticalPadding: CGFloat,
        rowAccessorySpacing: CGFloat,
        compactRowHorizontalInset: CGFloat,
        compactRowVerticalPadding: CGFloat,
        compactRowAccessorySpacing: CGFloat,
        compactActionHorizontalPadding: CGFloat,
        compactActionVerticalPadding: CGFloat,
        regularKeyValueMinimumValueWidth: CGFloat,
        compactKeyValueMinimumValueWidth: CGFloat,
        compactKeyValueSpacing: CGFloat,
        compactActionGroupSpacing: CGFloat,
        screenCueWidth: CGFloat,
        screenCueHeight: CGFloat,
        sectionCueWidth: CGFloat,
        sectionCueHeight: CGFloat
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
        self.rowHorizontalInset = rowHorizontalInset
        self.rowVerticalPadding = rowVerticalPadding
        self.rowAccessorySpacing = rowAccessorySpacing
        self.compactRowHorizontalInset = compactRowHorizontalInset
        self.compactRowVerticalPadding = compactRowVerticalPadding
        self.compactRowAccessorySpacing = compactRowAccessorySpacing
        self.compactActionHorizontalPadding = compactActionHorizontalPadding
        self.compactActionVerticalPadding = compactActionVerticalPadding
        self.regularKeyValueMinimumValueWidth = regularKeyValueMinimumValueWidth
        self.compactKeyValueMinimumValueWidth = compactKeyValueMinimumValueWidth
        self.compactKeyValueSpacing = compactKeyValueSpacing
        self.compactActionGroupSpacing = compactActionGroupSpacing
        self.screenCueWidth = screenCueWidth
        self.screenCueHeight = screenCueHeight
        self.sectionCueWidth = sectionCueWidth
        self.sectionCueHeight = sectionCueHeight
    }
}
