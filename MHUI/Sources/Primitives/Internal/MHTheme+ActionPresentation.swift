import SwiftUI

extension MHTheme {
    private var singleLineIntrinsicActionPresentation: MHResolvedActionPresentation {
        .init(
            lineLimit: 1,
            usesFixedHorizontalSize: true,
            expandsHorizontally: false,
            alignment: .center,
            allowsTightening: true
        )
    }

    private var fullWidthLeadingActionPresentation: MHResolvedActionPresentation {
        .init(
            lineLimit: nil,
            usesFixedHorizontalSize: false,
            expandsHorizontally: true,
            alignment: .leading,
            allowsTightening: true
        )
    }

    func resolvedActionPresentation(
        _ presentation: MHActionPresentation,
        for context: MHAdaptiveLayoutContext
    ) -> MHResolvedActionPresentation {
        switch presentation {
        case .automatic:
            if context.isCompactWidth(threshold: layout.compactWidthThreshold) {
                fullWidthLeadingActionPresentation
            } else {
                singleLineIntrinsicActionPresentation
            }
        case .singleLineIntrinsic:
            singleLineIntrinsicActionPresentation
        case .fullWidth:
            .init(
                lineLimit: nil,
                usesFixedHorizontalSize: false,
                expandsHorizontally: true,
                alignment: .center,
                allowsTightening: true
            )
        case .fullWidthLeading:
            fullWidthLeadingActionPresentation
        }
    }
}
