# ADR 0005: SwiftUtilities Presentation Boundary

- Date: 2026-06-10
- Status: Accepted

## Context

Some sibling apps previously reached presentation helpers through `SwiftUtilities`.
MHUI should let styled adopters depend on MHUI for shared presentation behavior
without making `SwiftUtilities` a child package or importing every generic helper
into the UI layer.

The current presentation inventory shows repeated use of `CloseButton`,
`hidden(_:)`, `singleLine()`, and `Color.adjusted(by:)`.
No sibling app call site currently requires the SwiftUtilities `Image(data:)`
initializer; image decoding call sites use platform image APIs directly.
Generic collection, optional, string, date, number, and SwiftData helpers are
already better aligned with the platform foundation layer than with MHUI's
presentation boundary.

## Decision

MHUI adopts only the SwiftUtilities functionality that is presentation-specific,
domain neutral, and consistent with the package's public API shape.
Adopted helpers use MHUI-prefixed names rather than source-compatible aliases.
Generic Foundation, SwiftData, date, string, numeric, collection, optional,
image-decoding, and bundle-introspection helpers stay outside MHUI and should be
evaluated in a platform foundation instead.
MHUI must not add a package or project dependency reference to `SwiftUtilities`,
and MHUI or MHDesign source files must not import `SwiftUtilities` or
`SwiftData`.

## Consequences

- Apps can migrate shared presentation call sites to MHUI without bringing `SwiftUtilities` into MHUI.
- `CloseButton`, `hidden(_:)`, `singleLine()`, `twoLines()`, and `Color.adjusted(by:)` have MHUI-prefixed replacements.
- `Color.random()`, raw `CGFloat` scale helpers, `Image(data:)`,
  `UIImage.appIcon`, and non-presentation utilities are deliberately not
  mirrored in MHUI.
- CI guards the package boundary so future changes do not accidentally
  reintroduce a `SwiftUtilities` dependency, a `SwiftData` import, or
  source-compatible API mirrors.
