import SwiftUI

private extension MHLayoutMetrics {
    // swiftlint:disable no_magic_numbers
    static let previewComparison = Self(
        readableContentWidth: 720,
        compactWidthThreshold: 680,
        screen: .init(
            contentInsetHorizontal: 56,
            contentInsetVertical: 88,
            contentSpacing: 56,
            compactContentInsetHorizontal: 20,
            compactContentInsetVertical: 36,
            compactContentSpacing: 28
        ),
        surface: .init(
            insetHorizontal: 30,
            insetVertical: 30,
            compactInsetHorizontal: 20,
            compactInsetVertical: 20
        ),
        control: .init(
            minimumTouchTarget: 52
        )
    )
    // swiftlint:enable no_magic_numbers
}

private extension MHDesignMetrics {
    static let previewLayoutComparison = Self(
        spacing: MHDesignMetrics.standard.spacing,
        cornerRadius: MHDesignMetrics.standard.cornerRadius,
        layout: .previewComparison
    )
}

#Preview("Layout Metrics", traits: .fixedLayout(width: 980, height: 1_700)) {
    MHDesignPreviewSupport.PreviewCanvas(
        title: "Layout metrics",
        supporting: """
            Focus on readable width, compact threshold, and
            screen or surface inset changes across regular and compact widths.
            """
    ) {
        VStack(alignment: .leading, spacing: 24) {
            MHDesignPreviewSupport.WidthComparison(
                title: "Standard Layout",
                supporting: "Baseline layout behavior from the current package defaults.",
                metrics: .standard
            ) { width in
                MHDesignPreviewSupport.DemoBoard(width: width)
            }

            MHDesignPreviewSupport.WidthComparison(
                title: "Comparison Layout",
                supporting: """
                    Preview-only layout values make threshold and inset changes easier to inspect in isolation.
                    """,
                metrics: .previewLayoutComparison
            ) { width in
                MHDesignPreviewSupport.DemoBoard(width: width)
            }
        }
    }
}
