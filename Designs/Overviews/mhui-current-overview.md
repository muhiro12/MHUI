# MHUI Current Repository Overview

Current as of July 16, 2026.

## Purpose

MHUI is a Swift package for calm, tool-like SwiftUI presentation.
The repository is intentionally biased toward package-owned visual rules and away from product-specific behavior.

## Repository Surface Summary

| Surface | Current role | Key responsibilities |
| --- | --- | --- |
| `MHDesign` | Shared package | Spacing, corner-radius, and layout metrics that sibling apps can adopt without MHUI chrome |
| `MHUI` | Shared package | Theme definitions, semantic styling APIs, modifiers, layout helpers, screen chrome, and re-export of `MHDesign` for styled adopters |
| `MHUI/Resources` | Package resources | Asset catalogs that back MHUI standard theme colors while preserving semantic role APIs in source |
| `MHDesign/Tests`, `MHUI/Tests` | Package verification | Validate the shared package surfaces through Swift package tests |
| `ci_scripts` | Workflow layer | Retained repository rules, SwiftLint helpers, and compatibility entrypoints |
| `Designs` | Architecture documentation | Current overview, architecture guide, and ADR history |
| `Example/` | Optional consumer app | Review package integration in a host-app context when the example project exists |

## Current Repository Rules

- Shared design parameters live in `MHDesign/Sources`.
- Shared presentation APIs live in `MHUI/Sources`, which re-exports `MHDesign`.
- Standard MHUI color values live in `MHUI/Resources` and are reached through semantic roles in `MHUI/Sources`.
- Versions in the `1.x` line are beta and may include intentional breaking API changes.
- The package does not keep deprecated aliases, migration helpers, or compatibility shims for consuming apps during `1.x`.
- Product behavior stays outside the package.
- The example app, when present, is a consumer of the package rather than a second source of truth.
- Compatibility shell build and test scripts may write disposable artifacts
  under `.build/ci/shared/`.
- MHDesign tuning previews live in same-directory `+Preview.swift` files, with minimal shared helpers under `MHDesign/Sources/PreviewSupport`.
- Development previews for public primitives and layout APIs stay beside the implementation they tune.
- `MHUI/Sources/PreviewSupport` is reserved for validation catalogs and shared preview styling helpers.
- `ViewModifier` types are kept only when environment reads, adaptive layout resolution, multi-step chrome, or shared implementation justify them.

## Public API Areas

- `MHDesignMetrics` and its spacing, corner-radius, and layout value groups
- Root theme application through `mhTheme(_:)`, public `MHTheme` semantic
  groups, and explicit component roles
- Text styling primitives such as `mhTextStyle(_:colorRole:)`, including system
  font design and tracking tokens
- Standard, elevated, and muted surface roles, row and section modifiers, and
  the `MHGroupedRows` container
- Screen-level chrome such as `mhScreen(...)`, `mhListChrome(...)`, and `mhFormChrome(...)`
- Presentation helpers including action groups, badges, input chrome, and package-owned compact fallback behavior

## Architecture References

- `Designs/Architecture/ARCHITECTURE_GUIDE.md`
- `Designs/Architecture/shared-presentation-design.md`
- `Designs/Decisions/0001-shared-package-source-of-truth.md`
- `Designs/Decisions/0002-host-apps-own-product-behavior.md`
- `Designs/Decisions/0003-example-integrations-stay-outside-package.md`
- `Designs/Decisions/0004-host-screens-own-product-meaning.md`
- `Designs/Decisions/0005-swiftutilities-presentation-boundary.md`
- `Designs/Decisions/0006-root-theme-propagation.md`

## Verification Entry Points

- Available Xcode-native build capability with
  `.swiftpm/xcode/package.xcworkspace`, the `MHUI-Package` scheme, and a
  discovered iPhone Simulator destination
- Available Xcode-native test capability with the same workspace, scheme, and
  destination family
- `bash ci_scripts/tasks/format_swift.sh`
- `bash ci_scripts/tasks/check_repository_rules.sh`
- `bash ci_scripts/tasks/verify.sh`
- `bash ci_scripts/tasks/pre_commit.sh`
- `bash ci_scripts/tasks/lint_swift.sh`

The shell build and test wrappers remain compatibility or fallback tools when
the Xcode-native integration is unavailable or does not cover a check.

## Known Boundary Decisions

- The repository is shared-library-first.
- App-specific flows, domain models, and infrastructure do not belong in this package.
- Generic Foundation, SwiftData, date, string, numeric, image-decoding, and
  bundle-introspection utilities do not belong in MHUI.
- Source-compatible or MHUI-prefixed SwiftUtilities helper replacements do not
  belong in MHUI.
- Shared spacing, corner-radius, and layout scale APIs should use
  `MHDesignMetrics` rather than ad-hoc `CGFloat` helpers.
- Verification guards the package boundary so MHUI and MHDesign sources do not
  depend on or import SwiftUtilities or SwiftData.
- Art-direction presets and low-level glass choreography do not belong in this package.
- A styled app defines one root theme, while narrower themes are reserved for
  intentional subtree exceptions.
- Theme propagation supplies semantic values but does not infer component roles
  or replace native SwiftUI controls.
- Package-owned Liquid Glass behavior is limited to semantic tinting, grouped
  chrome containers, action interactivity, and accessibility/runtime fallback.
- Runtime UI fallback remains package-owned behavior and is separate from consumer-update compatibility policy.
- Verification should prefer documented Xcode-native capabilities and retained
  `ci_scripts/tasks/*.sh` rule entrypoints over ad-hoc commands.
