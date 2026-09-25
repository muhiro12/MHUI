import SwiftUI

struct MHContainerHeaderModifier: ViewModifier {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.mhAdaptiveLayoutContext)
    private var adaptiveLayoutContext
    @Environment(\.mhUsesFormSurface)
    private var usesFormSurface

    func body(content: Content) -> some View {
        #if os(macOS)
        content.textCase(nil)
        #else
        let inset = usesFormSurface
            ? 0
            : theme.resolvedRowChromeStyle(for: adaptiveLayoutContext).horizontalInset
        content
            .textCase(nil)
            .listRowInsets(.init(top: 0, leading: inset, bottom: 0, trailing: inset))
        #endif
    }
}
