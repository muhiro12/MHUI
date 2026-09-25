import SwiftUI

struct MHSectionHeaderModifier: ViewModifier {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.mhContainerStyle)
    private var containerStyle
    @Environment(\.mhAdaptiveLayoutContext)
    private var adaptiveLayoutContext

    func body(content: Content) -> some View {
        let inset = theme.resolvedRowChromeStyle(for: adaptiveLayoutContext).horizontalInset

        content
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, theme.spacing.inline)
            .textCase(nil)
            .listRowInsets(
                containerStyle == .content
                    ? .init(top: 0, leading: inset, bottom: 0, trailing: inset)
                    : nil
            )
    }
}
