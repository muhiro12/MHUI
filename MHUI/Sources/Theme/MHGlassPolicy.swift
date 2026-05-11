/// Controls whether MHUI chrome may render using Liquid Glass when it is available.
public enum MHGlassPolicy: String, Sendable, CaseIterable {
    case automatic
    case enabled
    case disabled
}
