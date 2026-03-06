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

The default theme uses system typography, neutral surfaces, and tint-driven emphasis.
Apps can override the theme via `mhTheme(_:)`, but the customization surface is intentionally small.

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
            title: "Settings",
            subtitle: "Shared rhythm and quiet hierarchy."
        ) {
            MHSectionBlock(
                "Interface",
                supporting: "Keep options grouped and readable."
            ) {
                MHRowGroup {
                    MHKeyValueRow("Theme", value: "Standard")
                    MHListRow(
                        "Appearance",
                        subtitle: "Open a deeper customization screen."
                    ) {
                        Image(systemName: "paintpalette")
                            .foregroundStyle(.accent)
                    }
                }
            }

            MHEmptyState(
                "No more sections",
                message: "Add more grouped content as the screen grows.",
                symbolSystemName: "square.stack.3d.up"
            ) {
                Button("Done") {
                    // no-op
                }
                .buttonStyle(.init(role: .primary))
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
