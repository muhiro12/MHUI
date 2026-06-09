// swiftlint:disable one_declaration_per_file file_types_order
import SwiftUI

private enum MHSurface {}

typealias MHResolvedSurfaceStyle = MHResolvedGlassBackgroundStyle

struct MHResolvedSurfaceInsetStyle: Sendable, Equatable {
    var horizontal: CGFloat
    var vertical: CGFloat
}

/// Surface prominence used by `mhSurface(role:)`.
public enum MHSurfaceRole: String, Sendable, CaseIterable {
    case standard
    case muted
}

private struct MHSurfaceModifier: ViewModifier {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.mhGlassPolicy)
    private var glassPolicy
    @Environment(\.colorScheme)
    private var colorScheme
    @Environment(\.accessibilityReduceTransparency)
    private var accessibilityReduceTransparency

    let role: MHSurfaceRole

    func body(content: Content) -> some View {
        let shape = RoundedRectangle(
            cornerRadius: theme.cornerRadius.surface,
            style: .continuous
        )
        let style = theme.resolvedSurfaceStyle(
            for: role,
            glassPolicy: glassPolicy,
            reduceTransparency: accessibilityReduceTransparency
        )

        return content
            .background {
                MHSurfaceFill(
                    shape: shape,
                    style: style,
                    theme: theme,
                    colorScheme: colorScheme
                )
            }
            .overlay {
                shape
                    .stroke(
                        theme.resolvedColor(
                            for: style.borderRole ?? .border,
                            in: colorScheme
                        )
                        .opacity(style.borderOpacity),
                        lineWidth: theme.divider.thickness
                    )
            }
    }
}

private struct MHSurfaceInsetModifier: ViewModifier {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.mhAdaptiveLayoutContext)
    private var adaptiveLayoutContext
    @Environment(\.horizontalSizeClass)
    private var horizontalSizeClass

    func body(content: Content) -> some View {
        let context = adaptiveLayoutContext.resolved(
            with: horizontalSizeClass,
            threshold: theme.layout.compactWidthThreshold
        )
        let style = theme.resolvedSurfaceInsetStyle(for: context)

        content
            .padding(.horizontal, style.horizontal)
            .padding(.vertical, style.vertical)
    }
}

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
            glassTintOpacity: usesGlass ? treatment.glassTintOpacity : 0,
            borderRole: treatment.borderColorRole,
            borderOpacity: treatment.borderOpacity
        )
    }
}

public extension View {
    /// Applies calm surface chrome without changing the wrapped layout.
    func mhSurface(role: MHSurfaceRole = .standard) -> some View {
        modifier(MHSurfaceModifier(role: role))
    }

    /// Applies the standard interior inset used for grouped surfaces.
    func mhSurfaceInset() -> some View {
        modifier(MHSurfaceInsetModifier())
    }
}

// MARK: - Preview

#Preview("Surface", traits: .sizeThatFitsLayout) {
    VStack(alignment: .leading, spacing: MHTheme.standard.spacing.content) {
        Text("Calm Surface")
            .mhTextStyle(.sectionTitle)
        Text("Used for grouped settings, cards, and empty states.")
            .mhTextStyle(.supporting, colorRole: .secondaryText)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .mhSurfaceInset()
    .mhSurface()
    .mhPreviewSurface(padding: 0)
}
// swiftlint:enable one_declaration_per_file file_types_order
