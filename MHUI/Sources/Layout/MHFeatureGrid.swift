import SwiftUI

/// Arranges one leading feature and supporting content in an adaptive grid.
///
/// The grid uses a split composition at regular widths, stacks the leading
/// feature above up to two supporting columns in compact layouts, and falls
/// back to one supporting column at accessibility text sizes.
/// Child view state is preserved when the arrangement changes.
public struct MHFeatureGrid<Lead: View, Supporting: View>: View {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.mhAdaptiveLayoutContext)
    private var adaptiveLayoutContext

    private let lead: Lead
    private let supporting: Supporting

    public var body: some View {
        let style = theme.resolvedFeatureGridStyle(for: adaptiveLayoutContext)

        let layout = style.arrangement == .split
            ? AnyLayout(HStackLayout(alignment: .top, spacing: style.primarySpacing))
            : AnyLayout(VStackLayout(alignment: .leading, spacing: style.primarySpacing))

        layout {
            lead
                .frame(maxWidth: .infinity, alignment: .topLeading)

            MHFeatureSupportingGrid(
                content: supporting,
                columnCount: style.supportingColumnCount,
                spacing: style.supportingSpacing
            )
            .frame(
                width: style.arrangement == .split ? style.supportingColumnWidth : nil,
                alignment: .topLeading
            )
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
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
