internal extension MHGlassPolicy {
    func resolvesUsesGlass(
        supportsGlass: Bool,
        reduceTransparency: Bool
    ) -> Bool {
        guard supportsGlass, !reduceTransparency else {
            return false
        }

        return switch self {
        case .enabled:
            true
        case .automatic, .disabled:
            false
        }
    }
}
