// swiftlint:disable one_declaration_per_file file_types_order
import SwiftUI

private enum MHSurface {}

/// Surface prominence used by `mhSurface(role:)`.
public enum MHSurfaceRole: String, Sendable, CaseIterable {
    case standard
    case muted
}

private struct MHSurfaceModifier: ViewModifier {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.colorScheme)
    private var colorScheme

    let role: MHSurfaceRole

    func body(content: Content) -> some View {
        let shape = RoundedRectangle(
            cornerRadius: theme.radius.surface,
            style: .continuous
        )

        return content
            .background(
                theme.resolvedColor(
                    for: theme.surfaceColorRole(for: role),
                    in: colorScheme
                ),
                in: shape
            )
            .overlay {
                shape
                    .stroke(
                        theme.resolvedColor(for: .border, in: colorScheme)
                            .opacity(theme.divider.opacity),
                        lineWidth: theme.divider.thickness
                    )
            }
    }
}

private struct MHSurfaceInsetModifier: ViewModifier {
    @Environment(\.mhTheme)
    private var theme

    func body(content: Content) -> some View {
        content
            .padding(.horizontal, theme.spacing.group)
            .padding(.vertical, theme.spacing.group + theme.spacing.inline)
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
