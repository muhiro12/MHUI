/// Chooses content presentation without replacing native container behavior.
public enum MHContainerStyle: Sendable, Equatable {
    /// Keeps the platform's backgrounds, grouping, and row presentation.
    case native

    /// Uses the MHUI canvas and allows explicit MHUI rows and section headers.
    case content
}
