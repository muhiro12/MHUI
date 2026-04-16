import SwiftUI

private extension MHDesignMetrics {
    static let previewComparison = MHDesignPreviewSupport.comparisonMetrics
}

#Preview("Design Metrics Tuning", traits: .fixedLayout(width: 980, height: 1_800)) {
    MHDesignPreviewSupport.PreviewCanvas(
        title: "MHDesign metrics tuning",
        supporting: """
            Compare the standard baseline against an intentionally adjusted metrics set at regular and compact widths.
            """
    ) {
        VStack(alignment: .leading, spacing: 24) {
            MHDesignPreviewSupport.WidthComparison(
                title: "Standard Metrics",
                supporting: "Use this as the baseline for package-wide rhythm and layout decisions.",
                metrics: .standard
            ) { width in
                MHDesignPreviewSupport.DemoBoard(width: width)
            }

            MHDesignPreviewSupport.WidthComparison(
                title: "Comparison Metrics",
                supporting: """
                    This preview-only variant exaggerates spacing, radius, and layout values
                    so adjustments are easier to evaluate.
                    """,
                metrics: .previewComparison
            ) { width in
                MHDesignPreviewSupport.DemoBoard(width: width)
            }
        }
    }
}
