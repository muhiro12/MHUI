import SwiftUI

private struct MHAccentStylePreview: View {
    let accentStyle: MHAccentStyle

    var body: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.group) {
            Text(accentStyle.rawValue.capitalized)
                .mhTextStyle(.caption, colorRole: .secondaryText)

            MHSectionBlock(
                "Accent Review",
                supporting: "The same section framing shown with each built-in accent."
            ) {
                MHRowGroup {
                    reviewRow
                    MHKeyValueRow("Focus", value: "Calm")
                }
            }
        }
        .mhTheme(MHTheme.standard(accentStyle: accentStyle))
    }
}

private extension MHAccentStylePreview {
    var reviewRow: some View {
        MHListRow(
            title: Text("Quiet action"),
            subtitle: Text("Accent should read as a precise signal."),
            leading: {
                EmptyView()
            },
            trailing: {
                Button("Review") {
                    // no-op
                }
                .buttonStyle(MHActionButtonStyle(role: .quiet))
            }
        )
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
