struct MHResolvedSurfaceStyle: Sendable, Equatable {
    var fillRole: MHColorRole
    var fillOpacity: Double
    var borderRole: MHColorRole
    var borderOpacity: Double

    // Increase Contrast keeps a structural outline on otherwise borderless content.
    func outlined(
        minimumOpacity: Double,
        when increasedContrast: Bool
    ) -> Self {
        guard increasedContrast else {
            return self
        }

        var style = self
        style.borderOpacity = max(borderOpacity, minimumOpacity)
        return style
    }
}
