import SwiftUI

// Content surfaces, badges, inputs, and the canvas share one non-glass fill path.
struct MHSurfaceFill<ShapeType: Shape>: View {
    let shape: ShapeType
    let style: MHResolvedSurfaceStyle
    let theme: MHTheme
    let colorScheme: ColorScheme

    var body: some View {
        shape
            .fill(
                theme.resolvedColor(
                    for: style.fillRole,
                    in: colorScheme
                )
                .opacity(style.fillOpacity)
            )
    }
}
