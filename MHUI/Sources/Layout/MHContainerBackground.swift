/// Chooses the background of a native list or form without selecting its style.
public enum MHContainerBackground: String, Sendable, CaseIterable {
    /// Preserves the platform's contextual scroll background, including sidebar treatment.
    case system

    /// Replaces the scroll background with the MHUI canvas, leaving native row surfaces intact.
    case theme
}
