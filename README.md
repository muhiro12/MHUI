# MHUI

## Overview

MHUI is a small SwiftUI foundation for calm, tool-like sibling apps.
It is intentionally opinionated and intentionally narrow.

MHUI focuses on three layers:

- semantic visual tokens
- styling primitives and modifiers
- screen and native-container chrome

It does not own app business logic, app models, logging, configuration, or infrastructure concerns.
Those responsibilities stay outside the package.

## Repository Layout

- `Sources/MHUI` - shared package source of truth for reusable presentation APIs
- `Tests/MHUITests` - package verification surface
- `ci_scripts/` - stable build, test, and verify entrypoints
- `Designs/` - architecture notes, current overview, and ADRs
- `Example/` - optional consumer app used only when present for integration review

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
Apps can still choose a preset accent through `MHTheme.standard(accentStyle:)` or override `colors.accent` directly.
Grouped surfaces stay solid by default.
Material recipes are available through `mhMaterialPolicy(.enabled)` and still fall back to solid theme colors when transparency should be reduced.
Preview baselines follow the same host-tint default as runtime usage, while built-in accent comparisons live in explicit review scenarios.

Its design attitude is informed by calm, functional retail and editorial environments.
That influence is about atmosphere only: whitespace, calmer typography, subtle structural accent placement, and practical composition.
MHUI must not copy their layouts, information architecture, or visual motifs directly.

## Public Building Blocks

- `MHTheme`, `MHAccentStyle`, `MHTextRole`, `MHColorRole`
- `MHFontStyle`, `MHFontWeight`, `MHTextMetrics`, `mhTextStyle(_:colorRole:)`
- `MHMaterialPolicy`, `mhMaterialPolicy(_:)`
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
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Toggle("Use iCloud Sync", isOn: .constant(true))
                        .mhRow()

                    LabeledContent("Theme", value: "System")
                        .labeledContentStyle(.mhKeyValue)
                } header: {
                    VStack(alignment: .leading, spacing: MHTheme.standard.spacing.control) {
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

Use `mhScreen(...)` and `mhSection(...)` when a screen should be composed from stacks and calm card-like surfaces instead of a native `List` or `Form`.

## Where To Tune First

Start in this order when adjusting appearance:

1. `MHTheme.standard()` for default color, spacing, radius, layout, and surface recipes.
2. `MHPreviewStyle` and the shared preview catalogs for host tint, accent, material, native container, density, and dynamic type comparisons.
3. Internal shared resolvers for row chrome, surface fill, and cue chrome only when a shared token is not enough.

The most useful previews to review first are `Foundation Catalog`, `Material Review`, `Accent Review`, and `Native Container Review`.

## Intentional Boundaries

MHUI does not currently provide:

- wrapper controls that replace `Button`, `TextField`, `Toggle`, or `List`
- navigation shells
- validation engines
- search components
- async image components
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
