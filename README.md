# MHUI

MHUI is a small SwiftUI foundation for calm, tool-like sibling apps.
It is intentionally opinionated and intentionally narrow.

MHUI focuses on three layers:

- semantic visual tokens
- styling primitives and modifiers
- screen and native-container chrome

It does not own app business logic, app models, logging, configuration, or infrastructure concerns.
Those responsibilities stay outside the package.

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
- `MHMaterialPolicy`, `mhMaterialPolicy(_:)`
- `MHActionButtonStyle` and `ButtonStyle` sugar like `.mhPrimary`
- `mhSurface(role:)` and `mhSurfaceInset()`
- `mhInputChrome(state:)`
- `mhBadge(style:)`
- `mhRow()`, `mhRowOverline()`, `mhRowTitle()`, `mhRowSupporting()`, `mhRowValue()`
- `LabeledContentStyle.mhKeyValue`
- `mhGroupedRows()`
- `mhSectionHeader()`, `mhSectionHeaderTitle()`, `mhSectionHeaderSupporting()`, `mhSectionFooterText()`
- `mhSection(...)`
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
