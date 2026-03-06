# MHUI

MHUI is a small SwiftUI foundation for calm, tool-like sibling apps.
It is intentionally opinionated and intentionally narrow.

MHUI focuses on three layers:

- semantic visual tokens
- domain-independent primitive components
- light screen-composition patterns

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
The standard theme ships with a restrained warm orange accent so the package reads as MHUI even before an app applies its own styling.
Apps can keep that default, swap the accent back to `.tint`, or provide another semantic color through the existing `MHTheme` API.

Its design attitude is informed by calm, functional retail and editorial environments.
That influence is about atmosphere only: whitespace, flatter work surfaces, subtle accent placement, quieter but more authored typography, and practical composition.
MHUI must not copy their layouts, information architecture, or visual motifs directly.

## Public Building Blocks

- `MHTheme`, `MHTextRole`, `MHColorRole`
- `MHSurface`
- `MHActionButtonStyle`
- `MHListRow`
- `MHKeyValueRow`
- `MHBadge`
- `MHEmptyState`
- `mhInputChrome(state:)`
- `MHScreen`
- `MHSectionBlock`
- `MHRowGroup`

## Example

```swift
import MHUI
import SwiftUI

struct SettingsScreen: View {
    var body: some View {
        MHScreen(
            title: "Workspace",
            subtitle: "Shared rhythm and low-noise hierarchy."
        ) {
            MHSectionBlock(
                "Appearance",
                supporting: "Keep options grouped, calm, and practical."
            ) {
                MHRowGroup {
                    MHKeyValueRow("Theme", value: "Standard")
                    MHListRow(
                        "Surfaces",
                        subtitle: "Neutral containers that stay in the background."
                    ) {
                        MHBadge("quiet", style: .neutral)
                    }
                }
            }

            MHEmptyState(
                "No more groups",
                message: "Add the next section only when it improves clarity.",
                symbolSystemName: "square.grid.2x2"
            ) {
                Button("Review") {
                    // no-op
                }
                .buttonStyle(.init(role: .secondary))
            }
        }
    }
}
```

## Intentional Boundaries

MHUI does not currently provide:

- `List` or `Form` wrappers
- navigation shells
- validation engines
- search components
- async image components
- app-specific feature views

Those can be added later only if they strengthen the shared visual language without turning MHUI into a generic mega framework.
