internal extension MHGlassPolicy {
    func resolvesUsesGlass(
        prefersGlass: Bool,
        supportsGlass: Bool,
        reduceTransparency: Bool
    ) -> Bool {
        guard prefersGlass else {
            return false
        }

        guard supportsGlass, !reduceTransparency else {
            return false
        }

        return switch self {
        case .automatic, .enabled:
            true
        case .disabled:
            false
        }
    }
}
