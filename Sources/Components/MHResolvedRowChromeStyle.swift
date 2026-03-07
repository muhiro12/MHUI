// swiftlint:disable one_declaration_per_file file_types_order
import SwiftUI

// Shared list row insets and padding live here so previews and labeled rows stay aligned.
struct MHResolvedRowChromeStyle: Sendable, Equatable {
    var verticalPadding: CGFloat
    var horizontalInset: CGFloat
    var accessorySpacing: CGFloat
}

private struct MHRowChromeModifier: ViewModifier {
    let style: MHResolvedRowChromeStyle

    func body(content: Content) -> some View {
        content
            .padding(.vertical, style.verticalPadding)
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(.rect)
            .listRowInsets(
                .init(
                    top: 0,
                    leading: style.horizontalInset,
                    bottom: 0,
                    trailing: style.horizontalInset
                )
            )
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
    }
}

extension View {
    func mhRowChrome(
        _ style: MHResolvedRowChromeStyle
    ) -> some View {
        modifier(MHRowChromeModifier(style: style))
    }
}

extension MHTheme {
    func resolvedRowChromeStyle() -> MHResolvedRowChromeStyle {
        .init(
            verticalPadding: layout.rowVerticalPadding,
            horizontalInset: layout.rowHorizontalInset,
            accessorySpacing: layout.rowAccessorySpacing
        )
    }
}
// swiftlint:enable one_declaration_per_file file_types_order
