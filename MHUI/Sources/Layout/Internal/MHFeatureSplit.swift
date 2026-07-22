import SwiftUI

struct MHFeatureSplit<Lead: View, Supporting: View>: View {
    let lead: Lead
    let supporting: Supporting
    let style: MHResolvedFeatureGridStyle

    var body: some View {
        HStack(alignment: .top, spacing: style.primarySpacing) {
            lead
                .frame(maxWidth: .infinity, alignment: .topLeading)

            MHFeatureSupportingGrid(
                content: supporting,
                columnCount: style.supportingColumnCount,
                spacing: style.supportingSpacing
            )
            .frame(
                width: style.supportingColumnWidth,
                alignment: .topLeading
            )
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }
}
