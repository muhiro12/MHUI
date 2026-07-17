import SwiftUI

private struct MHThemeModifier: ViewModifier {
    @Environment(\.colorScheme)
    private var colorScheme

    let theme: MHTheme

    @ViewBuilder
    func body(content: Content) -> some View {
        if let nativeTint = theme.nativeTintOverride(in: colorScheme) {
            content
                .environment(\.mhTheme, theme)
                .tint(nativeTint)
        } else {
            content
                .environment(\.mhTheme, theme)
        }
    }
}

public extension View {
    /// Applies the complete inheritable MHUI styling baseline to this subtree.
    ///
    /// Apply this once near the app's root. It propagates the theme, synchronizes
    /// its MHDesign metrics, and applies an asset-backed native-control tint when
    /// the theme supplies one. Apply it again only for an intentional local
    /// theme exception. Screen structure and semantic control roles remain
    /// explicit because a root modifier cannot infer them safely.
    func mhTheme(_ theme: MHTheme) -> some View {
        modifier(MHThemeModifier(theme: theme))
    }
}

// MARK: - Preview

// swiftlint:disable closure_body_length
#Preview("Root Theme and Local Override", traits: .sizeThatFitsLayout) {
    @Previewable @State var isEnabled = true

    var appTheme = MHTheme.standard(
        accent: .asset(MHPreviewColorAsset.hostAccent)
    )
    appTheme.typography.bodyStrong = .init(
        font: .title3,
        weight: .bold
    )

    var localTheme = appTheme
    localTheme.colors.accent = .asset(
        MHPreviewColorAsset.purple
    )

    return VStack(alignment: .leading, spacing: appTheme.spacing.content) {
        Text("App theme")
            .mhTextStyle(.bodyStrong)

        Toggle("Native control tint", isOn: $isEnabled)

        Button("Primary action") {
            // no-op
        }
        .buttonStyle(.mhPrimary)

        VStack(alignment: .leading, spacing: localTheme.spacing.control) {
            Text("Local subtree override")
                .mhTextStyle(.bodyStrong)

            Button("Local action") {
                // no-op
            }
            .buttonStyle(.mhPrimary)
        }
        .mhSurfaceInset()
        .mhSurface(role: .muted)
        .mhTheme(localTheme)
    }
    .padding(appTheme.spacing.content)
    .mhTheme(appTheme)
}
// swiftlint:enable closure_body_length
