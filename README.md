# MHUI

## Overview

MHUI is a narrow runtime presentation kit for calm, tool-like sibling apps.
It is intentionally opinionated and intentionally small.
The repository also exposes `MHDesign`, a smaller metrics layer for apps that need the shared spacing, corner radius, and generic screen or surface layout baseline without adopting MHUI chrome.
`MHDesign` includes a SwiftUI environment bridge so apps and MHUI components can share one active metrics subtree.
`MHUI` is the styled layer built on top of `MHDesign` and re-exports it for styled adopters.
The Swift Package supports iOS 18+, macOS 15+, and watchOS 11+.

MHUI focuses on three layers:

- semantic visual tokens
- styling primitives and modifiers
- screen and native-container chrome with compact-width fallback behavior

It does not own app business logic, app models, navigation meaning, logging, configuration, or infrastructure concerns.
Those responsibilities stay outside the package.

## MHUI Owns

- semantic theme application through `MHTheme.standard()` and `MHTheme.standard(accent:)`
- text, surface, row, section, screen, and native-container chrome
- width-adaptive action presentation and action-group fallback
- key-value row fallback behavior for narrow or constrained widths
- package-owned preview infrastructure: colocated development previews plus validation catalogs and package tests that prove those shared rules

## MHUI Does Not Own

- art-direction presets or app branding systems
- low-level glass choreography beyond `MHGlassPolicy` readability fallback
- replacement controls for native SwiftUI views
- generic SwiftUtilities presentation shortcuts such as dismiss buttons,
  visibility helpers, text-line helpers, or arbitrary color adjustment helpers
- feature-specific wrappers, domain models, or product-specific screen shells
- preview-only abstractions that host apps would need to import

## Repository Layout

- `MHDesign/Sources` - shared spacing, corner-radius, and layout metrics for sibling apps
- `MHDesign/Sources/PreviewSupport` - minimal preview helpers for MHDesign sidecar tuning previews
- `MHUI/Sources` - shared styled presentation APIs built on `MHDesign`
- `MHUI/Sources/PreviewSupport` - shared preview styling helpers and regression validation catalogs
- `MHUI/Resources` - package-owned asset catalogs backing MHUI standard theme resources
- `MHDesign/Tests` and `MHUI/Tests` - package verification surfaces
- `ci_scripts/` - retained repository rules, SwiftLint helpers, and compatibility entrypoints
- `Designs/` - architecture notes, current overview, and ADRs
- `Example/` - optional macOS consumer app used only when present for integration review; watchOS support stays package-level

## Adoption Paths

- Metrics-only adopter: `import MHDesign`
- Styled adopter: `import MHUI`

Use `MHDesign` directly when an app wants to avoid MHUI chrome and only share spacing, corner radius, generic screen or surface layout, and the environment bridge.
Use `MHUI` when an app wants the styled layer. `MHUI` re-exports `MHDesign`, so one import is enough for both the metrics layer and the styled APIs.
Row chrome, action fallback, key-value fallback, and cue geometry stay MHUI-owned even when they are backed by shared package defaults.
`Package.swift` keeps each package target scoped to `Sources`, excludes target-local `Tests` from library target discovery, and maps package tests through explicit test target paths.
Package-owned color assets live in `MHUI/Resources/Assets.xcassets` and are
resolved through MHUI-owned resource references so Xcode and SwiftPM consumers
use the same package boundary.

MHUI does not provide replacement APIs for earlier SwiftUtilities helpers.
Apps that need local presentation shortcuts should implement them in the app,
while durable cross-app non-UI utilities should be evaluated for a platform
foundation instead.

SwiftUtilities helper areas should not become MHUI APIs:

| Earlier helper area | MHUI decision |
| --- | --- |
| `CloseButton`, `hidden(_:)`, `singleLine()`, `twoLines()` | No MHUI replacement; apps can use native SwiftUI directly or keep app-local helpers. |
| `Color.adjusted(by:)`, `Color.random()` | No MHUI replacement; shared UI should use semantic theme roles or host-owned colors. |
| Raw `CGFloat` scale helpers | Use `MHDesignMetrics` for shared spacing, corner radius, and layout scale. |
| `Image(data:)`, `UIImage.appIcon` | No MHUI replacement; image decoding and bundle introspection stay outside MHUI. |
| Foundation and persistence helpers | Keep outside MHUI; evaluate for a platform foundation instead. |

Representative non-MHUI helpers include `CGFloat.space(_:)`, `CGFloat.icon(_:)`,
`CGFloat.component(_:)`, `Optional.orEmpty`, `Collection.isNotEmpty`,
`StringProtocol.normalizedContains(_:)`, `ModelContext.fetchFirst(_:)`, and
`PersistentIdentifier.base64Encoded()`.

## Versioning Policy

Versions in the `1.x` line, including `1.0`, `1.5`, and `1.5.1`, are beta releases.
During `1.x`, MHUI and MHDesign may ship intentional breaking API changes when that keeps the package boundary or public surface clearer.
During `1.x`, the package does not preserve backward compatibility for consuming apps through deprecated aliases, migration helpers, compatibility shims, or old-caller dual paths.
Consuming apps are expected to update to the current package APIs when adopting a new `1.x` release.
This policy applies to package API evolution, not to runtime UI behavior such as compact-width layout or readability fallback.

## Design Direction

MHUI aims for a quiet interface:

- restrained color
- generous spacing
- low-noise surfaces
- clear text hierarchy
- stable composition rules

The default theme uses system typography, but its distinctiveness comes from hierarchy, spacing, geometry, and surface language rather than from stock SwiftUI control styling.
Apps can override the theme via `mhTheme(_:)`, but the customization surface is intentionally small.
MHUI should feel native first and refined second: interaction patterns stay close to SwiftUI defaults, while spacing, proportion, and surface treatment provide the package's personality.
The standard theme is built from package-owned neutral color assets plus the host app's tint color.
If a host app needs a fixed accent for a specific surface review, use `MHTheme.standard(accent: .fixed(...))`.
Detached surfaces prefer Liquid Glass by default through `mhGlassPolicy(.automatic)`.
That policy exists as a runtime readability switch, not as a low-level glass choreography API.
Compact width tuning lives in the shared theme defaults and internal resolvers so host apps do not need local fallback workarounds for common rows and actions.

Its design attitude is informed by calm, functional retail and editorial environments.
That influence is about atmosphere only: whitespace, calmer typography, subtle structural accent placement, and practical composition.
MHUI must not copy their layouts, information architecture, or visual motifs directly.

## Public Building Blocks

- `MHDesignMetrics`, `MHSpacingMetrics`, `MHCornerRadiusMetrics`, `MHLayoutMetrics`
- `MHScreenLayoutMetrics`, `MHSurfaceLayoutMetrics`, `MHControlLayoutMetrics`
- `MHSpacingRole`, `MHCornerRadiusRole`, `MHLayoutMode`
- `mhDesignMetrics(_:)` and `@Environment(\.mhDesignMetrics)`
- `MHTheme`, `MHColorReference`, `MHTextRole`, `MHColorRole`
- `mhTextStyle(_:colorRole:)`
- `MHGlassPolicy`, `mhGlassPolicy(_:)`
- `MHActionButtonStyle` and `ButtonStyle` sugar like `.mhPrimary`
- `MHActionPresentation`, `mhActionPresentation(_:)`
- `mhSurface(role:)` and `mhSurfaceInset()`
- `mhInputChrome(state:)`
- `mhBadge(style:)`
- `mhRow()`, `mhRowOverline()`, `mhRowTitle()`, `mhRowSupporting()`, `mhRowValue()`
- `MHKeyValueLayoutPolicy`, `mhKeyValueLayout(_:)`, `LabeledContentStyle.mhKeyValue`
- `mhGroupedRows()`
- `mhSectionHeader()`, `mhSectionHeaderTitle()`, `mhSectionHeaderSupporting()`, `mhSectionFooterText()`
- `mhSection(...)`
- `MHActionGroup`, `MHActionGroupLayout`
- `mhScreen(...)`
- `mhListChrome(...)`, `mhFormChrome(...)`
- `mhEmptyStateLayout()`

## Preview Model

- Keep MHDesign tuning previews in `+Preview.swift` sidecar files beside the edited metrics type or environment bridge, with only minimal shared helpers in `MHDesign/Sources/PreviewSupport`.
- Put the first MHUI development preview for a public primitive or layout API at the end of its implementation file under `// MARK: - Preview`.
- Reserve `MHUI/Sources/PreviewSupport` for shared preview styling helpers such as `MHPreviewStyle`, `MHPreviewCatalog`, and fixed-width validation previews that compare multiple runtime scenarios.
- Use `.mhPreviewSurface()` for component and chrome review.
- Use `.mhPreviewTint()` for screen-level composition or previews that should not add an extra background surface.

## Modifier Heuristics

- Prefer a direct `View` extension when the API only writes environment values or adds a light styling chain that stays clearer without an extra type.
- Keep a private `ViewModifier` when the implementation reads environment values, resolves adaptive layout, bundles multiple visual steps such as padding/background/overlay/animation, or is shared by multiple public entry points.
- Canonical direct-extension examples: `mhTheme(_:)`, `mhGlassPolicy(_:)`, `mhActionPresentation(_:)`, `mhKeyValueLayout(_:)`.
- Canonical `ViewModifier` examples: `mhSurface(role:)`, `mhTextStyle(_:colorRole:)`, `mhScreen(...)`, `mhSection(...)`, `mhGroupedRows()`, `mhInputChrome(state:)`, `mhBadge(style:)`.

## Example

```swift
import MHUI
import SwiftUI

struct SettingsScreen: View {
    @Environment(\.mhDesignMetrics)
    private var metrics

    var body: some View {
        NavigationStack {
            List {
                Section {
                    Toggle("Use iCloud Sync", isOn: .constant(true))
                        .mhRow()

                    LabeledContent("Theme", value: "System")
                        .labeledContentStyle(.mhKeyValue)
                } header: {
                    VStack(alignment: .leading, spacing: metrics.spacing.control) {
                        Text("Preferences")
                            .mhSectionHeaderTitle()
                        Text("Standard controls keep their native behavior.")
                            .mhSectionHeaderSupporting()
                    }
                    .mhSectionHeader()
                } footer: {
                    Text("MHUI styles the layout, surfaces, and hierarchy around the controls.")
                        .mhSectionFooterText()
                }
            }
            .mhListChrome(
                title: "Workspace",
                subtitle: "Shared rhythm and low-noise hierarchy."
            )
        }
        .tint(.blue)
        .mhTheme(MHTheme.standard())
    }
}
```

If a sibling app does not want MHUI modifiers or chrome, import `MHDesign` directly and read `@Environment(\.mhDesignMetrics)`.
If a sibling app wants MHUI styling, import `MHUI` and use both `MHTheme` and `MHDesign` APIs from that one module.
Apply `.mhDesignMetrics(...)` when a subtree needs layout-only overrides. MHUI components follow the same active metrics automatically.

Metrics-only adopters can now define their own shared baseline directly:

```swift
import MHDesign
import SwiftUI

let editorialMetrics = MHDesignMetrics(
    spacing: .init(
        inline: 8,
        control: 16,
        content: 24,
        section: 32,
        screen: 48
    ),
    cornerRadius: .init(
        control: 8,
        surface: 18
    ),
    layout: .init(
        readableContentWidth: 680,
        compactWidthThreshold: 600,
        screen: .init(
            contentInsetHorizontal: 48,
            contentInsetVertical: 80,
            contentSpacing: 56,
            compactContentInsetHorizontal: 16,
            compactContentInsetVertical: 32,
            compactContentSpacing: 24
        ),
        surface: .init(
            insetHorizontal: 24,
            insetVertical: 24,
            compactInsetHorizontal: 16,
            compactInsetVertical: 16
        ),
        control: .init(
            minimumTouchTarget: 44
        )
    )
)
```

Use `mhScreen(...)` and `mhSection(...)` when a screen should be composed from stacks and calm card-like surfaces instead of a native `List` or `Form`.

## Where To Tune First

Start in this order when adjusting appearance:

1. `MHDesignMetrics.standard` when an app only needs shared spacing, corner radius, or layout numbers.
   Or create a custom `MHDesignMetrics(...)` when the host app needs its own shared baseline without taking MHUI chrome.
2. The MHDesign `+Preview.swift` sidecar beside the edited metrics file when tuning spacing, radius, layout, or environment overrides without MHUI chrome.
3. `MHTheme.standard()` or `MHTheme.standard(accent:)` for default color, spacing, corner radius, layout, and surface recipes.
4. The colocated preview at the end of the edited MHUI implementation file for fast local iteration.
5. Validation previews at fixed widths `760`, `375`, and `320` when you need cross-scenario regression review.
6. Internal shared resolvers for row chrome, surface fill, action fallback, and key-value fallback only when a shared token is not enough.

The most useful previews to review first are `Screen Validation`, `Action Buttons Validation`, `Action Group Validation`, `Key Value Validation`, and `Native Container Validation`.

## Intentional Boundaries

MHUI does not currently provide:

- replacement controls that shadow `Button`, `TextField`, `Toggle`, or `List`
- navigation shells
- validation engines
- search components
- async image components
- art-direction preset collections
- low-level glass choreography APIs
- app-specific feature views

Those can be added later only if they strengthen the shared visual language without turning MHUI into a generic mega framework.

## Requirements

- Xcode with Swift 6.2 and the current iOS, macOS, and watchOS SDKs needed by
  SwiftUI Liquid Glass symbols
- iOS 18, macOS 15, and watchOS 11 remain the package deployment targets
- `swiftlint` installed if you want to run retained repository rule checks
- `pre-commit` installed if you want `verify.sh` to execute repository hooks

## Build and Test

Use Xcode and XcodeBuildMCP for Apple build, test, run, Simulator, runtime log,
screenshot, and UI snapshot verification.

For MHUI package compile checks, use XcodeBuildMCP `build_sim` with
`.swiftpm/xcode/package.xcworkspace` and the `MHUI-Package` scheme. For package
tests, use XcodeBuildMCP `test_sim` with the same workspace and scheme.

The remaining helper scripts in `ci_scripts/` are retained for repository rules
and compatibility wrappers that are not naturally covered by XcodeBuildMCP.

For SwiftLint formatting before final verification:

```sh
bash ci_scripts/tasks/format_swift.sh
```

For retained repository rule checks:

```sh
bash ci_scripts/tasks/check_repository_rules.sh
```

For pre-commit plus retained repository rule checks:

```sh
bash ci_scripts/tasks/verify.sh
```

If you only need the repository hooks:

```sh
bash ci_scripts/tasks/pre_commit.sh
```

If you only need strict SwiftLint:

```sh
bash ci_scripts/tasks/lint_swift.sh
```

The compatibility shell build and test wrappers are kept for cases where MCP is
unavailable or the available MCP tool surface does not cover the check.

For the compatibility package build, watchOS simulator compile-only check, and
optional macOS example app build:

```sh
bash ci_scripts/tasks/build_app.sh
```

For compatibility Xcode package tests:

```sh
bash ci_scripts/tasks/test_shared_library.sh
```

If you only need the SwiftUtilities boundary guard self-test:

```sh
bash ci_scripts/tasks/test_swiftutilities_boundary.sh
```

If you only need to verify that an external SwiftPM consumer can depend on MHUI
alone:

```sh
bash ci_scripts/tasks/test_mhui_consumer_adoption.sh
```

### Script Cache Layout

Compatibility shell build and test scripts may write generated artifacts under
`.build/ci/shared/`.
Shared caches and build state live under `cache/`, `DerivedData`, `tmp`, and
`home`, with result bundles under `results` when a shell wrapper creates them.

## Architecture Docs

- [Current repository overview](Designs/Overviews/mhui-current-overview.md)
- [Architecture guide](Designs/Architecture/ARCHITECTURE_GUIDE.md)
- [Shared presentation design](Designs/Architecture/shared-presentation-design.md)
- [ADR 0001: Shared package source of truth](Designs/Decisions/0001-shared-package-source-of-truth.md)
- [ADR 0002: Host apps own product behavior](Designs/Decisions/0002-host-apps-own-product-behavior.md)
- [ADR 0003: Example integrations stay outside package](Designs/Decisions/0003-example-integrations-stay-outside-package.md)
- [ADR 0004: Host screens own product meaning](Designs/Decisions/0004-host-screens-own-product-meaning.md)
- [ADR 0005: SwiftUtilities presentation boundary](Designs/Decisions/0005-swiftutilities-presentation-boundary.md)
