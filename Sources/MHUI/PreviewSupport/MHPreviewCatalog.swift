// swiftlint:disable function_default_parameter_at_end no_magic_numbers
import SwiftUI

/// Tune validation scenarios here before changing package fallback behavior.
struct MHPreviewCatalog<Content: View>: View {
    private static var labelOpacity: Double {
        0.68
    }

    @Environment(\.colorScheme)
    private var colorScheme

    let title: String?
    let scenarios: [MHPreviewScenario]
    let casePadding: CGFloat
    let content: (MHPreviewContext) -> Content

    private var labelColor: Color {
        MHColorToken(
            light: .init(hex: 0x212124, opacity: Self.labelOpacity),
            dark: .init(hex: 0xEBEBED, opacity: Self.labelOpacity)
        )
        .resolve(for: colorScheme)
    }

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
                            .font(.footnote.weight(.medium))
                            .foregroundStyle(labelColor)

                        content(scenario.context)
                            .frame(width: scenario.width, alignment: .leading)
                            .mhPreviewSurface(
                                scenario.context,
                                padding: casePadding
                            )
                            .clipShape(
                                RoundedRectangle(
                                    cornerRadius: MHTheme.standard.radius.surface,
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
        title: String? = nil,
        scenarios: [MHPreviewScenario],
        casePadding: CGFloat = MHTheme.standard.spacing.group,
        @ViewBuilder content: @escaping (MHPreviewContext) -> Content
    ) {
        self.title = title
        self.scenarios = scenarios
        self.casePadding = casePadding
        self.content = content
    }
}
// swiftlint:enable function_default_parameter_at_end no_magic_numbers
