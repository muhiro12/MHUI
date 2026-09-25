/// Controls whether MHUI action buttons may render using Liquid Glass.
///
/// Content surfaces, the screen canvas, badges, and input chrome never use
/// Liquid Glass under any policy.
public enum MHGlassPolicy: String, Sendable, CaseIterable {
    /// Lets MHUI choose the treatment. Action buttons keep non-glass fills.
    case automatic

    /// Requests Liquid Glass for action buttons while still respecting
    /// accessibility and fallback paths. Scope this to floating action controls.
    case enabled

    /// Uses non-glass fills for action buttons.
    case disabled
}
