// swiftlint:disable no_magic_numbers
import SwiftUI

private struct MHDesignMetricsOverridePreview: View {
    private enum PreviewLayout {
        static let height: CGFloat = 1_260
    }

    let title: String
    let metrics: MHDesignMetrics

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .mhDesignPreviewLabelStyle()

            MHDesignPreviewSupport.DemoBoard(
                width: MHDesignPreviewSupport.compactWidth
            )
            .mhDesignMetrics(metrics)
        }
    }
}

private extension MHDesignMetrics {
    static let previewOverride = MHDesignPreviewSupport.comparisonMetrics
}

private extension View {
    func mhDesignPreviewLabelStyle() -> some View {
        font(.subheadline.weight(.semibold))
            .foregroundStyle(.secondary)
    }
}

#if !MHUI_DISABLE_PACKAGE_PREVIEWS
#Preview(
    "Design Metrics Override",
    traits: .fixedLayout(
        width: 820,
        height: 1_260
    )
) {
    MHDesignPreviewSupport.PreviewCanvas(
        title: "Design metrics override",
        supporting: """
            The same subtree should respond immediately when `mhDesignMetrics(_:)` overrides the active metrics.
            """
    ) {
        VStack(alignment: .leading, spacing: 24) {
            MHDesignMetricsOverridePreview(
                title: "Standard Subtree",
                metrics: .standard
            )

            MHDesignMetricsOverridePreview(
                title: "Overridden Subtree",
                metrics: .previewOverride
            )
        }
    }
}
// swiftlint:enable no_magic_numbers
#endif
