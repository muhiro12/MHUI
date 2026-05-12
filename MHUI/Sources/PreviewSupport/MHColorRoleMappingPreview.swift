import SwiftUI

private struct MHColorRoleMappingPreview: View {
    let context: MHPreviewContext

    var body: some View {
        ZStack {
            MHCanvasBackground()

            ScrollView {
                VStack(alignment: .leading, spacing: MHTheme.standard.spacing.section) {
                    header
                    MHColorRoleUsageExamples()
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

#Preview("Color Role Usage Light") {
    MHColorRoleMappingPreview(
        context: MHPreviewStyle.context(
            colorMode: .light,
            glassPolicy: .disabled
        )
    )
}

#Preview("Color Role Usage Dark") {
    MHColorRoleMappingPreview(
        context: MHPreviewStyle.context(
            colorMode: .dark,
            glassPolicy: .disabled
        )
    )
}
