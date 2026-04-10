import CoreGraphics

/// Shared radii for controls and calm surfaces.
public struct MHRadiusMetrics: Sendable, Equatable {
    public let control: CGFloat
    public let surface: CGFloat
    public let pill: CGFloat

    public init(
        control: CGFloat,
        surface: CGFloat,
        pill: CGFloat
    ) {
        self.control = control
        self.surface = surface
        self.pill = pill
    }
}
