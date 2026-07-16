@testable import MHUI
import SwiftUI
import Testing

struct MHPreviewStyleTests {
    @Test
    func preview_default_context_supplies_a_host_accent_example() {
        let context = MHPreviewStyle.context()
        let theme = MHPreviewStyle.theme(for: context)

        #expect(context.glassPolicy == .automatic)
        #expect(context.title.contains("Glass Auto"))
        #expect(theme.colors.accent == MHPreviewStyle.sampleHostAccent)
        #expect(theme.colors.onAccent == MHPreviewStyle.sampleHostOnAccent)
    }

    @Test
    func preview_context_tracks_glass_control_size_and_enabled_state() {
        let context = MHPreviewStyle.context(
            colorMode: .dark,
            glassPolicy: .enabled,
            typeScale: .accessibility,
            controlSize: .small,
            isEnabled: false
        )

        #expect(context.colorMode == .dark)
        #expect(context.glassPolicy == .enabled)
        #expect(context.typeScale == .accessibility)
        #expect(context.controlSize == .small)
        #expect(!context.isEnabled)
    }

    @Test
    func preview_theme_stays_aligned_with_runtime_tokens() {
        let theme = MHPreviewStyle.theme(for: MHPreviewStyle.context())

        #expect(MHTheme.standard.colors.accent == .tint)
        #expect(theme.colors.accent == MHPreviewStyle.sampleHostAccent)
        #expect(theme.spacing.control == MHTheme.standard.spacing.control)
        #expect(theme.layout.screen.contentInsetHorizontal == MHTheme.standard.layout.screen.contentInsetHorizontal)
        #expect(
            theme.layout.screen.compactContentInsetHorizontal
                == MHTheme.standard.layout.screen.compactContentInsetHorizontal
        )
    }

    @Test
    func preview_scenario_counts_stay_explicit() {
        #expect(MHPreviewStyle.screenValidationScenarios().count == 7)
        #expect(MHPreviewStyle.actionValidationScenarios().count == 4)
        #expect(MHPreviewStyle.keyValueValidationScenarios().count == 4)
        #expect(MHPreviewStyle.nativeContainerValidationScenarios().count == 4)
    }

    @Test
    func preview_scenario_names_stay_canonical() {
        #expect(
            MHPreviewStyle.screenValidationScenarios().map(\.name)
                == [
                    "Regular",
                    "Phone",
                    "Phone Disabled",
                    "Glass Fallback Phone",
                    "Stress Phone",
                    "Largest Type Phone",
                    "Pointer Small Controls"
                ]
        )
        #expect(
            MHPreviewStyle.actionValidationScenarios().map(\.name)
                == ["Phone", "Stress Phone", "Dark Stress Phone", "Largest Type Phone"]
        )
        #expect(
            MHPreviewStyle.keyValueValidationScenarios().map(\.name)
                == ["Phone", "Stress Phone", "Dark Stress Phone", "Largest Type Phone"]
        )
        #expect(
            MHPreviewStyle.nativeContainerValidationScenarios().map(\.name)
                == ["Phone", "Dark Phone", "Largest Type Phone", "Pointer Small Controls"]
        )
    }

    @Test
    func preview_scenario_widths_stay_canonical() {
        #expect(
            widths(for: MHPreviewStyle.screenValidationScenarios())
                == [760, 375, 375, 375, 320, 320, 760]
        )
        #expect(
            widths(for: MHPreviewStyle.actionValidationScenarios())
                == [375, 320, 320, 320]
        )
        #expect(
            widths(for: MHPreviewStyle.keyValueValidationScenarios())
                == [375, 320, 320, 320]
        )
        #expect(
            widths(for: MHPreviewStyle.nativeContainerValidationScenarios())
                == [375, 375, 320, 760]
        )
    }

    @Test
    func preview_scenario_contexts_cover_accessibility_pointer_and_fallbacks() {
        #expect(
            MHPreviewStyle.screenValidationScenarios().contains { scenario in
                scenario.context.typeScale == .largestAccessibility
            }
        )
        #expect(
            MHPreviewStyle.screenValidationScenarios().contains { scenario in
                scenario.context.glassPolicy == .disabled
            }
        )
        #expect(
            MHPreviewStyle.actionValidationScenarios().contains { scenario in
                scenario.context.glassPolicy == .disabled
            }
        )
        #expect(
            MHPreviewStyle.keyValueValidationScenarios().contains { scenario in
                scenario.context.glassPolicy == .disabled
            }
        )
        #expect(
            MHPreviewStyle.nativeContainerValidationScenarios().contains { scenario in
                scenario.context.glassPolicy == .disabled
            }
        )
        #expect(
            MHPreviewStyle.nativeContainerValidationScenarios().map(\.context.colorMode)
                == [.light, .dark, .light, .light]
        )
        #expect(MHPreviewStyle.screenValidationScenarios().last?.context.controlSize == .small)
        #expect(MHPreviewStyle.nativeContainerValidationScenarios().last?.context.controlSize == .small)
    }

    @Test
    func preview_scenario_ids_are_stable_and_unique() {
        #expect(hasUniqueIDs(MHPreviewStyle.screenValidationScenarios()))
        #expect(hasUniqueIDs(MHPreviewStyle.actionValidationScenarios()))
        #expect(hasUniqueIDs(MHPreviewStyle.keyValueValidationScenarios()))
        #expect(hasUniqueIDs(MHPreviewStyle.nativeContainerValidationScenarios()))
    }
}

private func hasUniqueIDs(
    _ scenarios: [MHPreviewScenario]
) -> Bool {
    let ids = scenarios.map(\.id)

    return ids.count == Set(ids).count
}

private func widths(
    for scenarios: [MHPreviewScenario]
) -> [Int] {
    scenarios.map { scenario in
        Int(scenario.width.rounded())
    }
}
