import SwiftUI

enum MHPreviewStyle {
    static let lightAccent =
        MHTheme.standard.colorReference(for: .accent).resolve(for: .light)
    static let lightBackground =
        MHTheme.standard.colorReference(for: .background).resolve(for: .light)
}

extension View {
    func mhPreviewTint() -> some View {
        tint(MHPreviewStyle.lightAccent)
            .preferredColorScheme(.light)
    }

    func mhPreviewSurface(
        padding: CGFloat = MHTheme.standard.spacing.group
    ) -> some View {
        mhPreviewTint()
            .padding(padding)
            .background(MHPreviewStyle.lightBackground)
    }
}
