import SwiftUI

struct MHActionGlassContainer<Content: View>: View {
    private let spacing: CGFloat
    private let content: Content

    @ViewBuilder var body: some View {
        if #available(iOS 26, macOS 26, watchOS 26, *) {
            GlassEffectContainer(spacing: spacing) {
                content
            }
        } else {
            content
        }
    }

    init(
        spacing: CGFloat,
        @ViewBuilder content: () -> Content
    ) {
        self.spacing = spacing
        self.content = content()
    }
}
