@testable import MHUI
import Testing

struct MHPreviewStyleTests {
    @Test
    func preview_default_context_matches_runtime_accent_baseline() {
        let context = MHPreviewStyle.context()
        let theme = MHPreviewStyle.theme(for: context)

        #expect(context.glassPolicy == .automatic)
        #expect(context.title.contains("Glass Auto"))
        #expect(theme.colors.accent == .tint)
    }

    @Test
    func preview_context_tracks_glass_and_enabled_state() {
        let context = MHPreviewStyle.context(
            colorMode: .dark,
            glassPolicy: .enabled,
            typeScale: .accessibility,
            isEnabled: false
        )

        #expect(context.colorMode == .dark)
        #expect(context.glassPolicy == .enabled)
        #expect(context.typeScale == .accessibility)
        #expect(!context.isEnabled)
    }

    @Test
    func preview_theme_stays_aligned_with_runtime_tokens() {
        let theme = MHPreviewStyle.theme(for: MHPreviewStyle.context())

        #expect(theme.colors.accent == .tint)
        #expect(theme.spacing.control == MHTheme.standard.spacing.control)
        #expect(theme.layout.screen.contentInsetHorizontal == MHTheme.standard.layout.screen.contentInsetHorizontal)
        #expect(
            theme.layout.screen.compactContentInsetHorizontal
                == MHTheme.standard.layout.screen.compactContentInsetHorizontal
        )
    }

    @Test
    func preview_scenarios_stay_explicit_and_canonical() {
        #expect(MHPreviewStyle.screenValidationScenarios().count == 5)
        #expect(MHPreviewStyle.actionValidationScenarios().count == 4)
        #expect(MHPreviewStyle.keyValueValidationScenarios().count == 4)
        #expect(
            MHPreviewStyle.screenValidationScenarios().map(\.name)
                == [
                    "Regular",
                    "Phone",
                    "Phone Disabled",
                    "Stress Phone",
                    "Largest Type Phone"
                ]
        )
        #expect(
            MHPreviewStyle.actionValidationScenarios().map(\.name)
                == [
                    "Phone",
                    "Stress Phone",
                    "Dark Stress Phone",
                    "Largest Type Phone"
                ]
        )
        #expect(
            MHPreviewStyle.keyValueValidationScenarios().map(\.name)
                == [
                    "Phone",
                    "Stress Phone",
                    "Dark Stress Phone",
                    "Largest Type Phone"
                ]
        )
        #expect(
            MHPreviewStyle.nativeContainerValidationScenarios().map(\.name)
                == ["Phone", "Dark Phone", "Largest Type Phone"]
        )
        #expect(
            MHPreviewStyle.nativeContainerValidationScenarios().map(\.context.colorMode)
                == [.light, .dark, .light]
        )
        #expect(
            MHPreviewStyle.screenValidationScenarios().map { scenario in
                Int(scenario.width.rounded())
            }
                == [760, 375, 375, 320, 320]
        )
        #expect(
            MHPreviewStyle.actionValidationScenarios().map { scenario in
                Int(scenario.width.rounded())
            }
                == [375, 320, 320, 320]
        )
        #expect(
            MHPreviewStyle.keyValueValidationScenarios().map { scenario in
                Int(scenario.width.rounded())
            }
                == [375, 320, 320, 320]
        )
        #expect(
            MHPreviewStyle.nativeContainerValidationScenarios().map { scenario in
                Int(scenario.width.rounded())
            }
                == [375, 375, 320]
        )
        #expect(
            MHPreviewStyle.screenValidationScenarios().last?.context.typeScale
                == .largestAccessibility
        )
    }
}
