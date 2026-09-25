/// Chooses content presentation without replacing native container behavior.
public enum MHContainerStyle: Sendable, Equatable {
    /// Keeps the platform's backgrounds, grouping, and row presentation.
    case native

    /// Uses the MHUI canvas with automatic or explicit MHUI row presentation.
    case content
}
