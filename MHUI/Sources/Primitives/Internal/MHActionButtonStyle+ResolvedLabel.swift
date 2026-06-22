import SwiftUI

extension MHActionButtonStyle {
    @ViewBuilder
    func resolvedLabel(
        for configuration: Configuration,
        presentation: MHResolvedActionPresentation
    ) -> some View {
        let label = configuration.label
            .lineLimit(presentation.lineLimit)
            .multilineTextAlignment(
                presentation.alignment == .leading
                    ? .leading
                    : .center
            )
            .truncationMode(.tail)
            .allowsTightening(presentation.allowsTightening)
            .fixedSize(
                horizontal: presentation.usesFixedHorizontalSize,
                vertical: false
            )
            .layoutPriority(1)

        if presentation.expandsHorizontally {
            label.frame(
                maxWidth: .infinity,
                alignment: presentation.alignment
            )
        } else {
            label
        }
    }
}
