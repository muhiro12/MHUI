import SwiftUI

/// A native button that dismisses the current presentation.
public struct MHDismissButton: View {
    @Environment(\.dismiss)
    private var dismiss

    private let accessibilityLabel: Text

    public var body: some View {
        Button(role: .cancel) {
            dismiss()
        } label: {
            Image(systemName: "xmark")
        }
        .accessibilityLabel(accessibilityLabel)
    }

    public init(
        accessibilityLabel: Text = Text("Close")
    ) {
        self.accessibilityLabel = accessibilityLabel
    }
}

// MARK: - Preview

#Preview("Dismiss Button", traits: .sizeThatFitsLayout) {
    NavigationStack {
        List {
            Text("Modal content")
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                MHDismissButton()
            }
        }
    }
    .mhPreviewSurface()
}
