/// Chooses content presentation without replacing native container behavior.
public enum MHContainerStyle: Sendable, Equatable {
    /// Keeps platform grouping and row geometry with MHUI colors.
    case native

    /// Uses content rhythm with automatic or explicit MHUI row presentation.
    case content
}
