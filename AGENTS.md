# AGENTS.md

Repository-specific agent contract for MHUI.

## Repository Boundaries

- `MHDesign` owns shared spacing, corner-radius, generic screen and surface
  layout metrics, and the SwiftUI environment bridge that work without MHUI
  chrome.
- `MHUI` owns semantic theme application, standard theme assets, presentation
  primitives, native-container chrome, package-owned fallback behavior, preview
  validation, and re-export of `MHDesign` for styled adopters.
- Host apps own business logic, domain models, product wording, navigation
  meaning, app-specific screen shells, persistence, networking, analytics,
  logging, configuration, and platform side effects.
- Do not add replacement controls that shadow native SwiftUI controls.
- Do not add low-level Liquid Glass choreography APIs without a concrete
  package-owned primitive that needs them.

## Repository Rules

- Use English for branch names, code comments, documentation, and identifiers
  unless UI localization or legal content requires otherwise.
- Follow existing architecture and source style; keep changes small and
  repository-local.
- Markdown must follow
  <https://github.com/DavidAnson/markdownlint/blob/main/doc/Rules.md>.
- Swift code must comply with the repository SwiftLint configuration.

## Toolchain Compatibility

- Treat the selected latest Xcode with Swift 6.2 and the current Apple platform
  SDKs as the default local package toolchain.
- Keep the package deployment targets at iOS 18, macOS 15, and watchOS 11 unless
  a package contract change explicitly moves them.
- For Liquid Glass and other SDK-sensitive SwiftUI APIs, prefer latest SDK
  spelling in package code, then isolate older-runtime behavior behind small
  availability-checked helpers with explicit fallbacks.

## Build and Test Entry Point

Agents MUST prefer the Xcode-native integration available in the current agent
environment for workspace discovery, active scheme and destination selection,
build, test, and Preview rendering. When a runnable consumer is available, use
the same integration for bounded run, runtime-log, live UI, and screenshot
evidence.

Before changing Xcode's active selection, discover the open workspaces,
schemes, and run destinations, identify
`.swiftpm/xcode/package.xcworkspace`, and record the original active scheme
and destination. Switch only to values returned by discovery. After
verification, restore the original scheme first, rediscover its valid
destinations, restore the original destination, and confirm the final
selection. Report any selection that cannot be restored.

For MHUI package compile checks, use the available Xcode-native build
capability with:

- Workspace: `.swiftpm/xcode/package.xcworkspace`
- Scheme: `MHUI-Package`
- Destination: a discovered iPhone Simulator

For package tests, use the available Xcode-native test capability with the
same workspace, scheme, and destination family.

Treat package tests, retained boundary checks, Preview evidence, and available
consumer evidence as separate verification capabilities. Choose the smallest
set that proves the current change, and prefer stronger evidence when public
products, SwiftUI APIs, package boundaries, design tokens, visual treatments,
previews, or adopter-facing behavior are affected.

- For package source or product changes, use the package build/test checks above.
- For package-boundary changes, run the retained repository rule checks below.
- For SwiftUI visual primitives, preview behavior, or design-system treatment
  changes, add targeted Xcode-native Preview rendering. Add runtime-log, live
  UI, or screenshot evidence only when a runnable consumer is available.

When Swift files are edited, agents should run:

```sh
bash ci_scripts/tasks/format_swift.sh
```

Agents should also run the retained repository rule checks:

```sh
bash ci_scripts/tasks/check_repository_rules.sh
```

`check_repository_rules.sh` runs SwiftLint, the SwiftUtilities boundary
check, and that check's self-test. These retained static rules are not
naturally covered by the available Xcode-native integration.
SwiftLint is resolved from the `SimplyDanny/SwiftLintPlugins` package declared
in `Package.swift`, not from a separately installed `swiftlint` binary.

`verify.sh` is retained as a pre-commit plus repository-rules compatibility
wrapper. Direct shell build and test scripts are compatibility or fallback
tools; do not treat them as the primary agent verification surface when the
Xcode-native integration is available.

Compatibility shell build and test scripts may write disposable cache data and
result bundles under `.build/ci/shared/`.
