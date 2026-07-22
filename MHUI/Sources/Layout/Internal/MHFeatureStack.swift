import SwiftUI

struct MHFeatureStack<Lead: View, Supporting: View>: View {
    let lead: Lead
    let supporting: Supporting
    let style: MHResolvedFeatureGridStyle

    var body: some View {
        VStack(alignment: .leading, spacing: style.primarySpacing) {
            lead
                .frame(maxWidth: .infinity, alignment: .topLeading)

            MHFeatureSupportingGrid(
                content: supporting,
                columnCount: style.supportingColumnCount,
                spacing: style.supportingSpacing
            )
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }
}
