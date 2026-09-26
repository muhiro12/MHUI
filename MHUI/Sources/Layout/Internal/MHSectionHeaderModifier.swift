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
        #if os(macOS)
        let rowInsets: EdgeInsets? = nil
        #else
        let inset = usesFormSurface
            ? 0
            : theme.resolvedRowChromeStyle(for: adaptiveLayoutContext).horizontalInset

        let rowInsets: EdgeInsets? = containerStyle == .content
            ? .init(top: 0, leading: inset, bottom: 0, trailing: inset)
            : nil
        #endif

        content
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, containerStyle != nil && usesFormSurface ? theme.spacing.control : 0)
            .padding(.bottom, containerStyle == nil ? 0 : theme.spacing.inline)
            .textCase(nil)
            .listRowInsets(rowInsets)
    }
}
