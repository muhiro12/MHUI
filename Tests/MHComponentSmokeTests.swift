// swiftlint:disable closure_body_length
@testable import MHUI
import SwiftUI
import Testing

struct MHComponentSmokeTests {
    @Test
    @MainActor
    func public_styles_and_modifiers_instantiate() {
        let smokeView = AnyView(
            VStack(alignment: .leading, spacing: MHTheme.standard.spacing.section) {
                VStack(spacing: 0) {
                    HStack(alignment: .top, spacing: MHTheme.standard.spacing.control) {
                        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.inline) {
                            Text("Foundation")
                                .mhRowOverline()
                            Text("Tokens")
                                .mhRowTitle()
                            Text("Typography and spacing")
                                .mhRowSupporting()
                        }
                        Spacer()
                        Text("Quiet")
                            .mhRowValue()
                    }
                    .mhRow()

                    LabeledContent("Theme", value: "Standard")
                        .labeledContentStyle(.mhKeyValue)
                }
                .mhGroupedRows()
                .mhSection("Section")

                HStack(spacing: MHTheme.standard.spacing.control) {
                    Text("Accent")
                        .mhBadge(style: .accent)
                    Text("Quiet")
                        .mhBadge(style: .neutral)
                }
                .mhSurfaceInset()
                .mhSurface()

                ContentUnavailableView(
                    "Empty",
                    systemImage: "tray",
                    description: Text("No content")
                )
                .mhEmptyStateLayout()
                .mhSurfaceInset()
                .mhSurface(role: .muted)

                TextField("Name", text: .constant(""))
                    .mhInputChrome(state: .focused)

                Button("Create") {
                    // no-op
                }
                    .buttonStyle(.mhSecondary)
            }
            .mhScreen(
                title: "Foundation",
                subtitle: "Quiet composition"
            )
        )

        #expect(!String(reflecting: type(of: smokeView)).isEmpty)
    }
}
// swiftlint:enable closure_body_length
