import SwiftUI

struct MHNativeLabeledContentStyle: LabeledContentStyle {
    func makeBody(configuration: Configuration) -> some View {
        LabeledContent {
            configuration.content
                .foregroundStyle(MHTextForegroundStyle(role: .secondaryText))
        } label: {
            configuration.label
                .foregroundStyle(MHTextForegroundStyle(role: .primaryText))
        }
        .labeledContentStyle(.automatic)
    }
}
