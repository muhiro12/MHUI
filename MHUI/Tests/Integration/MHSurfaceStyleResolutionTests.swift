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

        let surface = theme.resolvedSurfaceStyle(
            for: .elevated,
            increasedContrast: false
        )

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
            theme.resolvedSurfaceStyle(for: .standard, increasedContrast: false)
                == .init(fillRole: .accent, fillOpacity: 0.2, borderRole: .accent, borderOpacity: 0.4)
        )
        #expect(
            theme.resolvedSurfaceStyle(for: .elevated, increasedContrast: false)
                == .init(fillRole: .surface, fillOpacity: 1, borderRole: .border, borderOpacity: 0)
        )
        #expect(
            theme.resolvedSurfaceStyle(for: .muted, increasedContrast: false)
                == .init(fillRole: .warning, fillOpacity: 0.1, borderRole: .warning, borderOpacity: 0.3)
        )
    }

    @Test(arguments: MHSurfaceRole.allCases)
    func standard_surfaces_are_borderless_until_contrast_increases(role: MHSurfaceRole) {
        let theme = MHTheme.standard
        let standardSurface = theme.resolvedSurfaceStyle(
            for: role,
            increasedContrast: false
        )
        let increasedContrastSurface = theme.resolvedSurfaceStyle(
            for: role,
            increasedContrast: true
        )

        #expect(standardSurface.borderOpacity == 0)
        #expect(increasedContrastSurface.borderRole == .border)
        #expect(increasedContrastSurface.borderOpacity == theme.divider.opacity)
        #expect(increasedContrastSurface.fillRole == standardSurface.fillRole)
        #expect(theme.resolvedCanvasSurfaceStyle().borderOpacity == 0)
    }

    @Test
    func increased_contrast_preserves_a_stronger_custom_outline() {
        var theme = MHTheme.standard
        theme.surfaces.standard.borderOpacity = 0.6

        let surface = theme.resolvedSurfaceStyle(
            for: .standard,
            increasedContrast: true
        )

        #expect(surface.borderOpacity == 0.6)
    }
}
