import SwiftUI

private struct MHColorRoleUsagePreview: View {
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
            Text("Color Role Usage")
                .mhTextStyle(.screenTitle)

            Spacer(minLength: MHTheme.standard.spacing.control)

            Text(context.colorMode.title)
                .mhTextStyle(.metadata, colorRole: .secondaryText)
        }
    }
}

#Preview("Design System / 02 Color Role Usage / Light") {
    MHColorRoleUsagePreview(
        context: MHPreviewStyle.context(
            colorMode: .light,
            glassPolicy: .disabled
        )
    )
}

#Preview("Design System / 02 Color Role Usage / Dark") {
    MHColorRoleUsagePreview(
        context: MHPreviewStyle.context(
            colorMode: .dark,
            glassPolicy: .disabled
        )
    )
}
