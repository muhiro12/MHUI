import SwiftUI

struct MHRowChromeModifier: ViewModifier {
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
    }
}
