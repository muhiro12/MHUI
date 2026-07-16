# MHUI

## Overview

MHUI is a narrow runtime presentation kit for calm, tool-like SwiftUI apps.
It is intentionally opinionated, intentionally small, and biased toward shared
visual language rather than product behavior.

The package exposes two library products:

- `MHDesign` provides shared spacing, corner radius, generic layout metrics,
  and the SwiftUI metrics environment bridge.
- `MHUI` provides semantic themes, styled presentation primitives,
  native-container chrome, compact-width fallback behavior, and the `MHDesign`
  re-export.

The package supports iOS 18+, macOS 15+, and watchOS 11+.

## Responsibility Boundary

MHUI owns shared presentation rules that can apply across sibling apps:

- semantic theme application through `MHTheme.standard(...)`
- text, surface, row, section, screen, and native-container chrome
- action, key-value, row, cue, and compact-width fallback behavior
- package-owned color assets and validation previews

MHUI does not own host-app behavior:

- business logic, domain models, persistence, networking, or analytics
- product-specific navigation meaning or screen shells
- art-direction presets or branding systems
- replacement controls that shadow native SwiftUI controls
- generic Foundation, SwiftData, image, string, numeric, or utility helpers
- low-level Liquid Glass choreography APIs

See [Architecture Guide](Designs/Architecture/ARCHITECTURE_GUIDE.md) for the
full package boundary, preview rules, modifier guidance, and SwiftUtilities
boundary decisions.

## Repository Layout

- `MHDesign/Sources` - shared metrics and environment bridge
- `MHDesign/Tests` - metrics and environment tests
- `MHUI/Sources` - styled presentation APIs built on `MHDesign`
- `MHUI/Resources` - package-owned assets for standard theme resources
- `MHUI/Tests` - MHUI package tests
- `ci_scripts/` - retained repository rules, SwiftLint helpers, and wrappers
- `Designs/` - architecture guide, current overview, and ADRs
- `Example/` - optional consumer app when present; not a source of package truth

## Adoption

Use `MHDesign` directly when an app wants shared spacing, corner radius, generic
screen or surface layout, and the metrics environment bridge without MHUI chrome.

```swift
import MHDesign
import SwiftUI

struct MetricsOnlyView: View {
    @Environment(\.mhDesignMetrics)
    private var metrics

    var body: some View {
        VStack(spacing: metrics.spacing.content) {
            Text("Metrics only")
            Text("The host app owns the styling.")
        }
        .mhDesignMetrics(.standard)
    }
}
```

Use `MHUI` when an app wants the styled layer. `MHUI` re-exports `MHDesign`, so
one import is enough for both metrics and styled APIs. Define one app theme by
starting from the standard semantic baseline and changing only the values the
app owns.

```swift
import MHUI

extension MHTheme {
    static var app: Self {
        var theme = standard(accent: .fixed(
            lightHex: 0x2473E6,
            darkHex: 0x73ADFF
        ))
        theme.colors.surface = .fixed(
            lightHex: 0xF3F6FA,
            darkHex: 0x18202B
        )
        theme.typography.bodyStrong = .init(
            font: .title3,
            weight: .bold
        )
        theme.presentation.rowVerticalPadding = 18
        return theme
    }
}
```

Apply that theme once near the app root. It propagates through SwiftUI's
environment to MHUI components and synchronizes the tint of native controls
when the theme uses a concrete accent color.

```swift
import MHUI
import SwiftUI

@main
struct WorkspaceApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
                .mhTheme(.app)
        }
    }
}
```

Views still choose semantic intent explicitly. The theme decides what
`bodyStrong`, `surface`, `primary`, or `destructive` looks like; it does not
guess which role a screen element should use.

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
                    Text("MHUI styles layout, surfaces, and hierarchy.")
                        .mhSectionFooterText()
                }
            }
            .mhListChrome(
                "Workspace",
                subtitle: "Shared rhythm and low-noise hierarchy."
            )
        }
    }
}
```

Use `mhScreen(...)` and `mhSection(...)` when a screen should be composed from
stacks and calm surfaces instead of a native `List` or `Form`.

Apply another theme to a narrower subtree for an intentional exception. The
override follows normal SwiftUI environment scoping and leaves sibling views
on the app theme.

```swift
struct InspectorPane: View {
    var body: some View {
        InspectorContent()
            .mhTheme(.inspector)
    }
}
```

## Tuning

Start with `MHTheme.standard` and customize its public semantic groups:

- `colors` for semantic backgrounds, surfaces, text, accent, warning, and
  destructive colors
- `typography` for Dynamic Type-compatible text roles; action buttons use
  `bodyStrong`
- `metrics` for shared spacing, corner radius, and generic layout
- `presentation` for MHUI row, action, key-value, and cue layout
- `divider`, `motion`, and `surfaces` for package-owned treatments

Use `MHTheme.standard(metrics:accent:)` when an app already has an
`MHDesignMetrics` baseline. `MHColorReference.tint` deliberately inherits the
active SwiftUI tint. A fixed accent makes the theme the source of truth for
both MHUI colors and native-control tint.

Theme values propagate automatically, but semantic component selection stays
explicit. Continue applying APIs such as `.buttonStyle(.mhPrimary)`,
`.mhRow()`, `.mhSurface()`, and `.labeledContentStyle(.mhKeyValue)` where their
meaning is known. MHUI does not globally replace or restyle every native
SwiftUI control.

For visual review, start with the colocated preview beside the edited primitive
or layout API. Use validation previews when a change affects shared behavior
across widths, themes, or runtime contexts.

See [Shared Presentation Design](Designs/Architecture/shared-presentation-design.md)
for design direction and detailed tuning rules.

## Requirements

- Xcode with Swift 6.2 and the current Apple platform SDKs
- iOS 18, macOS 15, and watchOS 11 deployment targets
- `pre-commit` only if you want `verify.sh` to execute repository hooks

## Build and Test

Use the Xcode-native integration available in the agent environment as the
primary Apple build and test surface. Follow the selection and restoration
contract in `AGENTS.md`.

For MHUI package compile checks, use its build capability with:

- workspace: `.swiftpm/xcode/package.xcworkspace`
- scheme: `MHUI-Package`
- destination: a discovered iPhone Simulator

For package tests, use its test capability with the same workspace, scheme,
and destination family.

SwiftLint is resolved from the `SimplyDanny/SwiftLintPlugins` package declared
in `Package.swift`; the scripts do not require a separately installed
`swiftlint` binary on `PATH`.

Run retained repository rule checks with:

```sh
bash ci_scripts/tasks/check_repository_rules.sh
```

Format Swift files before final verification with:

```sh
bash ci_scripts/tasks/format_swift.sh
```

Run the compatibility pre-commit plus repository-rule wrapper with:

```sh
bash ci_scripts/tasks/verify.sh
```

Compatibility shell build and test wrappers remain available for cases where
the Xcode-native integration is unavailable or does not cover the check. They
may write disposable cache and result data under `.build/ci/shared/`.

## Architecture Docs

- [Current repository overview](Designs/Overviews/mhui-current-overview.md)
- [Architecture guide](Designs/Architecture/ARCHITECTURE_GUIDE.md)
- [Shared presentation design](Designs/Architecture/shared-presentation-design.md)
- [ADR 0001: Shared package source of truth](Designs/Decisions/0001-shared-package-source-of-truth.md)
- [ADR 0002: Host apps own product behavior](Designs/Decisions/0002-host-apps-own-product-behavior.md)
- [ADR 0003: Example integrations stay outside package](Designs/Decisions/0003-example-integrations-stay-outside-package.md)
- [ADR 0004: Host screens own product meaning](Designs/Decisions/0004-host-screens-own-product-meaning.md)
- [ADR 0005: SwiftUtilities presentation boundary](Designs/Decisions/0005-swiftutilities-presentation-boundary.md)
- [ADR 0006: Root theme propagation](Designs/Decisions/0006-root-theme-propagation.md)
