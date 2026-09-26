# MHUI

## Overview

MHUI is a narrow runtime presentation kit for calm, tool-like SwiftUI apps.
It is intentionally opinionated, intentionally small, and biased toward a
shared visual language rather than product behavior. Its standard theme pairs
system typography with an achromatic foundation: neutral planes and text shaped
by geometry, spacing, proportion, and useful hierarchy. Color comes from the
host app's accent and from semantic warning and destructive status.

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
- action, key-value, row, and compact-width fallback behavior
- package-owned achromatic color assets, semantic status colors, and
  validation previews

MHUI does not own host-app behavior:

- business logic, domain models, persistence, networking, or analytics
- product-specific navigation meaning or screen shells
- art-direction presets or branding systems
- replacement controls that shadow native SwiftUI controls
- generic Foundation, SwiftData, image, string, numeric, or utility helpers
- low-level Liquid Glass choreography APIs

See [Visual Design Principles](Designs/Guides/VISUAL_DESIGN_PRINCIPLES.md) for
the presentation direction. See
[Architecture Guide](Designs/Architecture/ARCHITECTURE_GUIDE.md) for the full
package boundary, preview rules, modifier guidance, and SwiftUtilities boundary
decisions.

## Repository Layout

- `MHDesign/Sources` - shared metrics and environment bridge
- `MHDesign/Tests` - metrics and environment tests
- `MHUI/Sources` - styled presentation APIs built on `MHDesign`
- `MHUI/Resources` - package-owned assets for standard theme resources
- `MHUI/Tests` - MHUI package tests
- `MHUI/Sources/PreviewSupport/DesignReview` - the single design-system review entry point
- `MHUI/Sources/PreviewSupport/Diagnostics` - focused comparison and regression previews
- `ci_scripts/` - retained repository rules, SwiftLint helpers, and wrappers
- `Designs/` - architecture guide, current overview, and ADRs
- `Examples/MHUIAdoptionSample` - source-only public API adoption sample

## Design Review

For the overall MHUI direction, open
`MHUI/Sources/PreviewSupport/DesignReview/MHSignatureCompositionPreview.swift`.
Its `START HERE` previews are the canonical visual review surface. They cover
modest and dense content, compact and wide layouts, dark mode, accessibility
text sizes, and right-to-left layout with the neutral standard theme; a separate host-accent preview shows how
an app's accent pair integrates. Preview files
under `Diagnostics` compare specific conditions and are not competing design
directions. Use the Canvas environment overrides for Increase Contrast and
Reduce Transparency; these system accessibility values are read-only in app
code.

To review app-like navigation using only public APIs, open
`Examples/MHUIAdoptionSample/Sources/MHUIAdoptionSample/MHUIDesignReviewPreview.swift`.
`MHUIDesignReviewRoot` provides one tab-based entry point for the preferred
composition, representative reading, empty, and action-heavy states, the native
Form bridge, and the unstyled theme baseline.

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
tuning individual tokens. Start with the
[root configuration](#root-configuration-and-app-accent), including the one-time
iOS navigation title setup, then choose the screen composition below.

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
                metadata: "Overview",
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

`mhSection` arranges headings and content on the canvas without an implicit
card. `MHGroupedRows` applies vertical row chrome to its direct children; the
parent owns horizontal insets. Add `mhSurfaceInset()` and `mhSurface()` to a
group only when it needs a distinct plane. `MHActionGroup`
defaults unstyled buttons to the secondary role, so only primary, quiet, or
destructive exceptions need an explicit button style. Treat each direct child
of `MHGroupedRows` as one row; do not nest another row-styled view inside it.
`MHSummary` is a spacious editorial lead rather than an elevated card.
Use its title for context that differs from the navigation title; omit the
summary when it would only repeat the current item name. `mhBadge` styles one
metadata token, while the host app owns metadata priority and adaptive badge
arrangement.

Action styles use non-glass fills under the default `.automatic` glass policy,
including on systems that support Liquid Glass. For controls in a floating
functional layer, explicitly apply `.mhGlassPolicy(.enabled)` to that control
or its bounded action group. Avoid enabling it at the app root when ordinary
content actions should remain non-glass. `.disabled`, Reduce Transparency, and
older systems retain the non-glass treatment. Content surfaces, the screen
canvas, badges, and inputs never use Liquid Glass under any policy, and
`MHTheme.SurfaceTreatment` has no glass options.

Use `MHFeatureGrid` when one piece of content needs to remain visually primary
beside a small supporting set. It uses a split composition at regular widths,
stacks the leading feature above up to two supporting columns in compact layouts,
and uses one supporting column at accessibility text sizes. The container owns
only hierarchy, spacing, and fallback; adopters still provide semantic content
and choose any surface or control treatment explicitly.

### Choose Container Presentation

MHUI has two visual choices with one shared color foundation. Stack-based
content uses `mhScreen`; List and Form use the same content wrapper with either
choice below. Native behavior and visual presentation are separate choices:

- `.mhListChrome(.native)` and `.mhFormChrome(.native)` preserve platform grouping and row geometry with MHUI
  canvas and row colors. Pass `.native` explicitly; no-argument calls use
  `.content`.
- `.mhListChrome(.content)` uses a plain native list with the MHUI canvas.
  Wrap its content once in `MHContainerContent` to style complete rows.
- `.mhFormChrome(.content)` supplies the canvas while the app chooses the
  native form style and fields. `MHContainerContent` applies the row surfaces.

A main collection and a settings screen can choose different presentation
under one root theme. Apply content chrome inside each navigation destination
or split-view column, preserving native sidebars, dividers, toolbars, and tabs.
`MHSummary` leaves outer spacing to its composition: automatic container rows
provide it in a list; use `mhSurfaceInset()` on a surface. See the [adoption guide](Designs/Guides/ADOPTION_GUIDE.md)
and the content list/editor in the public sample for complete examples.

```swift
NavigationStack {
    Form {
        MHContainerContent {
            Section("General") {
                TextField("Name", text: $name)
                Toggle("Keep offline", isOn: $keepsOffline)
                LabeledContent("Documents", value: "3")
            }
        }
    }
    .mhFormChrome(.content)
    .navigationTitle("Settings")
}
.mhTheme(.standard)
```

Here `name` and `keepsOffline` are app-owned bindings. Change `.content` to
`.native` to keep native grouping and row geometry with the same MHUI colors. No per-row
`mhRow()` or labeled-content style is needed. Both choices use the MHUI canvas
and themed row surfaces; `.native` retains platform row geometry and typography.
Default toggle and labeled-content labels use MHUI colors, and native controls
receive the app accent. Plain text retains its own foreground semantics. Use the same content wrapper
inside `List`. Standard `Section` headers are valid; `MHSectionHeader` adds the
shared title/supporting hierarchy when useful. See the
[container contract and limits](Designs/Guides/ADOPTION_GUIDE.md#automatic-container-content)
for advanced sections and mixed styling.

For a section with only a footer, use `mhSectionWithFooter("Title") { ... }`.
Use `mhSection` for header-only, accessory-only, or accessory-and-footer
sections. These call shapes stay distinct after trailing-closure formatting.

### Screen Titles and Scrolling

Place `mhScreen("Library")` inside the app's `NavigationStack` or split-view
column. Its title uses native navigation presentation by default, including
large-to-inline title transitions on iOS. MHUI owns the scrolling content,
subtitle, readable width, and spacing; the app owns navigation and toolbar actions.
Do not repeat that title in a content heading. For a standalone composition
without navigation, explicitly use `titlePlacement: .content`; that heading
scrolls out of view. This option does not simulate a navigation bar.

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
    init() {
        #if os(iOS)
        MHTheme.standard.configureNativeAppearance()
        #endif
    }

    var body: some Scene {
        WindowGroup {
            OverviewScreen()
                .mhTheme(.standard)
        }
    }
}
```

On iOS, call `configureNativeAppearance()` once before creating UI,
using the same theme as the root. It applies the theme's primary text color to
large and inline native navigation titles and UIKit text inputs, including
`.native` screens. It also requests secondary color for unselected tab items;
newer system tab renderers can retain their own foreground.
This UIKit default is application-wide; local `mhTheme` overrides do not change
it. It preserves system title fonts, scrolling behavior, bar backgrounds, and
button tint. Existing bars and explicit per-bar appearance settings are not
overridden. macOS and watchOS retain their platform title presentation.

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
Choose MHUI content inside native containers or a stack-based composition
for the main experience, and use native presentation where familiar system
appearance serves the screen. A local theme or asset-backed `.tint(...)`
is available when that subtree also needs a deliberate color exception.

Hierarchy stays achromatic and relies on proportion, spacing, type, and
neutral tone. Reserve the app accent for semantic status, focus, native
controls, and the primary action instead of applying it to every heading or
surface.

### Choose a Screen Route

Choose appearance by screen purpose and container behavior independently.
All routes share the root theme, and an app can mix them across destinations.
The no-argument chrome modifiers choose MHUI content. Pass `.native` explicitly
for themed native container presentation. Both choices retain MHUI text colors; selected
rows adapt to prominent native backgrounds without per-row configuration.

| Route | Use | Ownership |
| --- | --- | --- |
| Themed native | `mhListChrome(.native)` or `mhFormChrome(.native)` with `MHContainerContent` | SwiftUI owns grouping and row geometry; MHUI supplies canvas, row surfaces, and styled text colors |
| MHUI content | `mhListChrome(.content)` or `mhFormChrome(.content)` with MHUI rows and headers | MHUI supplies hierarchy and rhythm while SwiftUI retains scrolling, selection, and controls |
| Stack composition | `mhScreen`, `mhSection`, `MHSummary`, `MHGroupedRows` | MHUI supplies freely arranged content hierarchy around native controls |

MHUI row, section, and labeled-content styles are supported in List and Form.
Use `MHContainerContent` once inside the native container, or opt individual
rows into `mhRow()` when the screen needs mixed treatments.
Do not wrap a `List` or `Form` in `mhScreen`, which owns a separate scroll view.

In a split view, leave navigation chrome system-owned and apply content
presentation inside each content or detail column. The content list chooses
plain styling; the app can explicitly select another list style afterward.

```swift
Form {
    MHContainerContent {
        Section("Preferences") {
            Toggle("Use iCloud Sync", isOn: $isSyncEnabled)
            LabeledContent("Theme", value: "System")
        }
    }
}
.mhFormChrome(.native)
.navigationTitle("Settings")
```

See the [Adoption Guide](Designs/Guides/ADOPTION_GUIDE.md) for staged migration,
the `Form` route, component ownership, migration notes, and the review
checklist. Apps upgrading from 1.x should start with
[Migration to 2.0](Designs/Guides/ADOPTION_GUIDE.md#migration-to-20). The source-only
[adoption sample](Examples/MHUIAdoptionSample/Package.swift) can be opened as a
Swift package and does not require an Xcode project.

## Tuning

`MHTheme.standard` is ready to use as a package-owned visual baseline. It keeps
Apple's system type styles and native controls while giving apps a neutral
surface hierarchy, measured spacing, and clear type hierarchy.

The standard foundation is achromatic. Every package-owned background, surface,
border, and text color has equal red, green, and blue channels in light, dark,
and Increase Contrast appearances. Brand color comes only from the host accent
pair; warning and destructive keep their semantic hues. Standard
surfaces and badges are borderless and differ by tone alone. Separators,
input boundaries, and pressed, focused, and disabled states remain. Increase
Contrast adds or strengthens a hairline outline on surfaces, badges, and inputs.

Use the standard baseline at the app root. Typography, spacing, motion, and
surface treatments are package-owned defaults. Screen purpose selects native
or MHUI content presentation; hosts can deliberately override theme values.
Low-level theme customization APIs remain available, but are not required for
adoption. Request additional controls through a concrete issue
when the standard routes cannot express a product requirement.

The standard theme inherits the app's tint. For an asset-backed brand accent,
use `MHTheme.standard(accent:onAccent:)` with a legible foreground color.

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
`swiftlint` binary on `PATH`. The optional pre-commit hooks delegate to the
same formatting and lint scripts so both entrypoints use this dependency.

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

## Releases

Starting with `1.20.0`, releases use `MAJOR.MINOR.PATCH` under the
[versioning contract](Designs/Architecture/ARCHITECTURE_GUIDE.md#versioning-contract).
Legacy two-component tags remain unchanged and count as patch zero when
calculating the next version.

After package tests, repository rules, public API compatibility review, and
applicable Preview checks pass, a push to `main` automatically creates the next
minor release (for example, `1.19` to `1.20.0`, then `1.21.0`). Breaking changes
must be held until a major release is explicitly selected. Patch releases also
require an explicit choice.

For an explicit major or patch release, create the intended three-component tag
on the verified commit **before** pushing, then push `main` and that tag together
with `git push --atomic origin main <version>`. The workflow honors the tag on
that commit instead of incrementing the minor version. Choose a version newer
than the latest published release; never move or reuse a published tag.

The workflow can be dispatched manually on `main` to retry a failed publication.
Reruns reuse an existing tag on the commit and do not increment it again.
Generated release notes should be supplemented with user-visible changes and
any adoption guidance.

Test version selection locally with:

```sh
python3 -m unittest discover -s ci_scripts/release -p 'test_*.py'
```

## Architecture Docs

- [Adoption guide](Designs/Guides/ADOPTION_GUIDE.md)
- [Visual design principles](Designs/Guides/VISUAL_DESIGN_PRINCIPLES.md)
- [Current repository overview](Designs/Overviews/mhui-current-overview.md)
- [Architecture guide](Designs/Architecture/ARCHITECTURE_GUIDE.md)
- [Shared presentation design](Designs/Architecture/shared-presentation-design.md)
- [ADR 0001: Shared package source of truth](Designs/Decisions/0001-shared-package-source-of-truth.md)
- [ADR 0002: Host apps own product behavior](Designs/Decisions/0002-host-apps-own-product-behavior.md)
- [ADR 0003: Example integrations stay outside package](Designs/Decisions/0003-example-integrations-stay-outside-package.md)
- [ADR 0004: Host screens own product meaning](Designs/Decisions/0004-host-screens-own-product-meaning.md)
- [ADR 0005: SwiftUtilities presentation boundary](Designs/Decisions/0005-swiftutilities-presentation-boundary.md)
- [ADR 0006: Root theme propagation](Designs/Decisions/0006-root-theme-propagation.md)

### Shared dimension baseline

MHDesign owns package dimensions on an 8-point grid. MHUI derives its spacing,
component padding, and minimum targets from those metrics. Zero spacing and
1-point strokes have separate roles; native control sizes and system text
styles remain platform-managed. See the
[dimension contract](Designs/Guides/VISUAL_DESIGN_PRINCIPLES.md#dimension-ownership-and-grid)
for responsive layout, accessibility, and host customization boundaries.
