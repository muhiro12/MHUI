import SwiftUI

private struct MHAccentStylePreview: View {
    let accentStyle: MHAccentStyle

    var body: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.group) {
            Text(accentStyle.rawValue.capitalized)
                .mhTextStyle(.caption, colorRole: .secondaryText)

            VStack(spacing: 0) {
                reviewRow
                LabeledContent("Focus", value: "Calm")
                    .labeledContentStyle(.mhKeyValue)
            }
            .mhGroupedRows()
            .mhSection(
                "Accent Review",
                supporting: "The same section framing shown with each built-in accent."
            )
        }
        .mhTheme(MHTheme.standard(accentStyle: accentStyle))
    }
}

private extension MHAccentStylePreview {
    var reviewRow: some View {
        HStack(alignment: .top, spacing: MHTheme.standard.spacing.control) {
            VStack(alignment: .leading, spacing: MHTheme.standard.spacing.inline) {
                Text("Quiet action")
                    .mhRowTitle()
                Text("Accent should read as a precise signal.")
                    .mhRowSupporting()
            }
            Spacer()
            Button("Review") {
                // no-op
            }
            .buttonStyle(.mhQuiet)
        }
        .mhRow()
    }
}

#Preview("Accent Styles", traits: .fixedLayout(width: 900, height: 1_500)) {
    ScrollView {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.section) {
            ForEach(MHAccentStyle.allCases, id: \.rawValue) { accentStyle in
                MHAccentStylePreview(accentStyle: accentStyle)
            }
        }
        .padding(MHTheme.standard.spacing.screen)
    }
    .mhPreviewSurface(padding: 0)
}
