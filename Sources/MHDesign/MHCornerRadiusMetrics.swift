import CoreGraphics

/// Shared corner radii for controls and calm surfaces.
public struct MHCornerRadiusMetrics: Sendable, Equatable {
    /// Corner radius for standard controls such as buttons and inputs.
    public let control: CGFloat
    /// Corner radius for larger detached surfaces such as cards or panels.
    public let surface: CGFloat

    public init(
        control: CGFloat,
        surface: CGFloat
    ) {
        self.control = control
        self.surface = surface
    }

    public subscript(
        _ role: MHCornerRadiusRole
    ) -> CGFloat {
        switch role {
        case .control:
            control
        case .surface:
            surface
        }
    }
}
