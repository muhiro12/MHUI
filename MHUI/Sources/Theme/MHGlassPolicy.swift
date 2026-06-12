/// Controls whether MHUI chrome may render using Liquid Glass when it is available.
public enum MHGlassPolicy: String, Sendable, CaseIterable {
    /// Lets eligible MHUI chrome use Liquid Glass when runtime and accessibility
    /// support allow it.
    case automatic

    /// Requests Liquid Glass for eligible MHUI chrome while still respecting
    /// accessibility and fallback paths.
    case enabled

    /// Uses non-glass fallback fills for MHUI chrome.
    case disabled
}
