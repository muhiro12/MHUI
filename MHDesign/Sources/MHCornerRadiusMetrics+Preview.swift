// swiftlint:disable no_magic_numbers
import SwiftUI

private struct MHCornerRadiusMetricsPreview: View {
    private enum PreviewStyle {
        static let canvasSpacing: CGFloat = 24
        static let controlSize = CGSize(width: 120, height: 72)
        static let surfaceSize = CGSize(width: 180, height: 96)
        static let controlOpacity = 0.22
        static let surfaceOpacity = 0.12
    }

    let title: String
    let metrics: MHCornerRadiusMetrics

    var body: some View {
        MHDesignPreviewSupport.PreviewCard(
            title: title,
            supporting: "Compare the compact control radius against the broader detached surface radius."
        ) {
            VStack(alignment: .leading, spacing: 20) {
                HStack(alignment: .top, spacing: 20) {
                    swatch(
                        role: .control,
                        size: PreviewStyle.controlSize
                    )
                    swatch(
                        role: .surface,
                        size: PreviewStyle.surfaceSize
                    )
                }

                MHDesignPreviewSupport.MetricRow(
                    label: MHDesignPreviewSupport.title(for: MHCornerRadiusRole.control),
                    value: MHDesignPreviewSupport.formatted(metrics[MHCornerRadiusRole.control])
                )
                MHDesignPreviewSupport.MetricRow(
                    label: MHDesignPreviewSupport.title(for: MHCornerRadiusRole.surface),
                    value: MHDesignPreviewSupport.formatted(metrics[MHCornerRadiusRole.surface])
                )
            }
        }
    }

    private func swatch(
        role: MHCornerRadiusRole,
        size: CGSize
    ) -> some View {
        RoundedRectangle(
            cornerRadius: metrics[role],
            style: .continuous
        )
        .fill(
            Color.accentColor.opacity(
                role == .control
                    ? PreviewStyle.controlOpacity
                    : PreviewStyle.surfaceOpacity
            )
        )
        .frame(width: size.width, height: size.height)
        .overlay {
            Text(MHDesignPreviewSupport.title(for: role))
                .font(.footnote.weight(.semibold))
        }
    }
}

private extension MHCornerRadiusMetrics {
    static let previewComparison = MHDesignPreviewSupport.comparisonMetrics.cornerRadius
}

#if !MHUI_DISABLE_PACKAGE_PREVIEWS
#Preview("Corner Radius Metrics", traits: .sizeThatFitsLayout) {
    MHDesignPreviewSupport.PreviewCanvas(
        title: "Corner radius metrics",
        supporting: "Adjust control and surface geometry with direct shape swatches."
    ) {
        VStack(alignment: .leading, spacing: 24) {
            MHCornerRadiusMetricsPreview(
                title: "Standard Radius",
                metrics: MHDesignMetrics.standard.cornerRadius
            )

            MHCornerRadiusMetricsPreview(
                title: "Comparison Radius",
                metrics: .previewComparison
            )
        }
    }
}
// swiftlint:enable no_magic_numbers
#endif
