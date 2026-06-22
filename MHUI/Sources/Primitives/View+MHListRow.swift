import SwiftUI

public extension View {
    /// Applies the shared MHUI row container rhythm.
    func mhRow() -> some View {
        modifier(MHRowModifier())
    }

    /// Styles restrained row metadata shown above a row title.
    func mhRowOverline() -> some View {
        mhTextStyle(.metadata, colorRole: .secondaryText)
    }

    /// Styles a row title with quiet emphasis.
    func mhRowTitle() -> some View {
        mhTextStyle(.bodyStrong)
    }

    /// Styles secondary row copy.
    func mhRowSupporting() -> some View {
        mhTextStyle(.supporting, colorRole: .secondaryText)
    }

    /// Styles trailing row values with subdued emphasis by default.
    func mhRowValue(
        colorRole: MHColorRole = .secondaryText
    ) -> some View {
        mhTextStyle(.body, colorRole: colorRole)
    }
}

// MARK: - Preview

#Preview("Row", traits: .sizeThatFitsLayout) {
    HStack(alignment: .top, spacing: MHTheme.standard.spacing.control) {
        Image(systemName: "square.stack.3d.up")
            .mhTextStyle(.sectionTitle, colorRole: .accent)

        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.inline) {
            Text("Foundation")
                .mhRowOverline()
            Text("Workflows")
                .mhRowTitle()
            Text("Reusable screen composition and quiet styling.")
                .mhRowSupporting()
        }
        .frame(maxWidth: .infinity, alignment: .leading)

        Text("v1")
            .mhRowValue()
    }
    .mhRow()
    .mhSurfaceInset()
    .mhSurface()
    .mhPreviewSurface()
}
