import SwiftUI

/// Arranges one leading feature and supporting content in an adaptive grid.
///
/// The grid uses a split composition at regular widths, stacks the leading
/// feature above up to two supporting columns in compact layouts, and falls
/// back to one supporting column at accessibility text sizes.
public struct MHFeatureGrid<Lead: View, Supporting: View>: View {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.mhAdaptiveLayoutContext)
    private var adaptiveLayoutContext
    @Environment(\.horizontalSizeClass)
    private var horizontalSizeClass
    @Environment(\.dynamicTypeSize)
    private var dynamicTypeSize

    private let lead: Lead
    private let supporting: Supporting

    public var body: some View {
        let context = adaptiveLayoutContext.resolved(
            with: horizontalSizeClass,
            dynamicTypeSize: dynamicTypeSize,
            threshold: theme.layout.compactWidthThreshold
        )
        let style = theme.resolvedFeatureGridStyle(for: context)

        switch style.arrangement {
        case .split:
            MHFeatureSplit(
                lead: lead,
                supporting: supporting,
                style: style
            )
        case .stacked:
            MHFeatureStack(
                lead: lead,
                supporting: supporting,
                style: style
            )
        }
    }

    /// Creates a feature grid with a leading feature and supporting content.
    public init(
        @ViewBuilder lead: () -> Lead,
        @ViewBuilder supporting: () -> Supporting
    ) {
        self.lead = lead()
        self.supporting = supporting()
    }
}
