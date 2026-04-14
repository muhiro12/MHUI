import CoreGraphics

/// Shared screen layout metrics for role-based screen composition.
public struct MHScreenLayoutMetrics: Sendable, Equatable {
    /// Horizontal inset applied to screen content at regular widths.
    public let contentInsetHorizontal: CGFloat
    /// Vertical inset applied to screen content at regular widths.
    public let contentInsetVertical: CGFloat
    /// Vertical spacing between major screen content blocks at regular widths.
    public let contentSpacing: CGFloat
    /// Horizontal inset applied to screen content at compact widths.
    public let compactContentInsetHorizontal: CGFloat
    /// Vertical inset applied to screen content at compact widths.
    public let compactContentInsetVertical: CGFloat
    /// Vertical spacing between major screen content blocks at compact widths.
    public let compactContentSpacing: CGFloat

    public init(
        contentInsetHorizontal: CGFloat,
        contentInsetVertical: CGFloat,
        contentSpacing: CGFloat,
        compactContentInsetHorizontal: CGFloat,
        compactContentInsetVertical: CGFloat,
        compactContentSpacing: CGFloat
    ) {
        self.contentInsetHorizontal = contentInsetHorizontal
        self.contentInsetVertical = contentInsetVertical
        self.contentSpacing = contentSpacing
        self.compactContentInsetHorizontal = compactContentInsetHorizontal
        self.compactContentInsetVertical = compactContentInsetVertical
        self.compactContentSpacing = compactContentSpacing
    }
}
