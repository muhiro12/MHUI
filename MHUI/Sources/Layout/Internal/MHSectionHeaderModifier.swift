import SwiftUI

struct MHSectionHeaderModifier: ViewModifier {
    @Environment(\.mhUsesFormSurface)
    private var usesFormSurface
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.mhContainerStyle)
    private var containerStyle
    @Environment(\.mhAdaptiveLayoutContext)
    private var adaptiveLayoutContext

    func body(content: Content) -> some View {
        let inset = usesFormSurface
            ? 0
            : theme.resolvedRowChromeStyle(for: adaptiveLayoutContext).horizontalInset

        content
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, usesFormSurface ? theme.spacing.control : 0)
            .padding(.bottom, theme.spacing.inline)
            .textCase(nil)
            .listRowInsets(
                containerStyle == .content
                    ? .init(top: 0, leading: inset, bottom: 0, trailing: inset)
                    : nil
            )
    }
}
