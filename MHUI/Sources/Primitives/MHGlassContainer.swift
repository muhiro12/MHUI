import SwiftUI

/// Groups nearby glass-rendered items so the system can coordinate their presentation.
struct MHGlassContainer<Content: View>: View {
    private let spacing: CGFloat?
    private let content: Content

    @ViewBuilder var body: some View {
        if #available(iOS 26, macOS 26, watchOS 26, *) {
            if let spacing {
                GlassEffectContainer(spacing: spacing) {
                    content
                }
            } else {
                GlassEffectContainer {
                    content
                }
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

    init(
        @ViewBuilder content: () -> Content
    ) {
        self.spacing = nil
        self.content = content()
    }
}
