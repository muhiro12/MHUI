# ADR 0006: Root Theme Propagation

- Date: 2026-07-16
- Last updated: 2026-09-26
- Status: Accepted

## Context

MHUI already carried an `MHTheme` value through SwiftUI's environment, but most
theme groups were package-internal. Adopters could select a standard theme and
change a small set of inputs, yet they could not define typography, semantic
surface colors, component presentation metrics, or surface treatments in one
app-owned configuration.

That gap encouraged either package changes for every visual adjustment or
repeated host-app modifiers. It also left the relationship between the MHUI
accent and native SwiftUI control tint implicit.

## Decision

`MHTheme` is the public, value-typed configuration for styled adopters. Its
semantic color, typography, design metric, presentation, divider, motion, and
surface groups are public and mutable. Apps normally copy `MHTheme.standard`,
change the values they own, and apply the result once near the app root with
`mhTheme(_:)`.

The modifier propagates the theme through SwiftUI's environment. The standard
theme uses `MHColorReference.tint`, which resolves the host app's `AccentColor`
asset without installing a native tint override. An explicitly configured
asset-backed accent also becomes the native-control tint within the same
subtree. `MHColorReference` accepts asset resources rather than RGB or
hexadecimal source values.

The root call supplies inheritable styling values to SwiftUI content.
Writing `mhTheme(_:)` also synchronizes the theme's
`MHDesignMetrics` with the lower-level metrics environment. A narrower
`mhTheme(_:)` call provides an intentional local override.

Views still select structural and semantic intent explicitly through MHUI text,
surface, row, button, and container APIs. MHUI does not infer roles from
arbitrary content, replace native controls, or install blanket root button,
font, foreground, list, and form styles. Such styles propagate into toolbars,
menus, system presentations, and controls whose meaning cannot be known at the
app root. A root modifier also cannot rewrite an unknown descendant hierarchy
to insert signature screen, section, or grouped-row structure.

## Application-Wide Navigation Titles

On iOS, the host can call `configureNavigationTitleAppearance()` once during
app initialization, before creating navigation bars. This explicit startup
operation sets the native large and inline title foreground to the theme's
primary text color. It does not change backgrounds, fonts, or button tint.

This is a UIKit appearance default across the app, including `.native` screens.
It is separate from `mhTheme(_:)`, which remains a subtree environment write.
Local themes do not reconfigure it, and explicit per-bar appearances retain
precedence. The package does not inspect SwiftUI controller hierarchies or
mutate global appearance while rendering a view.

## Consequences

- Adopters can keep the ordinary app theme in one source location and receive
  automatic subtree propagation for all inheritable theme values, MHDesign
  metrics, and optional native tint.
- Host apps keep ownership of their brand color when they use the standard
  theme unchanged.
- Asset-backed accent colors stay aligned between MHUI components and native
  controls unless a narrower SwiftUI tint override is intentional. Apps also
  own contrast validation for the matching `onAccent` foreground.
- Changing a theme role updates every MHUI primitive that consumes that role.
- Exceptions use the same value type and normal SwiftUI environment scoping.
- Semantic role selection remains visible at use sites, preserving meaning and
  native control behavior.
- A screen makes one explicit structural route choice. Specialized native
  subtrees opt out by omitting MHUI structure or semantic styles, while local
  themes and asset-backed tints remain available for narrower exceptions.
- Applying an asset-backed accent theme may change native control tint for existing
  adopters and must be called out in release migration notes.
