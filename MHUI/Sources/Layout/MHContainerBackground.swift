/// Chooses who owns the background of one MHUI content container.
public enum MHContainerBackground: Sendable, Equatable {
    /// Paints the theme canvas, preserving the default MHUI presentation.
    case themed

    /// Keeps the platform container background and materials visible.
    /// Content layout and row presentation remain independently configurable.
    case native
}
