# ADR 0006: Root Theme Propagation

- Date: 2026-07-16
- Last updated: 2026-07-17
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

A narrower `mhTheme(_:)` call provides an intentional local override. Views
still select semantic intent explicitly through MHUI text, surface, row,
button, and container APIs. MHUI does not infer roles from arbitrary content,
replace native controls, or install blanket styles for every SwiftUI control.

## Consequences

- Adopters can keep the ordinary app theme in one source location and receive
  automatic subtree propagation.
- Host apps keep ownership of their brand color when they use the standard
  theme unchanged.
- Asset-backed accent colors stay aligned between MHUI components and native
  controls unless a narrower SwiftUI tint override is intentional. Apps also
  own contrast validation for the matching `onAccent` foreground.
- Changing a theme role updates every MHUI primitive that consumes that role.
- Exceptions use the same value type and normal SwiftUI environment scoping.
- Semantic role selection remains visible at use sites, preserving meaning and
  native control behavior.
- Applying an asset-backed accent theme may change native control tint for existing
  adopters and must be called out in release migration notes.
