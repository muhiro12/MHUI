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
| Package (`Sources/MHUI`) | Semantic tokens, theme recipes, styling modifiers, layout primitives, screen chrome, package-owned preview support | App models, persistence, logging, networking, analytics, remote config, product-specific navigation |
| Host app or sibling app | Feature state, domain rules, platform integrations, app-specific navigation, product composition | Rebuilding shared MHUI primitives as local forks |
| Example app (`Example/` when present) | Integration review, manual regression checks, sample usage of package APIs | Becoming the source of truth for shared package APIs or hiding canonical styling outside `Sources/MHUI` |

## Package Rules

Allowed in the package:

- Reusable typography, spacing, color, and surface tokens
- Domain-neutral modifiers and container chrome
- Shared presentation helpers that improve consistency across sibling apps
- Preview or example scaffolding that proves package behavior

Not allowed in the package:

- Business validation or mutation rules
- Persistence orchestration or infrastructure services
- Product-specific search, sync, or analytics behavior
- Navigation meaning that depends on one host app's feature map

## Canonical Integration Flow

`Host app screen -> MHTheme and MHUI modifiers -> native SwiftUI controls and containers`

The package should shape presentation and composition without becoming the owner of host application behavior.

## Example and Preview Mapping

Example projects and preview catalogs follow the same package-first path:

`Host example or preview -> MHUI public APIs -> package-owned tokens and layout primitives`

They may demonstrate package usage, but they should not become the place where new shared styling rules are invented first.

## Repository Structure Guidance

- Keep canonical shared APIs in `Sources/MHUI`.
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
   - `Sources/MHUI/`
   - host app call sites outside this repository

   Minimal plan:
   - Keep MHUI APIs generic enough to compose multiple sibling products.
   - Keep feature labels, app navigation meaning, and business-state branching outside the package.
   - Treat requests for app-specific screen shells as a signal to add host-side composition rather than package-owned product views.
