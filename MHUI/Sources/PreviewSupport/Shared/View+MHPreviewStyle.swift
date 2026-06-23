import SwiftUI

extension View {
    func mhPreviewTint(
        _ context: MHPreviewContext
    ) -> some View {
        modifier(
            MHPreviewContextModifier(
                context: context,
                padding: nil,
                showsBackground: false
            )
        )
    }

    func mhPreviewTint() -> some View {
        mhPreviewTint(MHPreviewStyle.defaultContext)
    }

    func mhPreviewSurface(
        _ context: MHPreviewContext,
        padding: CGFloat
    ) -> some View {
        modifier(
            MHPreviewContextModifier(
                context: context,
                padding: padding,
                showsBackground: true
            )
        )
    }

    func mhPreviewSurface(
        padding: CGFloat
    ) -> some View {
        mhPreviewSurface(
            MHPreviewStyle.defaultContext,
            padding: padding
        )
    }

    func mhPreviewSurface() -> some View {
        mhPreviewSurface(
            MHPreviewStyle.defaultContext,
            padding: MHTheme.standard.spacing.content
        )
    }
}
