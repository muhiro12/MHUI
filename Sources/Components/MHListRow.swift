// swiftlint:disable one_declaration_per_file file_types_order
import SwiftUI

private enum MHListRow {}

private struct MHRowModifier: ViewModifier {
    @Environment(\.mhTheme)
    private var theme

    func body(content: Content) -> some View {
        content
            .padding(.vertical, theme.layout.rowVerticalPadding)
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(.rect)
            .listRowInsets(
                .init(
                    top: 0,
                    leading: theme.layout.rowHorizontalInset,
                    bottom: 0,
                    trailing: theme.layout.rowHorizontalInset
                )
            )
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
    }
}

public extension View {
    /// Applies the shared MHUI row container rhythm.
    func mhRow() -> some View {
        modifier(MHRowModifier())
    }

    /// Styles restrained row metadata shown above a row title.
    func mhRowOverline() -> some View {
        mhTextStyle(.metadata, colorRole: .secondaryText)
            .textCase(.uppercase)
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

#Preview("Row Styling", traits: .sizeThatFitsLayout) {
    HStack(alignment: .top, spacing: MHTheme.standard.spacing.control) {
        Image(systemName: "square.stack.3d.up")
            .font(.title3)
            .foregroundStyle(MHPreviewStyle.lightAccent())

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
// swiftlint:enable one_declaration_per_file file_types_order
