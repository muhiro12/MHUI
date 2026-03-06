# MHUI

MHUI is a small SwiftUI foundation for calm, tool-like sibling apps.
It is intentionally opinionated and intentionally narrow.

MHUI focuses on three layers:

- semantic visual tokens
- styling primitives and modifiers
- light screen-composition support

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
The standard theme is built from achromatic neutrals plus a selectable vivid accent.
The default accent is orange, and apps can choose another built-in accent through `MHTheme.standard(accentStyle:)`.
Apps can still override `colors.accent` directly or swap it back to `.tint` when needed.

Its design attitude is informed by calm, functional retail and editorial environments.
That influence is about atmosphere only: whitespace, calmer typography, subtle structural accent placement, and practical composition.
MHUI must not copy their layouts, information architecture, or visual motifs directly.

## Public Building Blocks

- `MHTheme`, `MHAccentStyle`, `MHTextRole`, `MHColorRole`
- `MHActionButtonStyle` and `ButtonStyle` sugar like `.mhPrimary`
- `mhSurface(role:)` and `mhSurfaceInset()`
- `mhInputChrome(state:)`
- `mhBadge(style:)`
- `mhRow()`, `mhRowOverline()`, `mhRowTitle()`, `mhRowSupporting()`, `mhRowValue()`
- `LabeledContentStyle.mhKeyValue`
- `mhGroupedRows()`
- `mhSection(...)`
- `mhScreen(...)`
- `mhEmptyStateLayout()`

## Example

```swift
import MHUI
import SwiftUI

struct SettingsScreen: View {
    var body: some View {
        VStack(alignment: .leading, spacing: MHTheme.standard.spacing.section) {
            VStack(spacing: 0) {
                LabeledContent("Theme", value: "Standard")
                    .labeledContentStyle(.mhKeyValue)

                HStack(alignment: .top, spacing: MHTheme.standard.spacing.control) {
                    VStack(alignment: .leading, spacing: MHTheme.standard.spacing.inline) {
                        Text("Foundation")
                            .mhRowOverline()
                        Text("Surfaces")
                            .mhRowTitle()
                        Text("Neutral containers that stay in the background.")
                            .mhRowSupporting()
                    }
                    Spacer()
                    Text("quiet")
                        .mhBadge(style: .neutral)
                }
                .mhRow()
            }
            .mhGroupedRows()
            .mhSection(
                "Appearance",
                supporting: "Keep options grouped, calm, and practical."
            )

            ContentUnavailableView(
                "No more groups",
                systemImage: "square.grid.2x2",
                description: Text("Add the next section only when it improves clarity.")
            )
            .mhEmptyStateLayout()
            .mhSurfaceInset()
            .mhSurface()

            Button("Review") {
                // no-op
            }
            .buttonStyle(.mhSecondary)
        }
        .mhScreen(
            title: "Workspace",
            subtitle: "Shared rhythm and low-noise hierarchy."
        )
        .mhTheme(MHTheme.standard(accentStyle: .blue))
    }
}
```

## Intentional Boundaries

MHUI does not currently provide:

- wrapper controls that replace `Button`, `TextField`, `Toggle`, or `List`
- navigation shells
- validation engines
- search components
- async image components
- app-specific feature views

Those can be added later only if they strengthen the shared visual language without turning MHUI into a generic mega framework.
