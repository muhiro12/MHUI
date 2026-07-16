/// Placement options for an MHUI editorial cue.
public enum MHCuePlacement: String, Sendable, Equatable, CaseIterable {
    /// Places a horizontal cue above its content.
    case top

    /// Places a vertical cue at the semantic leading edge, adapting to layout direction.
    case leading
}
