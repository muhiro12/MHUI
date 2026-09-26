import SwiftUI

struct MHNativeToggleStyle: ToggleStyle {
    @Environment(\.isEnabled)
    private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        Toggle(configuration)
            .toggleStyle(.automatic)
            .foregroundStyle(MHTextForegroundStyle(role: isEnabled ? .primaryText : .tertiaryText))
    }
}
