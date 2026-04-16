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

## Responsibility Boundaries

| Layer | Owns | Must not own |
| --- | --- | --- |
| `MHDesign` (`Sources/MHDesign`) | Shared spacing, corner-radius, generic screen or surface layout metrics, and the SwiftUI environment bridge that sibling apps can adopt without MHUI chrome | Product copy, business rules, navigation meaning, view-specific styling behavior, or MHUI-owned component chrome |
| `MHUI` (`Sources/MHUI`) | Semantic theme application, styling modifiers, layout primitives, row and action fallback rules, key-value fallback, cue geometry, screen chrome, colocated development previews, package-owned validation previews, and re-export of `MHDesign` for styled adopters | App models, persistence, logging, networking, analytics, remote config, product-specific navigation, art-direction presets |
| Host app or sibling app | Feature state, domain rules, platform integrations, app-specific navigation, product composition | Rebuilding shared MHUI primitives as local forks |
| Example app (`Example/` when present) | Integration review, manual regression checks, sample usage of package APIs | Becoming the source of truth for shared package APIs or hiding canonical styling outside `Sources/MHUI` |

## Package Rules

Allowed in the package:

- Reusable spacing, corner radius, and generic screen or surface layout metrics in `MHDesign`
- Reusable typography, color, and surface tokens in `MHUI`
- Domain-neutral modifiers and container chrome
- Shared presentation helpers that improve consistency across sibling apps
- Width-aware fallback behavior for actions, grouped actions, and key-value rows
- Colocated development previews for public primitives and layout APIs
- Validation scaffolding in `Sources/MHUI/PreviewSupport` that proves package behavior across fixed-width scenarios

Not allowed in the package:

- Business validation or mutation rules
- Persistence orchestration or infrastructure services
- Product-specific search, sync, or analytics behavior
- Navigation meaning that depends on one host app's feature map
- Low-level glass choreography APIs
- Feature-specific wrapper controls that shadow native SwiftUI components
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

## Example and Preview Mapping

Example projects, colocated development previews, and preview validation catalogs follow the same package-first path:

`Host example or preview -> MHUI public APIs -> package-owned tokens and layout primitives`

Daily development previews should live beside the edited implementation file so the package API and its first review surface stay together.
`Sources/MHUI/PreviewSupport` is reserved for validation helpers and regression catalogs that compare multiple runtime contexts.
Neither should become the place where new shared styling rules are invented before the canonical package API exists.

## Modifier Structure Guidance

- Prefer a direct `View` extension when an API only writes environment values or adds a light styling chain that stays clearer without an extra type.
- Keep a private `ViewModifier` when the implementation reads environment values, resolves adaptive layout, bundles multiple visual steps such as padding, background, overlay, or animation, or is shared by multiple public entry points.
- Canonical direct-extension examples are `mhTheme(_:)`, `mhGlassPolicy(_:)`, `mhActionPresentation(_:)`, and `mhKeyValueLayout(_:)`.
- Canonical private-`ViewModifier` examples are `mhSurface(role:)`, `mhTextStyle(_:colorRole:)`, `mhScreen(...)`, `mhSection(...)`, `mhGroupedRows()`, `mhInputChrome(state:)`, and `mhBadge(style:)`.

## Repository Structure Guidance

- Keep canonical shared design parameters in `Sources/MHDesign`.
- Keep canonical styled APIs in `Sources/MHUI`.
- Keep package verification in `Tests/MHUITests`.
- Keep stable automation entrypoints in `ci_scripts/tasks/`.
- Keep architectural intent in `Designs/`.
- Treat `Example/` as optional and adapter-like when it exists.

## Current Hotspots and Minimal Plans

1. CI and architecture docs should stay package-first.

   Files:
   - `README.md`
   - `Designs/`
   - `ci_scripts/tasks/`

   Minimal plan:
   - Keep contributor workflow documented at the repository root.
   - Keep architecture intent in versioned docs under `Designs/`.
   - Keep automation entrypoints stable so humans and CI can reuse them.

2. Example app integration should remain optional and thin.

   Files:
   - `ci_scripts/tasks/build_app.sh`
   - `Example/` when present

   Minimal plan:
   - Build the example app only as a consumer of the package.
   - Do not move shared primitives out of `Sources/MHUI` to satisfy example-only needs.
   - Skip example app build work entirely when the directory is absent.

3. Product-specific meaning should stay in host screens.

   Files:
   - `Sources/MHDesign/`
   - `Sources/MHUI/`
   - host app call sites outside this repository

   Minimal plan:
   - Keep raw shared metrics in `MHDesign` when they should work without MHUI chrome.
   - Keep row, action, key-value, and cue tuning in `MHUI` even when the implementation is numeric.
   - Keep MHUI APIs generic enough to compose multiple sibling products and re-export `MHDesign` for styled adopters.
   - Keep feature labels, app navigation meaning, and business-state branching outside the package.
   - Treat requests for app-specific screen shells as a signal to add host-side composition rather than package-owned product views.
   - Prefer package-owned fallback behavior over host-side compact-width workarounds for standard rows and actions.
