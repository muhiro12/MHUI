import MHUI
import SwiftUI

/// Tests image-shaped content without external assets or network requests.
struct MHUIVisualContentSample: View {
    private let imageWidth: CGFloat = 4
    private let imageHeight: CGFloat = 3

    @Environment(\.mhTheme)
    private var theme

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.screen) {
            MHFeatureGrid {
                placeholder
            } supporting: {
                MHSummary(
                    "Objects worth keeping",
                    metadata: "Visual notes",
                    supporting: "An image can be unavailable while its context remains useful."
                )
                Text("The caption stays with the image as the available width changes.")
                    .mhTextStyle(.supporting, colorRole: .secondaryText)
            }

            reading
        }
        .mhScreen("Visual notes", subtitle: "Content first, including when an image cannot load.")
    }

    private var reading: some View {
        VStack(alignment: .leading, spacing: theme.spacing.content) {
            Text("A clear place for the content")
                .mhTextStyle(.summaryTitle)
            Text(
                """
                Photographs, diagrams, and documents carry their own character. The surrounding \
                interface gives them room, keeps their captions nearby, and preserves a readable \
                order when columns become a single stack.
                """
            )
            .mhTextStyle(.body)
            Text(
                """
                日々の記録を、あとから読み返しやすい形に。幅が狭くなっても、写真の説明と本文の関係を保ち、\
                長い日本語の見出しや補足文を途中で切らずに表示します。
                """
            )
            .mhTextStyle(.body)
        }
        .mhSection("Reading", supporting: "Text and imagery share the same canvas.")
    }

    private var placeholder: some View {
        Color.clear
            .aspectRatio(imageWidth / imageHeight, contentMode: .fit)
            .overlay {
                VStack(spacing: theme.spacing.inline) {
                    Image(systemName: "photo")
                        .font(.largeTitle)
                        .accessibilityHidden(true)
                    Text("Image unavailable")
                        .mhTextStyle(.caption)
                }
                .mhForegroundStyle(.secondaryText)
                .padding(theme.spacing.content)
            }
            .mhSurface(role: .muted)
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Image unavailable")
    }
}
