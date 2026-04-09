import CoreGraphics

/// Shared spacing values for rhythm and separation.
public struct MHSpacingMetrics: Sendable, Equatable {
    public let inline: CGFloat
    public let control: CGFloat
    public let group: CGFloat
    public let section: CGFloat
    public let screen: CGFloat

    package init(
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
