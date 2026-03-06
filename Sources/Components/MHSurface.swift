// swiftlint:disable type_contents_order
import SwiftUI

/// Calm rounded surface for grouped content.
public struct MHSurface<Content: View>: View {
    @Environment(\.mhTheme)
    private var theme
    @Environment(\.colorScheme)
    private var colorScheme

    private let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.group) {
            content
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, theme.spacing.group)
        .padding(.vertical, theme.spacing.group + theme.spacing.inline)
        .background(
            theme.resolvedColor(for: .surface, in: colorScheme),
            in: RoundedRectangle(
                cornerRadius: theme.radius.surface,
                style: .continuous
            )
        )
        .overlay {
            RoundedRectangle(
                cornerRadius: theme.radius.surface,
                style: .continuous
            )
            .stroke(
                theme.resolvedColor(for: .border, in: colorScheme)
                    .opacity(theme.divider.opacity),
                lineWidth: theme.divider.thickness
            )
        }
    }
}

#Preview("Surface", traits: .sizeThatFitsLayout) {
    ScrollView {
        MHSurface {
            Text("Calm Surface")
                .mhTextStyle(.sectionTitle)
            Text("Used for grouped settings, cards, and empty states.")
                .mhTextStyle(.supporting, colorRole: .secondaryText)
        }
        .padding()
    }
    .background(MHTheme.standard.colorReference(for: .background).resolve(for: .light))
}
// swiftlint:enable type_contents_order
