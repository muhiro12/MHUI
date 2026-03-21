import SwiftUI

/// Groups nearby glass-rendered items so the system can coordinate their presentation.
public struct MHGlassContainer<Content: View>: View {
    private let spacing: CGFloat?
    private let content: Content

    @ViewBuilder public var body: some View {
        if #available(iOS 26, macOS 26, *) {
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

    public init(
        spacing: CGFloat? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.spacing = spacing
        self.content = content()
    }
}
