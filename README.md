# MHUI

## Overview

MHUI is a narrow runtime presentation kit for calm, tool-like sibling apps.
It is intentionally opinionated and intentionally small.
The repository also exposes `MHDesign`, a smaller metrics layer for apps that need the shared spacing, radius, and layout baseline without adopting MHUI chrome.
`MHDesign` includes a SwiftUI environment bridge so apps and MHUI components can share one active metrics subtree.
`MHUI` is the styled layer built on top of `MHDesign` and re-exports it for styled adopters.

MHUI focuses on three layers:

- semantic visual tokens
- styling primitives and modifiers
- screen and native-container chrome with compact-width fallback behavior

It does not own app business logic, app models, navigation meaning, logging, configuration, or infrastructure concerns.
Those responsibilities stay outside the package.

## MHUI Owns

- semantic theme application through `MHTheme.standard()` and `MHTheme.standard(accent:)`
- text, surface, row, section, screen, and native-container chrome
- width-adaptive action presentation and action-group fallback
- key-value row fallback behavior for narrow or constrained widths
- package-owned validation previews and package tests that prove those shared rules

## MHUI Does Not Own

- art-direction presets or app branding systems
- low-level glass choreography beyond `MHGlassPolicy` readability fallback
- replacement controls for native SwiftUI views
- feature-specific wrappers, domain models, or product-specific screen shells
- preview-only abstractions that host apps would need to import

## Repository Layout

- `Sources/MHDesign` - shared spacing, radius, and layout metrics for sibling apps
- `Sources/MHUI` - shared styled presentation APIs built on `MHDesign`
- `Tests/MHUITests` - package verification surface
- `ci_scripts/` - stable build, test, and verify entrypoints
- `Designs/` - architecture notes, current overview, and ADRs
- `Example/` - optional consumer app used only when present for integration review

## Adoption Paths

- Metrics-only adopter: `import MHDesign`
- Styled adopter: `import MHUI`

Use `MHDesign` directly when an app wants to avoid MHUI chrome and only share spacing, radius, layout, and the environment bridge.
Use `MHUI` when an app wants the styled layer. `MHUI` re-exports `MHDesign`, so one import is enough for both the metrics layer and the styled APIs.

## Design Direction

MHUI aims for a quiet interface:

- restrained color
- generous spacing
- low-noise surfaces
- clear text hierarchy
- stable composition rules

The default theme uses system typography, but its distinctiveness comes from hierarchy, spacing, geometry, and surface language rather than from stock SwiftUI control styling.
Apps can override the theme via `mhTheme(_:)`, but the customization surface is intentionally small.
MHUI should feel native first and refined second: interaction patterns stay close to SwiftUI defaults, while spacing, proportion, and surface treatment provide the package's personality.
The standard theme is built from achromatic neutrals plus the host app's tint color.
If a host app needs a fixed accent for a specific surface review, use `MHTheme.standard(accent: .fixed(...))`.
Detached surfaces prefer Liquid Glass by default through `mhGlassPolicy(.automatic)`.
That policy exists as a runtime readability switch, not as a low-level glass choreography API.
Compact width tuning lives in the shared theme defaults and internal resolvers so host apps do not need local fallback workarounds for common rows and actions.

Its design attitude is informed by calm, functional retail and editorial environments.
That influence is about atmosphere only: whitespace, calmer typography, subtle structural accent placement, and practical composition.
MHUI must not copy their layouts, information architecture, or visual motifs directly.

## Public Building Blocks

- `MHDesignMetrics`, `MHSpacingMetrics`, `MHRadiusMetrics`, `MHLayoutMetrics`
- `mhDesignMetrics(_:)` and `@Environment(\.mhDesignMetrics)`
- `MHTheme`, `MHColorReference`, `MHTextRole`, `MHColorRole`
- `mhTextStyle(_:colorRole:)`
- `MHGlassPolicy`, `mhGlassPolicy(_:)`
- `MHActionButtonStyle` and `ButtonStyle` sugar like `.mhPrimary`
- `MHActionPresentation`, `mhActionPresentation(_:)`
- `mhSurface(role:)` and `mhSurfaceInset()`
- `mhInputChrome(state:)`
- `mhBadge(style:)`
- `mhRow()`, `mhRowOverline()`, `mhRowTitle()`, `mhRowSupporting()`, `mhRowValue()`
- `MHKeyValueLayoutPolicy`, `mhKeyValueLayout(_:)`, `LabeledContentStyle.mhKeyValue`
- `mhGroupedRows()`
- `mhSectionHeader()`, `mhSectionHeaderTitle()`, `mhSectionHeaderSupporting()`, `mhSectionFooterText()`
- `mhSection(...)`
- `MHActionGroup`, `MHActionGroupLayout`
- `mhScreen(...)`
- `mhListChrome(...)`, `mhFormChrome(...)`
- `mhEmptyStateLayout()`

## Example

```swift
import MHUI
import SwiftUI

struct SettingsScreen: View {
    @Environment(\.mhDesignMetrics)
    private var metrics

    var body: some View {
        NavigationStack {
            List {
                Section {
                    Toggle("Use iCloud Sync", isOn: .constant(true))
                        .mhRow()

                    LabeledContent("Theme", value: "System")
                        .labeledContentStyle(.mhKeyValue)
                } header: {
                    VStack(alignment: .leading, spacing: metrics.spacing.control) {
                        Text("Preferences")
                            .mhSectionHeaderTitle()
                        Text("Standard controls keep their native behavior.")
                            .mhSectionHeaderSupporting()
                    }
                    .mhSectionHeader()
                } footer: {
                    Text("MHUI styles the layout, surfaces, and hierarchy around the controls.")
                        .mhSectionFooterText()
                }
            }
            .mhListChrome(
                title: "Workspace",
                subtitle: "Shared rhythm and low-noise hierarchy."
            )
        }
        .tint(.blue)
        .mhTheme(MHTheme.standard())
    }
}
```

If a sibling app does not want MHUI modifiers or chrome, import `MHDesign` directly and read `@Environment(\.mhDesignMetrics)`.
If a sibling app wants MHUI styling, import `MHUI` and use both `MHTheme` and `MHDesign` APIs from that one module.
Apply `.mhDesignMetrics(...)` when a subtree needs layout-only overrides. MHUI components follow the same active metrics automatically.

Use `mhScreen(...)` and `mhSection(...)` when a screen should be composed from stacks and calm card-like surfaces instead of a native `List` or `Form`.

## Where To Tune First

Start in this order when adjusting appearance:

1. `MHDesignMetrics.standard` when an app only needs shared spacing, radius, or layout numbers.
2. `MHTheme.standard()` or `MHTheme.standard(accent:)` for default color, spacing, radius, layout, and surface recipes.
3. Validation previews at fixed widths `760`, `375`, and `320` before making view-local tweaks.
4. Internal shared resolvers for row chrome, surface fill, action fallback, and key-value fallback only when a shared token is not enough.

The most useful previews to review first are `Screen Validation`, `Action Buttons Validation`, `Action Group Validation`, `Key Value Validation`, and `Native Container Validation`.

## Intentional Boundaries

MHUI does not currently provide:

- replacement controls that shadow `Button`, `TextField`, `Toggle`, or `List`
- navigation shells
- validation engines
- search components
- async image components
- art-direction preset collections
- low-level glass choreography APIs
- app-specific feature views

Those can be added later only if they strengthen the shared visual language without turning MHUI into a generic mega framework.

## Requirements

- Xcode 16 or later with the iOS 18 and macOS 15 SDKs installed
- Swift 6.2 toolchain
- `swiftlint` installed if you want to run the standardized verify pipeline
- `pre-commit` installed if you want `verify.sh` to execute repository hooks

## Build and Test

Use the helper scripts in `ci_scripts/` as needed.
For full local verification:

```sh
bash ci_scripts/tasks/verify.sh
```

If you only need required checks based on local changes:

```sh
bash ci_scripts/tasks/run_required_builds.sh
```

If you only need the repository hooks:

```sh
bash ci_scripts/tasks/pre_commit.sh
```

If you only need the package and optional example app build:

```sh
bash ci_scripts/tasks/build_app.sh
```

If you only need Swift package tests:

```sh
bash ci_scripts/tasks/test_shared_library.sh
```

### CI Artifact Layout

CI helper scripts write generated artifacts under `.build/ci/`.
Run-scoped outputs are stored in `.build/ci/runs/<RUN_ID>/` and include `summary.md`, `commands.txt`, `meta.json`, `logs/`, `results/`, and `work/`.
Shared caches and build state live in `.build/ci/shared/` under `cache/`, `DerivedData/`, `tmp/`, and `home/`.

## Architecture Docs

- [Current repository overview](Designs/Overviews/mhui-current-overview.md)
- [Architecture guide](Designs/Architecture/ARCHITECTURE_GUIDE.md)
- [Shared presentation design](Designs/Architecture/shared-presentation-design.md)
- [ADR 0001: Shared package source of truth](Designs/Decisions/0001-shared-package-source-of-truth.md)
- [ADR 0002: Host apps own product behavior](Designs/Decisions/0002-host-apps-own-product-behavior.md)
- [ADR 0003: Example integrations stay outside package](Designs/Decisions/0003-example-integrations-stay-outside-package.md)
- [ADR 0004: Host screens own product meaning](Designs/Decisions/0004-host-screens-own-product-meaning.md)
