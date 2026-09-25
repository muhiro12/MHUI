extension MHTheme {
    func resolvedSurfaceInsetStyle(
        for context: MHAdaptiveLayoutContext
    ) -> MHResolvedSurfaceInsetStyle {
        let isCompactWidth = context.isCompactWidth(
            threshold: layout.compactWidthThreshold
        )

        return .init(
            horizontal: isCompactWidth
                ? layout.surface.compactInsetHorizontal
                : layout.surface.insetHorizontal,
            vertical: isCompactWidth
                ? layout.surface.compactInsetVertical
                : layout.surface.insetVertical
        )
    }

    func surfaceColorRole(for role: MHSurfaceRole) -> MHColorRole {
        switch role {
        case .standard:
            .surface
        case .elevated:
            .surfaceElevated
        case .muted:
            .surfaceMuted
        }
    }

    func resolvedSurfaceStyle(
        for role: MHSurfaceRole,
        increasedContrast: Bool
    ) -> MHResolvedSurfaceStyle {
        resolvedSurfaceStyle(treatment: treatment(for: role))
            .outlined(
                minimumOpacity: divider.opacity,
                when: increasedContrast
            )
    }

    func resolvedCanvasSurfaceStyle() -> MHResolvedSurfaceStyle {
        resolvedSurfaceStyle(treatment: surfaces.canvas)
    }

    private func treatment(
        for role: MHSurfaceRole
    ) -> SurfaceTreatment {
        switch role {
        case .standard:
            surfaces.standard
        case .elevated:
            surfaces.elevated
        case .muted:
            surfaces.muted
        }
    }

    private func resolvedSurfaceStyle(
        treatment: SurfaceTreatment
    ) -> MHResolvedSurfaceStyle {
        .init(
            fillRole: treatment.colorRole,
            fillOpacity: treatment.opacity,
            borderRole: treatment.borderColorRole,
            borderOpacity: treatment.borderOpacity
        )
    }
}
