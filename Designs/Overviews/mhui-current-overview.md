# MHUI Current Repository Overview

Current as of April 10, 2026.

## Purpose

MHUI is a Swift package for calm, tool-like SwiftUI presentation.
The repository is intentionally biased toward package-owned visual rules and away from product-specific behavior.

## Repository Surface Summary

| Surface | Current role | Key responsibilities |
| --- | --- | --- |
| `MHDesign` | Shared package | Spacing, corner-radius, and layout metrics that sibling apps can adopt without MHUI chrome |
| `MHUI` | Shared package | Theme definitions, semantic styling APIs, modifiers, layout helpers, screen chrome, and re-export of `MHDesign` for styled adopters |
| `Tests/MHUITests` | Package verification | Validate the shared package surface through Swift package tests |
| `ci_scripts` | Workflow layer | Stable build, test, verify, and artifact-capture entrypoints |
| `Designs` | Architecture documentation | Current overview, architecture guide, and ADR history |
| `Example/` | Optional consumer app | Review package integration in a host-app context when the example project exists |

## Current Repository Rules

- Shared design parameters live in `Sources/MHDesign`.
- Shared presentation APIs live in `Sources/MHUI`, which re-exports `MHDesign`.
- Versions in the `1.x` line are beta and may include intentional breaking API changes.
- The package does not keep deprecated aliases, migration helpers, or compatibility shims for consuming apps during `1.x`.
- Product behavior stays outside the package.
- The example app, when present, is a consumer of the package rather than a second source of truth.
- CI scripts write disposable artifacts under `.build/ci/`.
- Development previews for public primitives and layout APIs stay beside the implementation they tune.
- `Sources/MHUI/PreviewSupport` is reserved for validation catalogs and shared preview styling helpers.
- `ViewModifier` types are kept only when environment reads, adaptive layout resolution, multi-step chrome, or shared implementation justify them.

## Public API Areas

- `MHDesignMetrics` and its spacing, corner-radius, and layout value groups
- Theme application through `MHTheme.standard()` and related semantic roles
- Text styling primitives such as `mhTextStyle(_:colorRole:)`
- Surface, row, section, and grouped-layout modifiers
- Screen-level chrome such as `mhScreen(...)`, `mhListChrome(...)`, and `mhFormChrome(...)`
- Presentation helpers including action groups, badges, input chrome, and package-owned compact fallback behavior

## Architecture References

- `Designs/Architecture/ARCHITECTURE_GUIDE.md`
- `Designs/Architecture/shared-presentation-design.md`
- `Designs/Decisions/0001-shared-package-source-of-truth.md`
- `Designs/Decisions/0002-host-apps-own-product-behavior.md`
- `Designs/Decisions/0003-example-integrations-stay-outside-package.md`
- `Designs/Decisions/0004-host-screens-own-product-meaning.md`

## Verification Entry Points

- `bash ci_scripts/tasks/verify.sh`
- `bash ci_scripts/tasks/run_required_builds.sh`
- `bash ci_scripts/tasks/pre_commit.sh`
- `bash ci_scripts/tasks/build_app.sh`
- `bash ci_scripts/tasks/test_shared_library.sh`

## Known Boundary Decisions

- The repository is shared-library-first.
- App-specific flows, domain models, and infrastructure do not belong in this package.
- Art-direction presets and low-level glass choreography do not belong in this package.
- Runtime UI fallback remains package-owned behavior and is separate from consumer-update compatibility policy.
- Verification should prefer stable `ci_scripts/tasks/*.sh` entrypoints over ad-hoc commands.
