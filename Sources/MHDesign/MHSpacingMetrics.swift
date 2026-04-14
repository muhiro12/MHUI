import CoreGraphics

/// Shared spacing values for rhythm and separation.
public struct MHSpacingMetrics: Sendable, Equatable {
    /// Tight inline spacing used inside compact rows or label-value groupings.
    public let inline: CGFloat
    /// Default spacing between closely related controls.
    public let control: CGFloat
    /// Spacing between small groups of related elements.
    public let group: CGFloat
    /// Spacing between major sections within one screen.
    public let section: CGFloat
    /// Outer screen-level spacing that defines the overall page rhythm.
    public let screen: CGFloat

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
