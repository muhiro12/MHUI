/// Controls whether MHUI chrome may render using Liquid Glass when it is available.
public enum MHGlassPolicy: String, Sendable, CaseIterable {
    /// Lets eligible MHUI chrome use Liquid Glass when runtime and accessibility
    /// support allow it. Content surfaces remain non-glass by default.
    case automatic

    /// Requests Liquid Glass for eligible MHUI chrome while still respecting
    /// accessibility and fallback paths. This does not make content surfaces
    /// glass-eligible.
    case enabled

    /// Uses non-glass fallback fills for MHUI chrome.
    case disabled
}
