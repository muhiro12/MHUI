import SwiftUI

private struct MHColorAssetUsagePreview: View {
    let context: MHPreviewContext

    var body: some View {
        ZStack {
            MHCanvasBackground()

            ScrollView {
                VStack(alignment: .leading, spacing: MHTheme.standard.spacing.section) {
                    header
                    MHColorAssetUsageExamples()
                }
                .padding(MHTheme.standard.spacing.screen)
            }
        }
        .mhPreviewTint(context)
    }

    private var header: some View {
        HStack(alignment: .firstTextBaseline) {
            Text("Color Asset Usage")
                .mhTextStyle(.screenTitle)

            Spacer(minLength: MHTheme.standard.spacing.control)

            Text(context.colorMode.title)
                .mhTextStyle(.metadata, colorRole: .secondaryText)
        }
    }
}

#Preview("Color Asset Usage Light") {
    MHColorAssetUsagePreview(
        context: MHPreviewStyle.context(
            colorMode: .light,
            glassPolicy: .disabled
        )
    )
}

#Preview("Color Asset Usage Dark") {
    MHColorAssetUsagePreview(
        context: MHPreviewStyle.context(
            colorMode: .dark,
            glassPolicy: .disabled
        )
    )
}
