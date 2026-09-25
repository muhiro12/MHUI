import SwiftUI

private struct MHTextInheritancePreview: View {
    var body: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.control) {
            Text("Primary").mhTextStyle(.body)
            Text("Secondary").mhTextStyle(.supporting, colorRole: .secondaryText)
            Text("Tertiary").mhTextStyle(.caption, colorRole: .tertiaryText)
            Toggle("Enabled", isOn: .constant(true))
            Toggle("Disabled", isOn: .constant(true)).disabled(true)
            Button("Continue") {
                // Preview-only action.
            }
            .buttonStyle(.borderedProminent)
            Button("Unavailable") {
                // Preview-only action.
            }
            .buttonStyle(.borderedProminent)
            .disabled(true)
        }
    }
}

#Preview("Themed Text and Native Opt Out") {
    ScrollView {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.section) {
            Text("MHUI text and native controls").font(.headline)
            MHTextInheritancePreview().mhTheme(.standard)
            Text("Explicit native appearance").font(.headline)
            MHTextInheritancePreview().mhTextAppearance(.native).mhTheme(.standard)
        }
        .padding()
    }
}
