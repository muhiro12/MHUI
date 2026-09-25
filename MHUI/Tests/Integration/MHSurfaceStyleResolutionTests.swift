@testable import MHUI
import Testing

struct MHSurfaceStyleResolutionTests {
    @Test
    func elevated_surface_role_resolves_its_dedicated_treatment() {
        var theme = MHTheme.standard
        theme.surfaces.elevated = .init(
            colorRole: .surfaceElevated,
            opacity: 0.84,
            borderColorRole: .accent,
            borderOpacity: 0.32
        )

        let surface = theme.resolvedSurfaceStyle(for: .elevated)

        #expect(theme.surfaceColorRole(for: .elevated) == .surfaceElevated)
        #expect(surface.fillRole == .surfaceElevated)
        #expect(surface.fillOpacity == 0.84)
        #expect(surface.borderRole == .accent)
        #expect(surface.borderOpacity == 0.32)
    }

    @Test
    func customized_treatments_resolve_to_their_non_glass_recipe() {
        var theme = MHTheme.standard
        theme.surfaces = .init(
            canvas: .init(colorRole: .surfaceMuted, opacity: 0.5),
            standard: .init(
                colorRole: .accent,
                opacity: 0.2,
                borderColorRole: .accent,
                borderOpacity: 0.4
            ),
            elevated: .init(colorRole: .surface),
            muted: .init(
                colorRole: .warning,
                opacity: 0.1,
                borderColorRole: .warning,
                borderOpacity: 0.3
            )
        )

        #expect(
            theme.resolvedCanvasSurfaceStyle()
                == .init(fillRole: .surfaceMuted, fillOpacity: 0.5, borderRole: .border, borderOpacity: 0)
        )
        #expect(
            theme.resolvedSurfaceStyle(for: .standard)
                == .init(fillRole: .accent, fillOpacity: 0.2, borderRole: .accent, borderOpacity: 0.4)
        )
        #expect(
            theme.resolvedSurfaceStyle(for: .elevated)
                == .init(fillRole: .surface, fillOpacity: 1, borderRole: .border, borderOpacity: 0)
        )
        #expect(
            theme.resolvedSurfaceStyle(for: .muted)
                == .init(fillRole: .warning, fillOpacity: 0.1, borderRole: .warning, borderOpacity: 0.3)
        )
    }
}
