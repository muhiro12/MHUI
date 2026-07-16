@testable import MHUI
import Testing

struct MHSurfaceStyleResolutionTests {
    @Test
    func elevated_surface_role_resolves_its_dedicated_treatment() {
        var theme = MHTheme.standard
        let elevatedTreatment: MHTheme.SurfaceTreatment = .init(
            prefersGlass: false,
            fallbackColorRole: .surfaceElevated,
            fallbackOpacity: 0.84,
            glassTintColorRole: .accent,
            glassTintOpacity: 0.12,
            borderColorRole: .accent,
            borderOpacity: 0.32
        )
        theme.surfaces = .init(
            canvas: theme.surfaces.canvas,
            standard: theme.surfaces.standard,
            elevated: elevatedTreatment,
            muted: theme.surfaces.muted
        )

        let surface = theme.resolvedSurfaceStyle(
            for: .elevated,
            glassPolicy: .disabled,
            reduceTransparency: false,
            supportsGlass: false
        )

        #expect(theme.surfaceColorRole(for: .elevated) == .surfaceElevated)
        #expect(surface.fallbackFillRole == .surfaceElevated)
        #expect(surface.fallbackFillOpacity == 0.84)
        #expect(surface.borderRole == .accent)
        #expect(surface.borderOpacity == 0.32)
    }
}
