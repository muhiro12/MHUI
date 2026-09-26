/// Chooses content presentation without replacing native container behavior.
public enum MHContainerStyle: Sendable, Equatable {
    /// Keeps platform grouping and row geometry with MHUI colors.
    case native

    /// Uses the MHUI canvas with automatic or explicit MHUI row presentation.
    case content
}
