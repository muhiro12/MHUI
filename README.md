# MHUI

## Overview

MHUI is a narrow runtime presentation kit for calm, tool-like SwiftUI apps.
It is intentionally opinionated, intentionally small, and biased toward a
shared visual language rather than product behavior. Its standard theme pairs
system typography with bright achromatic planes, dark-ink hierarchy, neutral
rules, restrained geometry, and selective use of the host app's accent color.

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
- package-owned achromatic color assets and validation previews

MHUI does not own host-app behavior:

- business logic, domain models, persistence, networking, or analytics
- product-specific navigation meaning or screen shells
- art-direction presets or branding systems
- replacement controls that shadow native SwiftUI controls
- generic Foundation, SwiftData, image, string, numeric, or utility helpers
- low-level Liquid Glass choreography APIs

See [Architecture Guide](Designs/Architecture/ARCHITECTURE_GUIDE.md) for the
full package boundary, preview rules, modifier guidance, and SwiftUtilities
boundary decisions. See [Beta Release Notes](Designs/Guides/BETA_RELEASE_NOTES.md)
for current beta changes and migration notes.

## Repository Layout

- `MHDesign/Sources` - shared metrics and environment bridge
- `MHDesign/Tests` - metrics and environment tests
- `MHUI/Sources` - styled presentation APIs built on `MHDesign`
- `MHUI/Resources` - package-owned assets for standard theme resources
- `MHUI/Tests` - MHUI package tests
- `ci_scripts/` - retained repository rules, SwiftLint helpers, and wrappers
- `Designs/` - architecture guide, current overview, and ADRs
- `Examples/MHUIAdoptionSample` - source-only public API adoption sample

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
one import is enough for both metrics and styled APIs.

### Styled Golden Path

The visible MHUI language comes from composing its semantic screen, section,
row, input, summary, and action treatments. Start with that complete path before
tuning individual tokens.

```swift
import MHUI
import SwiftUI

struct OverviewScreen: View {
    @Environment(\.mhTheme)
    private var theme

    var body: some View {
        VStack(
            alignment: .leading,
            spacing: theme.spacing.section
        ) {
            MHSummary(
                "Focused work",
                metadata: "OVERVIEW",
                supporting: "A concise hierarchy for the current context."
            ) {
                Text("Ready")
                    .mhBadge(style: .accent)
            }

            MHGroupedRows {
                LabeledContent("Type", value: "System")
                    .labeledContentStyle(.mhKeyValue)

                Toggle("Native controls", isOn: .constant(true))
            }
            .mhSection(
                "Composition",
                supporting: "Shared rhythm without replacing native controls."
            )

            TextField("Add a note", text: .constant(""))
                .mhInputChrome()

            MHActionGroup {
                Button("Continue") {
                    // Perform the primary action.
                }
                .buttonStyle(.mhPrimary)

                Button("Review") {
                    // Perform the secondary action.
                }
            }
        }
        .mhScreen(
            "Workspace",
            subtitle: "Measured spacing and low-noise hierarchy."
        )
    }
}
```

`MHGroupedRows` applies row chrome to its direct children. `MHActionGroup`
defaults unstyled buttons to the secondary role, so only primary, quiet, or
destructive exceptions need an explicit button style. Treat each direct child
of `MHGroupedRows` as one row; do not nest another row-styled view inside it.
`MHSummary` is a ruled editorial lead rather than an elevated card.
Use its title for context that differs from the navigation title; omit the
summary when it would only repeat the current item name. `mhBadge` styles one
metadata token, while the host app owns metadata priority and adaptive badge
arrangement.

Use `MHFeatureGrid` when one piece of content needs to remain visually primary
beside a small supporting set. It uses a split composition at regular widths,
stacks the leading feature above up to two supporting columns in compact layouts,
and uses one supporting column at accessibility text sizes. The container owns
only hierarchy, spacing, and fallback; adopters still provide semantic content
and choose any surface or control treatment explicitly.

### Root Configuration and App Accent

Apply the standard theme once near the app root. This is MHUI's canonical
root-first styling entry point. It propagates the complete theme, synchronizes
its `MHDesignMetrics`, and applies an explicitly configured asset accent to
native-control tint. Every MHUI component in the subtree reads that baseline,
and a narrower `.mhTheme(...)` call overrides it through normal SwiftUI
environment scoping.

The root call applies everything that SwiftUI can safely inherit without
guessing product meaning. It does not install blanket button, font, foreground,
list, or form styles. Those modifiers would also affect toolbars, menus, system
presentations, and controls whose primary, secondary, or destructive role
cannot be inferred at the root.

The achromatic base and system typography remain package-owned defaults. The
host app continues to own its identity through its `AccentColor` asset.

```swift
import MHUI
import SwiftUI

@main
struct WorkspaceApp: App {
    var body: some Scene {
        WindowGroup {
            OverviewScreen()
                .mhTheme(.standard)
        }
    }
}
```

For an app-specific accent pair, keep both colors in the app's asset catalog
and pass their generated resource symbols to
`MHTheme.standard(accent:onAccent:)`:

```swift
let appTheme = MHTheme.standard(
    accent: .asset(.actionAccent),
    onAccent: .asset(.actionOnAccent)
)
```

The app owns both assets and must verify their contrast in supported
appearances. MHUI does not accept RGB or hexadecimal color definitions in
source.

Visible MHUI structure requires one explicit route at the screen boundary.
Use signature composition for the normal MHUI-forward route, and leave a
specialized native subtree outside those structural modifiers when it must
retain an OS-standard presentation. A local theme or asset-backed `.tint(...)`
is available when that subtree also needs a deliberate color exception.

Decorative hierarchy stays achromatic: headings use dark ink and cues use
neutral rules. Reserve the app accent for semantic status, focus, native
controls, and the primary action instead of applying it to every heading or
surface.

### Prefer the Signature Composition

Choose from the screen's purpose, not its existing container.

| Screen purpose | MHUI route | Role |
| --- | --- | --- |
| Overview, dashboard, read-only detail, report, insight, or product tool | `mhScreen`, `mhSection`, `MHSummary`, `MHFeatureGrid`, `MHGroupedRows` | Primary signature composition |
| Collection or hierarchy that needs selection, swipe actions, editing, reordering, or list navigation | `mhListChrome`, `MHSectionHeader`, `MHSectionFooter`, `mhRow` | Secondary native bridge |
| Data entry, settings, or inspector that benefits from native form behavior | `mhFormChrome`, `MHSectionHeader`, `MHSectionFooter`, `mhRow` | Secondary native bridge |

An existing `List` or `Form` does not decide the route. The signature
composition is the visible MHUI product and is the normal choice for
MHUI-forward apps. Native bridges intentionally preserve more OS-standard
appearance in exchange for concrete container behavior.

Signature composition keeps native controls, navigation, toolbars, search,
sheets, and system presentations. MHUI owns the surrounding hierarchy, rhythm,
surfaces, and semantic emphasis instead of replacing those controls.

Do not place a `List` or `Form` inside `mhScreen`; each route already owns its
screen-level scrolling and chrome.

`mhScreen` can supply a page title for a stack-based composition. Native
`List` and `Form` routes keep page titles and any screen-specific lead content
in the host app so their scroll view remains edge to edge.

When a screen materially depends on a native container, preserve its behavior
and apply MHUI at the presentation seams:

```swift
import MHUI
import SwiftUI

struct SettingsScreen: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Toggle("Use iCloud Sync", isOn: .constant(true))
                        .mhRow()

                    LabeledContent("Theme", value: "System")
                        .labeledContentStyle(.mhKeyValue)
                } header: {
                    MHSectionHeader(
                        "Preferences",
                        supporting: "Native controls keep their behavior."
                    )
                } footer: {
                    MHSectionFooter(
                        "MHUI styles layout, surfaces, and hierarchy."
                    )
                }
            }
            .mhListChrome()
            .navigationTitle("Workspace")
        }
    }
}
```

See the [Adoption Guide](Designs/Guides/ADOPTION_GUIDE.md) for staged migration,
the `Form` route, component ownership, migration notes, and the review
checklist. The source-only
[adoption sample](Examples/MHUIAdoptionSample/Package.swift) can be opened as a
Swift package and does not require an Xcode project.

## Tuning

`MHTheme.standard` is ready to use as a package-owned visual baseline. It keeps
Apple's system type styles and native controls while giving apps a distinct
bright surface hierarchy, measured spacing, dark-ink headings, and neutral
leading-edge rules.

Start with that baseline and customize its public semantic groups:

- `colors` for semantic backgrounds, surfaces, text, accent, warning, and
  destructive colors
- `typography` for Dynamic Type-compatible system text roles, the stronger
  `summaryTitle` role, and optional system monospaced metadata; action buttons
  use `bodyStrong`
- `metrics` for shared spacing, corner radius, and generic layout
- `presentation` for MHUI row, action, key-value, and cue placement
- `divider`, `motion`, and `surfaces` for package-owned treatments

Use `MHTheme.standard(metrics:)` when an app already has an `MHDesignMetrics`
baseline. The no-argument standard theme uses `MHColorReference.tint`, leaving
the app's `AccentColor` asset under host-app control without installing a tint
override. If an app intentionally stores a concrete accent in its theme, use
`MHTheme.standard(accent:onAccent:)` and provide the foreground that remains
legible on that accent. A concrete accent makes the theme the source of truth
for both MHUI colors and native-control tint; the app must verify the accent
and on-accent pair in light, dark, and Increase Contrast appearances.

Theme values and MHDesign metrics propagate automatically, but structural and
semantic selection stays explicit. In practice, a styled screen adds one
screen route such as `mhScreen`, then uses APIs such as
`.buttonStyle(.mhPrimary)`, `.mhSurface()`, and
`.labeledContentStyle(.mhKeyValue)` only where their meaning is known. Direct
children of `MHGroupedRows` receive row chrome from the container, and unstyled
buttons in `MHActionGroup` receive the secondary role. A specialized native
subtree opts out by omitting the MHUI structural or semantic modifier; MHUI
does not replace the native control itself.

For a standalone label, SF Symbol, or shape, use
`.mhForegroundStyle(_:)` to resolve a semantic role from the active theme
without also applying typography. Use `.mhTint(_:)` for a deliberate local
native-control tint exception. Both modifiers keep the underlying colors in
asset catalogs through the theme instead of defining a new color in source.

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

Build the nested public API adoption sample directly with:

```sh
bash ci_scripts/tasks/test_mhui_consumer_adoption.sh
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

- [Adoption guide](Designs/Guides/ADOPTION_GUIDE.md)
- [Current repository overview](Designs/Overviews/mhui-current-overview.md)
- [Architecture guide](Designs/Architecture/ARCHITECTURE_GUIDE.md)
- [Shared presentation design](Designs/Architecture/shared-presentation-design.md)
- [ADR 0001: Shared package source of truth](Designs/Decisions/0001-shared-package-source-of-truth.md)
- [ADR 0002: Host apps own product behavior](Designs/Decisions/0002-host-apps-own-product-behavior.md)
- [ADR 0003: Example integrations stay outside package](Designs/Decisions/0003-example-integrations-stay-outside-package.md)
- [ADR 0004: Host screens own product meaning](Designs/Decisions/0004-host-screens-own-product-meaning.md)
- [ADR 0005: SwiftUtilities presentation boundary](Designs/Decisions/0005-swiftutilities-presentation-boundary.md)
- [ADR 0006: Root theme propagation](Designs/Decisions/0006-root-theme-propagation.md)
