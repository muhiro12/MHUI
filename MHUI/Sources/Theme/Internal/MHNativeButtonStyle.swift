import SwiftUI

struct MHNativeButtonStyle: PrimitiveButtonStyle {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.colorScheme)
    private var colorScheme

    func makeBody(configuration: Configuration) -> some View {
        Button(configuration)
            .buttonStyle(.automatic)
            .foregroundStyle(
                theme.resolvedColor(
                    for: configuration.role == .destructive
                        ? .destructive
                        : .accent,
                    in: colorScheme
                )
            )
    }
}
