// swiftlint:disable one_declaration_per_file file_types_order
import SwiftUI

private enum MHSurface {}

struct MHResolvedSurfaceStyle: Sendable, Equatable {
    var usesMaterial: Bool
    var materialStyle: MHMaterialStyle?
    var fillColorRole: MHColorRole
    var overlayColorRole: MHColorRole?
    var overlayOpacity: Double
    var borderColorRole: MHColorRole
    var borderOpacity: Double
}

/// Surface prominence used by `mhSurface(role:)`.
public enum MHSurfaceRole: String, Sendable, CaseIterable {
    case standard
    case muted
}

private struct MHSurfaceModifier: ViewModifier {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.mhMaterialPolicy)
    private var materialPolicy
    @Environment(\.colorScheme)
    private var colorScheme
    @Environment(\.accessibilityReduceTransparency)
    private var accessibilityReduceTransparency

    let role: MHSurfaceRole

    func body(content: Content) -> some View {
        let shape = RoundedRectangle(
            cornerRadius: theme.radius.surface,
            style: .continuous
        )
        let style = theme.resolvedSurfaceStyle(
            for: role,
            materialPolicy: materialPolicy,
            reduceTransparency: accessibilityReduceTransparency
        )

        return content
            .background {
                ZStack {
                    surfaceFill(
                        in: shape,
                        style: style
                    )
                }
            }
            .overlay {
                shape
                    .stroke(
                        theme.resolvedColor(
                            for: style.borderColorRole,
                            in: colorScheme
                        )
                        .opacity(style.borderOpacity),
                        lineWidth: theme.divider.thickness
                    )
            }
    }

    @ViewBuilder
    func surfaceFill(
        in shape: RoundedRectangle,
        style: MHResolvedSurfaceStyle
    ) -> some View {
        if let materialStyle = style.materialStyle, style.usesMaterial {
            materialFill(
                in: shape,
                materialStyle: materialStyle
            )

            if let overlayColorRole = style.overlayColorRole {
                shape
                    .fill(
                        theme.resolvedColor(
                            for: overlayColorRole,
                            in: colorScheme
                        )
                        .opacity(style.overlayOpacity)
                    )
            }
        } else {
            shape
                .fill(
                    theme.resolvedColor(
                        for: style.fillColorRole,
                        in: colorScheme
                    )
                )
        }
    }

    @ViewBuilder
    func materialFill(
        in shape: RoundedRectangle,
        materialStyle: MHMaterialStyle
    ) -> some View {
        materialStyle.fill(shape)
    }
}

private struct MHSurfaceInsetModifier: ViewModifier {
    @Environment(\.mhTheme)
    private var theme

    func body(content: Content) -> some View {
        content
            .padding(.horizontal, theme.layout.surfaceInsetHorizontal)
            .padding(.vertical, theme.layout.surfaceInsetVertical)
    }
}

extension MHTheme {
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
        materialPolicy: MHMaterialPolicy,
        reduceTransparency: Bool
    ) -> MHResolvedSurfaceStyle {
        resolvedSurfaceStyle(
            treatment: treatment(for: role),
            materialPolicy: materialPolicy,
            reduceTransparency: reduceTransparency
        )
    }

    func resolvedCanvasSurfaceStyle(
        materialPolicy: MHMaterialPolicy,
        reduceTransparency: Bool
    ) -> MHResolvedSurfaceStyle {
        resolvedSurfaceStyle(
            treatment: surfaces.canvas,
            materialPolicy: materialPolicy,
            reduceTransparency: reduceTransparency
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
        materialPolicy: MHMaterialPolicy,
        reduceTransparency: Bool
    ) -> MHResolvedSurfaceStyle {
        let usesMaterial = materialPolicy == .enabled && !reduceTransparency

        return MHResolvedSurfaceStyle(
            usesMaterial: usesMaterial,
            materialStyle: usesMaterial ? treatment.material : nil,
            fillColorRole: treatment.fallbackColorRole,
            overlayColorRole: usesMaterial ? treatment.overlayColorRole : nil,
            overlayOpacity: usesMaterial ? treatment.overlayOpacity : 0,
            borderColorRole: treatment.borderColorRole,
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

#Preview("Surface", traits: .sizeThatFitsLayout) {
    VStack(alignment: .leading, spacing: MHTheme.standard.spacing.group) {
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
