import SwiftUI

// Shared surface fill keeps solid and material rendering on the same code path.
struct MHSurfaceFill<ShapeType: Shape>: View {
    let shape: ShapeType
    let style: MHResolvedSurfaceStyle
    let theme: MHTheme
    let colorScheme: ColorScheme

    var body: some View {
        if let materialStyle = style.materialStyle, style.usesMaterial {
            materialStyle.fill(shape)

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
}
