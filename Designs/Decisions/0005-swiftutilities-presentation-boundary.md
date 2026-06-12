# ADR 0005: SwiftUtilities Presentation Boundary

- Date: 2026-06-10
- Status: Accepted

## Context

Some sibling apps previously reached presentation helpers through
`SwiftUtilities`. MHUI still needs to keep that package out of the UI layer, but
the migration should not turn MHUI into the new owner of thin app-local
shortcuts.

Helpers such as `CloseButton`, `hidden(_:)`, `singleLine()`, `twoLines()`, and
`Color.adjusted(by:)` can be implemented directly by host apps when they are
useful. They do not define MHUI semantic roles, package chrome, native-container
fallback, or package-owned preview validation. Generic collection, optional,
string, date, number, image-decoding, bundle-introspection, and SwiftData
helpers are also outside MHUI's presentation boundary.

## Decision

MHUI does not adopt SwiftUtilities presentation helpers as package APIs. It
must not provide source-compatible aliases or MHUI-prefixed replacements for
those helpers just to reduce consumer migration work.

Generic Foundation, SwiftData, date, string, numeric, collection, optional,
image-decoding, bundle-introspection, and local presentation shortcuts stay
outside MHUI. Durable cross-app non-UI utilities should be evaluated in a
platform foundation instead.
MHUI must not add a package or project dependency reference to `SwiftUtilities`,
and MHUI or MHDesign source files must not import `SwiftUtilities` or
`SwiftData`.

## Consequences

- Apps that need those helpers must keep them app-owned or move non-UI utility
  concerns to a platform foundation.
- `Color.random()`, raw `CGFloat` scale helpers, `Image(data:)`,
  `UIImage.appIcon`, and non-presentation utilities are deliberately not
  mirrored in MHUI.
- CI guards the package boundary so future changes do not accidentally
  reintroduce a `SwiftUtilities` dependency, a `SwiftData` import, or
  SwiftUtilities helper mirror.
