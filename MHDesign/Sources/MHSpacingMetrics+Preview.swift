// swiftlint:disable no_magic_numbers
import SwiftUI

private struct MHSpacingMetricsPreview: View {
    private enum PreviewStyle {
        static let markerSize: CGFloat = 18
    }

    let title: String
    let metrics: MHSpacingMetrics

    var body: some View {
        MHDesignPreviewSupport.PreviewCard(
            title: title,
            supporting: "Inline, control, content, section, and screen spacing each show their own separation rhythm."
        ) {
            VStack(alignment: .leading, spacing: metrics.section) {
                VStack(alignment: .leading, spacing: metrics.control) {
                    ForEach(MHSpacingRole.allCases, id: \.self) { role in
                        spacingRow(for: role)
                    }
                }

                VStack(alignment: .leading, spacing: metrics.section) {
                    block(title: "Section Rhythm")
                    block(title: "Next Section")
                }
            }
        }
    }

    private func spacingRow(
        for role: MHSpacingRole
    ) -> some View {
        VStack(alignment: .leading, spacing: metrics.inline) {
            MHDesignPreviewSupport.MetricRow(
                label: MHDesignPreviewSupport.title(for: role),
                value: MHDesignPreviewSupport.formatted(metrics[role])
            )

            HStack(spacing: metrics[role]) {
                marker(opacity: 0.28)
                marker(opacity: 0.55)
            }
        }
    }

    private func marker(
        opacity: Double
    ) -> some View {
        Circle()
            .fill(MHDesignPreviewColor.accent.opacity(opacity))
            .frame(
                width: PreviewStyle.markerSize,
                height: PreviewStyle.markerSize
            )
    }

    private func block(
        title: String
    ) -> some View {
        VStack(alignment: .leading, spacing: metrics.content) {
            Text(title)
                .font(.headline)

            VStack(alignment: .leading, spacing: metrics.control) {
                Text("Control spacing keeps nearby elements connected.")
                Text("Inline spacing stays tighter for grouped details.")
                    .font(.footnote)
                    .foregroundStyle(
                        MHDesignPreviewColor.secondaryText
                    )
            }
            .padding(.vertical, metrics.inline)
        }
    }
}

private extension MHSpacingMetrics {
    static let previewComparison = MHDesignPreviewSupport.comparisonMetrics.spacing
}

#Preview("Spacing Metrics", traits: .fixedLayout(width: 760, height: 900)) {
    MHDesignPreviewSupport.PreviewCanvas(
        title: "Spacing metrics",
        supporting: "Tune the spacing ladder without bringing in MHUI chrome."
    ) {
        VStack(alignment: .leading, spacing: 24) {
            MHSpacingMetricsPreview(
                title: "Standard Spacing",
                metrics: MHDesignMetrics.standard.spacing
            )

            MHSpacingMetricsPreview(
                title: "Comparison Spacing",
                metrics: .previewComparison
            )
        }
    }
}
// swiftlint:enable no_magic_numbers
