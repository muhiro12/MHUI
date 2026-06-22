import SwiftUI

/// Tune validation scenarios here before changing package fallback behavior.
struct MHPreviewCatalog<Content: View>: View {
    let title: String?
    let scenarios: [MHPreviewScenario]
    let casePadding: CGFloat
    let caseHeight: CGFloat?
    let content: (MHPreviewContext) -> Content

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: MHTheme.standard.spacing.section) {
                if let title {
                    Text(title)
                        .font(.title3.weight(.semibold))
                }

                ForEach(scenarios) { scenario in
                    VStack(alignment: .leading, spacing: MHTheme.standard.spacing.control) {
                        Text(scenario.title)
                            .mhTextStyle(.caption, colorRole: .secondaryText)

                        scenarioContent(scenario)
                            .mhPreviewSurface(
                                scenario.context,
                                padding: casePadding
                            )
                            .clipShape(
                                RoundedRectangle(
                                    cornerRadius: MHTheme.standard.cornerRadius.surface,
                                    style: .continuous
                                )
                            )
                    }
                }
            }
            .padding(MHTheme.standard.spacing.screen)
        }
    }

    init(
        title: String?,
        scenarios: [MHPreviewScenario],
        casePadding: CGFloat,
        caseHeight: CGFloat?,
        @ViewBuilder content: @escaping (MHPreviewContext) -> Content
    ) {
        self.title = title
        self.scenarios = scenarios
        self.casePadding = casePadding
        self.caseHeight = caseHeight
        self.content = content
    }

    init(
        title: String?,
        scenarios: [MHPreviewScenario],
        @ViewBuilder content: @escaping (MHPreviewContext) -> Content
    ) {
        self.init(
            title: title,
            scenarios: scenarios,
            casePadding: MHTheme.standard.spacing.content,
            caseHeight: nil,
            content: content
        )
    }

    init(
        title: String?,
        scenarios: [MHPreviewScenario],
        caseHeight: CGFloat,
        @ViewBuilder content: @escaping (MHPreviewContext) -> Content
    ) {
        self.init(
            title: title,
            scenarios: scenarios,
            casePadding: MHTheme.standard.spacing.content,
            caseHeight: caseHeight,
            content: content
        )
    }

    init(
        title: String?,
        scenarios: [MHPreviewScenario],
        casePadding: CGFloat,
        @ViewBuilder content: @escaping (MHPreviewContext) -> Content
    ) {
        self.init(
            title: title,
            scenarios: scenarios,
            casePadding: casePadding,
            caseHeight: nil,
            content: content
        )
    }

    @ViewBuilder
    private func scenarioContent(
        _ scenario: MHPreviewScenario
    ) -> some View {
        if let caseHeight {
            content(scenario.context)
                .frame(
                    width: scenario.width,
                    height: caseHeight,
                    alignment: .topLeading
                )
        } else {
            content(scenario.context)
                .frame(width: scenario.width, alignment: .leading)
        }
    }
}
