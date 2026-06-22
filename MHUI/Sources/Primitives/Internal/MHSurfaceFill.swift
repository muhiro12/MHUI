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
                        resolvedGlass,
                        in: shape
                    )
            } else {
                fallbackFill
            }
        } else {
            fallbackFill
        }
    }

    @available(iOS 26, macOS 26, watchOS 26, *)
    private var resolvedGlass: Glass {
        let glass = resolvedTintedGlass

        return style.isGlassInteractive
            ? glass.interactive()
            : glass
    }

    @available(iOS 26, macOS 26, watchOS 26, *)
    private var resolvedTintedGlass: Glass {
        guard let glassTintRole = style.glassTintRole else {
            return .regular
        }

        return .regular.tint(
            theme.resolvedColor(
                for: glassTintRole,
                in: colorScheme
            )
            .opacity(style.glassTintOpacity)
        )
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
