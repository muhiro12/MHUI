// swiftlint:disable one_declaration_per_file file_types_order
import SwiftUI

// Shared list row insets and padding live here so previews and labeled rows stay aligned.
struct MHResolvedRowChromeStyle: Sendable, Equatable {
    var verticalPadding: CGFloat
    var horizontalInset: CGFloat
    var accessorySpacing: CGFloat
    var minimumHeight: CGFloat
}

private struct MHRowChromeModifier: ViewModifier {
    let style: MHResolvedRowChromeStyle

    func body(content: Content) -> some View {
        content
            .padding(.vertical, style.verticalPadding)
            .frame(
                maxWidth: .infinity,
                minHeight: style.minimumHeight,
                alignment: .leading
            )
            .contentShape(.rect)
            .listRowInsets(
                .init(
                    top: 0,
                    leading: style.horizontalInset,
                    bottom: 0,
                    trailing: style.horizontalInset
                )
            )
            .mhListRowSeparatorHidden()
            .listRowBackground(Color.clear)
    }
}

private extension View {
    @ViewBuilder
    func mhListRowSeparatorHidden() -> some View {
        #if os(watchOS)
        self
        #else
        listRowSeparator(.hidden)
        #endif
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
                ? presentation.compactRowVerticalPadding
                : presentation.rowVerticalPadding,
            horizontalInset: isCompactWidth
                ? presentation.compactRowHorizontalInset
                : presentation.rowHorizontalInset,
            accessorySpacing: isCompactWidth
                ? presentation.compactRowAccessorySpacing
                : presentation.rowAccessorySpacing,
            minimumHeight: layout.control.minimumTouchTarget
        )
    }

    func resolvedRowChromeStyle() -> MHResolvedRowChromeStyle {
        resolvedRowChromeStyle(for: .init())
    }
}
// swiftlint:enable one_declaration_per_file file_types_order
