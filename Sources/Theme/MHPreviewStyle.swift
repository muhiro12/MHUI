import SwiftUI

enum MHPreviewStyle {
    static let defaultAccentStyle: MHAccentStyle = .orange

    static func theme(
        accentStyle _: MHAccentStyle = defaultAccentStyle
    ) -> MHTheme {
        MHTheme.standard()
    }

    static func lightAccent(
        accentStyle: MHAccentStyle = defaultAccentStyle
    ) -> Color {
        MHTheme.standard(accentStyle: accentStyle)
            .colorReference(for: .accent)
            .resolve(for: .light)
    }

    static func lightBackground(
        accentStyle: MHAccentStyle = defaultAccentStyle
    ) -> Color {
        theme(accentStyle: accentStyle)
            .colorReference(for: .background)
            .resolve(for: .light)
    }
}

extension View {
    func mhPreviewTint(
        accentStyle: MHAccentStyle = MHPreviewStyle.defaultAccentStyle
    ) -> some View {
        let theme = MHPreviewStyle.theme(accentStyle: accentStyle)

        return self
            .mhTheme(theme)
            .tint(MHPreviewStyle.lightAccent(accentStyle: accentStyle))
            .preferredColorScheme(.light)
    }

    func mhPreviewSurface(
        accentStyle: MHAccentStyle = MHPreviewStyle.defaultAccentStyle,
        padding: CGFloat = MHTheme.standard.spacing.group
    ) -> some View {
        mhPreviewTint(accentStyle: accentStyle)
            .padding(padding)
            .background(MHPreviewStyle.lightBackground(accentStyle: accentStyle))
    }
}
