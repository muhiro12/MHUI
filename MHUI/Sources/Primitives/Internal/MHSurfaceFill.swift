import SwiftUI

// Shared surface fill keeps glass and fallback rendering on the same code path.
struct MHSurfaceFill<ShapeType: Shape>: View {
    let shape: ShapeType
    let style: MHResolvedGlassBackgroundStyle
    let theme: MHTheme
    let colorScheme: ColorScheme

    @ViewBuilder var body: some View {
        if style.usesGlass {
            if #available(iOS 26, macOS 26, watchOS 26, *) {
                shape
                    .fill(.clear)
                    .glassEffect(
                        style.glass(theme: theme, colorScheme: colorScheme, isEnabled: true),
                        in: shape
                    )
            } else {
                fallbackFill
            }
        } else {
            fallbackFill
        }
    }

    @ViewBuilder private var fallbackFill: some View {
        if let fallbackFillRole = style.fallbackFillRole {
            shape
                .fill(
                    theme.resolvedColor(
                        for: fallbackFillRole,
                        in: colorScheme
                    )
                    .opacity(style.fallbackFillOpacity)
                )
        } else {
            shape
                .fill(.clear)
        }
    }
}
