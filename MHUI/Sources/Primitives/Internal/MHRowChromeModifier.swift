import SwiftUI

struct MHRowChromeModifier: ViewModifier {
    let style: MHResolvedRowChromeStyle
    let scope: MHRowChromeScope

    private var rowInsets: EdgeInsets? {
        #if os(macOS)
        nil
        #else
        .init(
            top: 0,
            leading: style.horizontalInset,
            bottom: 0,
            trailing: style.horizontalInset
        )
        #endif
    }

    func body(content: Content) -> some View {
        if scope == .grouped {
            content
        } else {
            content
                .padding(.vertical, style.verticalPadding)
                .frame(
                    maxWidth: .infinity,
                    minHeight: style.minimumHeight,
                    alignment: .leading
                )
                .contentShape(.rect)
                .listRowInsets(rowInsets)
        }
    }
}
