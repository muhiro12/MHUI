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
    func resolvedRowChromeStyle(
        for context: MHAdaptiveLayoutContext
    ) -> MHResolvedRowChromeStyle {
        let isCompactWidth = context.isCompactWidth(
            threshold: layout.compactWidthThreshold
        )

        return .init(
            verticalPadding: isCompactWidth
                ? layout.compactRowVerticalPadding
                : layout.rowVerticalPadding,
            horizontalInset: isCompactWidth
                ? layout.compactRowHorizontalInset
                : layout.rowHorizontalInset,
            accessorySpacing: isCompactWidth
                ? layout.compactRowAccessorySpacing
                : layout.rowAccessorySpacing
        )
    }

    func resolvedRowChromeStyle() -> MHResolvedRowChromeStyle {
        resolvedRowChromeStyle(for: .init())
    }
}
// swiftlint:enable one_declaration_per_file file_types_order
