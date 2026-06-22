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
        case .muted:
            .surfaceMuted
        }
    }

    func resolvedSurfaceStyle(
        for role: MHSurfaceRole,
        glassPolicy: MHGlassPolicy,
        reduceTransparency: Bool,
        supportsGlass: Bool = MHGlassRuntimeSupport.isAvailable
    ) -> MHResolvedSurfaceStyle {
        resolvedSurfaceStyle(
            treatment: treatment(for: role),
            glassPolicy: glassPolicy,
            reduceTransparency: reduceTransparency,
            supportsGlass: supportsGlass
        )
    }

    func resolvedCanvasSurfaceStyle(
        glassPolicy: MHGlassPolicy,
        reduceTransparency: Bool,
        supportsGlass: Bool = MHGlassRuntimeSupport.isAvailable
    ) -> MHResolvedSurfaceStyle {
        resolvedSurfaceStyle(
            treatment: surfaces.canvas,
            glassPolicy: glassPolicy,
            reduceTransparency: reduceTransparency,
            supportsGlass: supportsGlass
        )
    }

    private func treatment(
        for role: MHSurfaceRole
    ) -> SurfaceTreatment {
        switch role {
        case .standard:
            surfaces.standard
        case .muted:
            surfaces.muted
        }
    }

    private func resolvedSurfaceStyle(
        treatment: SurfaceTreatment,
        glassPolicy: MHGlassPolicy,
        reduceTransparency: Bool,
        supportsGlass: Bool
    ) -> MHResolvedSurfaceStyle {
        let usesGlass = glassPolicy.resolvesUsesGlass(
            prefersGlass: treatment.prefersGlass,
            supportsGlass: supportsGlass,
            reduceTransparency: reduceTransparency
        )

        return .init(
            usesGlass: usesGlass,
            fallbackFillRole: treatment.fallbackColorRole,
            fallbackFillOpacity: treatment.fallbackOpacity,
            glassTintRole: usesGlass ? treatment.glassTintColorRole : nil,
            glassTintOpacity: usesGlass ? treatment.glassTintOpacity : .zero,
            borderRole: treatment.borderColorRole,
            borderOpacity: treatment.borderOpacity
        )
    }
}
