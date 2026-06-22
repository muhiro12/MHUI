import SwiftUI

private struct MHKeyValueRowPreviewContent: View {
    var body: some View {
        VStack(spacing: .zero) {
            LabeledContent(
                "Shared package responsibility for narrow rows",
                value: """
                    Automatic vertical stacking should keep long values readable
                    before a host app writes local workarounds.
                    """
            )
            .labeledContentStyle(.mhKeyValue)

            LabeledContent(
                "Validation target",
                value: """
                    Long labels and long values should stay practical at common phone widths.
                    """
            )
            .labeledContentStyle(.mhKeyValue)
        }
        .mhGroupedRows()
        .mhSurfaceInset()
        .mhSurface()
    }
}

#Preview("Key Value Row", traits: .sizeThatFitsLayout) {
    MHKeyValueRowPreviewContent()
        .mhPreviewSurface(padding: .zero)
}
