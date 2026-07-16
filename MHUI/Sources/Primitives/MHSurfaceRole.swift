/// Surface prominence used by `mhSurface(role:)`.
public enum MHSurfaceRole: String, Sendable, CaseIterable {
    /// The default content surface.
    case standard

    /// A surface raised above standard content.
    case elevated

    /// A subdued surface for supporting content.
    case muted
}
