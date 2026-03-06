// swiftlint:disable type_contents_order
import SwiftUI

/// A grouped row container with optional dividers.
public struct MHRowGroup<Content: View>: View {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.colorScheme)
    private var colorScheme

    private let showsDividers: Bool
    private let content: Content

    public init(
        showsDividers: Bool = true,
        @ViewBuilder content: () -> Content
    ) {
        self.showsDividers = showsDividers
        self.content = content()
    }

    public var body: some View {
        Group(subviews: content) { subviews in
            VStack(alignment: .leading, spacing: 0) {
                if let lastIndex = subviews.indices.last {
                    ForEach(subviews.indices, id: \.self) { index in
                        subviews[index]
                            .frame(maxWidth: .infinity, alignment: .leading)

                        if index != lastIndex {
                            if showsDividers {
                                Rectangle()
                                    .fill(
                                        theme.resolvedColor(
                                            for: .border,
                                            in: colorScheme
                                        )
                                        .opacity(theme.divider.opacity)
                                    )
                                    .frame(height: theme.divider.thickness)
                                    .padding(.leading, theme.spacing.group + theme.spacing.inline)
                            } else {
                                Color.clear
                                    .frame(height: theme.spacing.control)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview("Row Group", traits: .sizeThatFitsLayout) {
    MHSurface {
        MHRowGroup {
            MHListRow("Tokens", subtitle: "Neutral color roles and typography.")
            MHListRow("Patterns", subtitle: "Screen and section composition.")
            MHKeyValueRow("Readability", value: "Centered")
        }
    }
    .mhPreviewSurface()
}
// swiftlint:enable type_contents_order
