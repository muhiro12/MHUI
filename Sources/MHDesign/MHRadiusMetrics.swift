import CoreGraphics

/// Shared radii for controls and calm surfaces.
public struct MHRadiusMetrics: Sendable, Equatable {
    /// Corner radius for standard controls such as buttons and inputs.
    public let control: CGFloat
    /// Corner radius for larger detached surfaces such as cards or panels.
    public let surface: CGFloat
    /// Extra-large radius used to create pill-shaped treatments.
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
