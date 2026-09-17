# MHUI

## Overview

MHUI is a narrow runtime presentation kit for calm, tool-like SwiftUI apps.
It is intentionally opinionated, intentionally small, and biased toward a
shared visual language rather than product behavior. Its standard theme pairs
system typography with luminous low-chroma planes, dark-ink hierarchy, quiet
boundaries, restrained geometry, and selective use of the host app's accent color.

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
- package-owned low-chroma color assets and validation previews

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
Its `START HERE` previews are the canonical visual review surface. Preview files
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
older systems retain the non-glass treatment. Standard content surfaces remain
non-glass under all policies. Existing call sites need no changes for content
actions; floating actions that relied on automatic glass must opt in.

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

The low-chroma base and system typography remain package-owned defaults. The
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

Decorative hierarchy stays low-chroma and relies on proportion, whitespace,
and tonal depth. Reserve the app accent for semantic status, focus, native
controls, and the primary action instead of applying it to every heading or
surface.

### Choose a Screen Route

Choose one route for each screen. All MHUI routes share the root theme; apps do
not assemble degrees of MHUI styling by decorating individual native rows.

| Route | Use | Ownership |
| --- | --- | --- |
| System | Native `List` or `Form` without MHUI chrome | SwiftUI owns the complete container appearance |
| Native MHUI | `List.mhListChrome()` or `Form.mhFormChrome()` | MHUI supplies the canvas; SwiftUI owns rows, sections, selection, and style |
| Signature composition | `mhScreen`, `mhSection`, `MHSummary`, `MHGroupedRows` | MHUI owns content hierarchy, spacing, and surfaces around native controls |

Use native `Section`, `Text`, and `LabeledContent` in the native MHUI route.
Do not add `mhRow`, MHUI section typography, or the `mhKeyValue` style to this
route. These building blocks belong to signature compositions. Keep native
navigation titles and do not wrap a `List` or `Form` in `mhScreen`.

In a split view, leave the sidebar system-owned and apply MHUI chrome to the
content or detail containers. SwiftUI retains automatic style adaptation.

```swift
Form {
    Section("Preferences") {
        Toggle("Use iCloud Sync", isOn: $isSyncEnabled)
        LabeledContent("Theme", value: "System")
    }
}
.mhFormChrome()
.navigationTitle("Settings")
```

See the [Adoption Guide](Designs/Guides/ADOPTION_GUIDE.md) for staged migration,
the `Form` route, component ownership, migration notes, and the review
checklist. The source-only
[adoption sample](Examples/MHUIAdoptionSample/Package.swift) can be opened as a
Swift package and does not require an Xcode project.

## Tuning

`MHTheme.standard` is ready to use as a package-owned visual baseline. It keeps
Apple's system type styles and native controls while giving apps a distinct
luminous surface hierarchy, measured spacing, and dark-ink headings.

Choose one palette at the app root. Mist is the default; Slate, Linen, and Sage
provide cool, warm, and green-gray alternatives with the same hierarchy.

```swift
ContentView()
    .mhTheme(.standard(palette: .slate))
```

All four palettes include light, dark, and increased-contrast colors. Increased
Contrast uses the shared neutral surface baseline to prioritize legibility.
The palette does not change the app tint or native row colors.

Use the standard baseline at the app root. Typography, spacing, motion, and
surface treatments are package-owned defaults, not per-screen tuning steps.
Existing low-level theme customization APIs remain source compatible, but are
not required for adoption. Request additional controls through a concrete issue
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
