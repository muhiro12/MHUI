# MHUI Architecture Guide

## Scope

This guide defines the strict `shared-visual-language-in-package, product-behavior-in-host-app` policy for this repository.

Related documents:

- [mhui-current-overview.md](../Overviews/mhui-current-overview.md)
- [shared-presentation-design.md](./shared-presentation-design.md)
- [0001-shared-package-source-of-truth.md](../Decisions/0001-shared-package-source-of-truth.md)
- [0002-host-apps-own-product-behavior.md](../Decisions/0002-host-apps-own-product-behavior.md)
- [0003-example-integrations-stay-outside-package.md](../Decisions/0003-example-integrations-stay-outside-package.md)
- [0004-host-screens-own-product-meaning.md](../Decisions/0004-host-screens-own-product-meaning.md)
- [0005-swiftutilities-presentation-boundary.md](../Decisions/0005-swiftutilities-presentation-boundary.md)

## Responsibility Boundaries

| Layer | Owns | Must not own |
| --- | --- | --- |
| `MHDesign` (`MHDesign/Sources`) | Shared spacing, corner-radius, generic screen or surface layout metrics, the SwiftUI environment bridge that sibling apps can adopt without MHUI chrome, and sidecar tuning previews backed by minimal preview helpers | Product copy, business rules, navigation meaning, view-specific styling behavior, or MHUI-owned component chrome |
| `MHUI` (`MHUI/Sources`, `MHUI/Resources`) | Semantic theme application, standard theme assets, styling modifiers, layout primitives, row and action fallback rules, key-value fallback, cue geometry, screen chrome, colocated development previews, package-owned validation previews, and re-export of `MHDesign` for styled adopters | App models, persistence, logging, networking, analytics, remote config, product-specific navigation, art-direction presets, generic Foundation or SwiftData utilities |
| Host app or sibling app | Feature state, domain rules, platform integrations, app-specific navigation, product composition | Rebuilding shared MHUI primitives as local forks |
| Example app (`Example/` when present) | Integration review, manual regression checks, sample usage of package APIs | Becoming the source of truth for shared package APIs or hiding canonical styling outside `MHUI/Sources` |

## Package Rules

Allowed in the package:

- Reusable spacing, corner radius, and generic screen or surface layout metrics in `MHDesign`
- Sidecar tuning previews and minimal preview helpers for MHDesign metrics and environment overrides
- Reusable typography, color, and surface tokens in `MHUI`
- Package-owned color assets in `MHUI/Resources` when source APIs continue to expose semantic roles
- Domain-neutral modifiers and container chrome
- Width-aware fallback behavior for actions, grouped actions, and key-value rows
- Colocated development previews for public primitives and layout APIs
- Validation scaffolding in `MHUI/Sources/PreviewSupport` that proves package behavior across fixed-width scenarios

Not allowed in the package:

- Business validation or mutation rules
- Persistence orchestration or infrastructure services
- Product-specific search, sync, or analytics behavior
- Navigation meaning that depends on one host app's feature map
- Low-level glass choreography APIs, glass-effect identity wiring, or morphing
  transition control
- Feature-specific wrapper controls that shadow native SwiftUI components
- Source-compatible or MHUI-prefixed SwiftUtilities helper replacements
- Generic Foundation, SwiftData, date, string, numeric, image-decoding, or bundle-introspection utilities
- Direct SwiftData imports in MHUI or MHDesign presentation source
- Direct SwiftUtilities package/project dependency references or source imports
- Consumer-update compatibility layers, migration helpers, or deprecated alias paths during `1.x` beta

## Versioning Contract

- Versions in the `1.x` line, including `1.0`, `1.5`, and `1.5.1`, are beta releases.
- During `1.x`, breaking package API changes are allowed when they make the shared boundary or public surface clearer.
- During `1.x`, consuming apps are expected to update to the current package APIs instead of relying on compatibility shims, migration helpers, or deprecated aliases in the package.
- This contract does not remove runtime UI behavior such as compact-width layout changes or readability fallback, because those remain part of the product surface that the package owns.

## Canonical Integration Flow

Metrics-only adopter:
`Host app screen -> MHDesign metrics and environment bridge -> native SwiftUI controls and containers`

Styled adopter:
`Host app screen -> MHUI (re-exporting MHDesign) -> MHTheme, MHDesign metrics, native SwiftUI controls and package chrome`

The package should shape presentation and composition without becoming the owner of host application behavior.

## Root Theme Contract

- A styled adopter should define one app-owned `MHTheme` value, normally by
  copying `MHTheme.standard` and changing the semantic values it owns.
- The app applies that value once near its root with `mhTheme(_:)`.
- `mhTheme(_:)` propagates the theme through SwiftUI's environment. A concrete
  theme accent also becomes the native-control tint for the subtree,
  while the standard theme resolves semantic accent from the app's
  `AccentColor` without installing a tint override.
- A narrower `mhTheme(_:)` call is the supported mechanism for an intentional
  local exception.
- Theme propagation supplies values. Views still select semantic intent with
  APIs such as `mhTextStyle`, `mhSurface`, `mhRow`, and MHUI button styles.
- MHUI must not infer roles from arbitrary native controls or install a blanket
  style that replaces SwiftUI control behavior.

## Example and Preview Mapping

Example projects, MHDesign sidecar previews, MHUI colocated development previews, and preview validation catalogs follow the same package-first path:

`Host example or preview -> MHUI public APIs -> package-owned tokens and layout primitives`

MHDesign tuning previews should live in same-directory sidecar files so metrics types stay focused on values while still keeping the first review surface nearby.
MHUI development previews should live inside the edited implementation file so the styled API and its first review surface stay together.
`MHDesign/Sources/PreviewSupport` is reserved for minimal helper views shared by MHDesign sidecar previews.
`MHUI/Sources/PreviewSupport` is reserved for validation helpers and regression catalogs that compare multiple runtime contexts.
Neither should become the place where new shared styling rules are invented before the canonical package API exists.

## Modifier Structure Guidance

- Prefer a direct `View` extension when an API only writes environment values or adds a light styling chain that stays clearer without an extra type.
- Keep a private `ViewModifier` when the implementation reads environment values, resolves adaptive layout, bundles multiple visual steps such as padding, background, overlay, or animation, or is shared by multiple public entry points.
- Canonical direct-extension examples are `mhGlassPolicy(_:)`, `mhActionPresentation(_:)`, and `mhKeyValueLayout(_:)`.
- `MHGroupedRows` is a container because it needs direct access to its row
  subviews to place separators correctly.
- Canonical private-`ViewModifier` examples are `mhTheme(_:)`,
  `mhSurface(role:)`, `mhTextStyle(_:colorRole:)`, `mhScreen(...)`,
  `mhSection(...)`, `mhInputChrome(state:)`, and `mhBadge(style:)`.

## Repository Structure Guidance

- Keep canonical shared design parameters in `MHDesign/Sources`.
- Keep MHDesign preview helpers in `MHDesign/Sources/PreviewSupport` and keep metric-specific tuning previews beside the corresponding source files.
- Keep canonical styled APIs in `MHUI/Sources`.
- Keep MHUI package resource assets in `MHUI/Resources` so source and resources remain siblings under the `MHUI` target root.
- Keep package color assets in `MHUI/Resources/Assets.xcassets` and resolve them
  through package-owned resource references so Xcode and SwiftPM consumers share
  the same boundary.
- Keep package verification in `MHDesign/Tests` and `MHUI/Tests`.
- Scope library targets to `Sources`, exclude target-local `Tests` from library target discovery, and expose package tests through explicit SwiftPM test targets.
- Keep retained repository-rule scripts, SwiftLint helpers, and compatibility
  entrypoints in `ci_scripts/tasks/`.
- Keep architectural intent in `Designs/`.
- Treat `Example/` as optional and adapter-like when it exists.

## Current Hotspots and Minimal Plans

1. Verification and architecture docs should stay package-first.

   Files:
   - `README.md`
   - `Designs/`
   - `ci_scripts/tasks/`

   Minimal plan:
   - Keep contributor workflow documented at the repository root.
   - Keep architecture intent in versioned docs under `Designs/`.
   - Keep the available Xcode-native integration as the primary package build,
     test, and Preview evidence surface. Add runtime or live UI evidence only
     through an available consumer.
   - Keep shell scripts focused on retained rules, SwiftLint, and compatibility
     fallback checks.

2. Example app integration should remain optional and thin.

   Files:
   - `ci_scripts/tasks/build_app.sh`
   - `Example/` when present

   Minimal plan:
   - Build the example app only as a consumer of the package.
   - Do not move shared primitives out of `MHUI/Sources` to satisfy example-only needs.
   - Skip example app build work entirely when the directory is absent.

3. Product-specific meaning should stay in host screens.

   Files:
   - `MHDesign/Sources/`
   - `MHUI/Sources/`
   - host app call sites outside this repository

   Minimal plan:
   - Keep raw shared metrics in `MHDesign` when they should work without MHUI chrome.
   - Keep row, action, key-value, and cue tuning in `MHUI` even when the implementation is numeric.
   - Keep MHUI APIs generic enough to compose multiple sibling products and re-export `MHDesign` for styled adopters.
   - Keep feature labels, app navigation meaning, and business-state branching outside the package.
   - Keep Liquid Glass use to package-owned chrome: grouped glass containers,
     semantic tinting, action interactivity, and accessibility fallbacks.
   - Prefer native SwiftUI glass, toolbar, and button APIs in host apps when
     behavior is product-specific.
   - Treat requests for app-specific screen shells as a signal to add host-side composition rather than package-owned product views.
   - Prefer package-owned fallback behavior over host-side compact-width workarounds for standard rows and actions.
