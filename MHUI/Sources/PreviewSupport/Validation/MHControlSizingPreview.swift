import SwiftUI

/// Compares native sizing with a custom label-only style and MHUI sizing.
private struct MHControlSizingPreview: View {
    @Environment(\.mhTheme)
    private var theme
    @State private var automaticSize = CGSize.zero
    @State private var borderedSize = CGSize.zero
    @State private var labelSize = CGSize.zero
    @State private var actionSize = CGSize.zero

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.content) {
            Text("Control sizing")
                .mhTextStyle(.screenTitle)
            Button("Continue") {
                // Preview action.
            }
            .onGeometryChange(for: CGSize.self) { $0.size } action: { automaticSize = $0 }
            measurement("Automatic", size: automaticSize)
            Button("Continue") {
                // Preview action.
            }
            .buttonStyle(.bordered)
            .onGeometryChange(for: CGSize.self) { $0.size } action: { borderedSize = $0 }
            measurement("Bordered", size: borderedSize)
            Button("Continue") {
                // Preview action.
            }
            .buttonStyle(MHLabelOnlySizingProbeStyle())
            .onGeometryChange(for: CGSize.self) { $0.size } action: { labelSize = $0 }
            measurement("Custom label only", size: labelSize)
            Button("Continue") {
                // Preview action.
            }
            .buttonStyle(.mhSecondary)
            .onGeometryChange(for: CGSize.self) { $0.size } action: { actionSize = $0 }
            measurement("MHUI", size: actionSize)
            Text("Measured layout bounds; not a hit-testing audit.")
                .mhTextStyle(.caption)
        }
        .mhScreen()
    }

    private func measurement(_ title: String, size: CGSize) -> some View {
        Text("\(title): \(Int(size.width.rounded())) × \(Int(size.height.rounded())) pt")
            .mhTextStyle(.supporting)
    }
}

#Preview("Native and custom control sizing") {
    MHControlSizingPreview()
        .mhTheme(.standard)
}
