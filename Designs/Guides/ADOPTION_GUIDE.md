# MHUI Adoption Guide

## Purpose

This guide turns an existing SwiftUI screen into a complete MHUI composition
without replacing native controls or moving product behavior into the package.
Native `List` and `Form` integration and stack-based composition are supported
routes. Choose the route that fits the content and platform behavior while
keeping the package's quiet semantic palette and rhythm.

The source-only
[MHUI adoption sample](../../Examples/MHUIAdoptionSample/Package.swift)
contains theme-only, stack-based, and native-container examples. It is a nested
Swift package, so no Xcode project is required.

## Choose the Package Product

Use `MHDesign` when an app only needs shared spacing, corner radius, generic
layout metrics, and the metrics environment bridge.

Use `MHUI` when an app wants the package's visible presentation language.
`MHUI` re-exports `MHDesign`, so styled adopters only need `import MHUI`.

## Understand the Root Theme

Apply one theme near the app root. This is the canonical MHUI styling entry
point:

```swift
import MHUI
import SwiftUI

@main
struct WorkspaceApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
                .mhTheme(.standard)
        }
    }
}
```

The call propagates colors, typography, metrics, presentation values, and
surface treatments to every MHUI component in the subtree. It also synchronizes
the `MHDesignMetrics` environment and, when the theme has a concrete
asset-backed accent, native-control tint. A narrower `.mhTheme(...)` call
overrides that baseline for one subtree through ordinary SwiftUI environment
scoping.

This is the maximum safe automatic application for arbitrary SwiftUI content.
MHUI does not apply root-wide button, font, foreground, list, or form styles:
those styles propagate into toolbars, menus, system presentations, and
controls whose semantic role the root cannot know. It also cannot insert
`mhScreen`, section hierarchy, or grouped-row structure around unknown
descendants.

Complete visible adoption therefore needs one explicit structural route at
each screen boundary. Within package-owned containers, MHUI removes repetition
where meaning is known: `MHGroupedRows` styles its direct children and
`MHActionGroup` gives otherwise unstyled buttons the secondary role.

### Preserve Native Presentation Locally

Do not turn off the root theme for an entire app because one screen needs
native presentation. Keep the `List`, `Form`, or control subtree
outside MHUI structural modifiers. It then retains its OS-selected container
and control styles while still receiving the shared metrics and ordinary app
tint.

If the subtree intentionally needs a different theme, apply
`.mhTheme(localTheme)` there. If only its native-control tint differs, apply a
local `.mhTint(...)` for a theme-owned semantic color, or
`.tint(Color(.settingsAccent))` using another generated app asset symbol.
Use `.mhForegroundStyle(...)` for a standalone label, symbol, or shape that
needs a semantic MHUI color without also taking an MHUI text style. Inside an
`MHActionGroup`, a button can likewise declare a deliberate native button
style instead of inheriting the group's secondary default.

### Keep the Accent App-Owned

The standard theme uses bright, fully achromatic package-owned base colors and
system typography. It resolves its accent from the host app's `AccentColor`
asset, so each app can keep its own identity without changing the neutral
canvas.

Dark-ink headings and neutral rules own the decorative hierarchy. Reserve the
app accent for semantic status, focus, native controls, and the primary action.
Do not use it as the default color for headings, metadata, rules, or surfaces.

If an app needs a dedicated accent pair, define both colors in its asset
catalog and pass the generated resource symbols to
`MHTheme.standard(accent:onAccent:)`:

```swift
let appTheme = MHTheme.standard(
    accent: .asset(.actionAccent),
    onAccent: .asset(.actionOnAccent)
)
```

The host app owns both assets and must verify that the pair remains legible in
light, dark, and Increase Contrast appearances. Do not define RGB or
hexadecimal colors in Swift source.

Start with the standard achromatic surfaces and system fonts. Tune semantic
theme values only after the complete composition is visible and reviewed.

## Choose Composition by Screen Purpose

Choose a route from the screen's purpose and required interaction semantics,
not from a requirement to display custom package chrome.

| Screen purpose | Route | Fit |
| --- | --- | --- |
| Collection, hierarchy, or grouped read-only detail | `mhListChrome` with native sections and rows | Platform grouping, scrolling, selection, and navigation |
| Data entry, settings, or inspector | `mhFormChrome` with native sections and fields | Platform grouping, focus, and control behavior |
| Overview, report, insight, or other content needing an editorial arrangement | `mhScreen`, `mhSection`, `MHSummary`, `MHFeatureGrid`, `MHGroupedRows` | Deliberate stack-based content hierarchy |

Native containers are complete styled adoption paths. Add shared section
headers, footers, and row treatments only where they improve hierarchy;
native sections do not need duplicate cues or frames.

Signature composition does not imply replacement controls. Keep native
buttons, toggles, pickers, text fields, navigation, toolbars, search, sheets,
and system presentations, while MHUI owns the surrounding hierarchy, rhythm,
surfaces, and semantic emphasis.

Preserve the distinction between the stable content plane and floating
navigation or controls. Native grouping and shape can give content depth
without adding glass or shadows to every block. MHUI's identity does not depend
on replacing these platform conventions with flat, ruled surfaces.

`mhScreen` owns its `ScrollView`, canvas, readable width, margins, and title
block. Do not place a `List`, `Form`, or another screen-level scrolling
container inside it.

`mhListChrome` and `mhFormChrome` preserve the native container's edge-to-edge
scrolling, platform-selected style, and control behavior while applying the
shared canvas. Keep page titles and screen-specific lead content in the host
app.

Use either the MHUI screen title or the host navigation title as the visible
page heading. Avoid presenting the same title in both places.

### Summary And Navigation Hierarchy

`MHSummary` is an editorial lead, not a second page title. When native
navigation already names the current item, use an `MHSummary` only when its
title communicates a different result, status, or piece of context. Repeating
the item name in both places adds hierarchy without adding information and
becomes especially prominent at accessibility text sizes.

If the screen has no distinct editorial lead, omit `MHSummary` and begin with
the screen content. The package primitive is optional; complete adoption does
not require every screen to display one.

### Adaptive Feature Hierarchy

Use `MHFeatureGrid` when a screen has one primary feature and a small set of
supporting content. The package preserves that hierarchy with a split layout at
regular widths, up to two supporting columns at compact widths, and one column
at accessibility text sizes.

```swift
MHFeatureGrid {
    FeatureTile(feature: primaryFeature)
} supporting: {
    ForEach(supportingFeatures) { feature in
        FeatureTile(feature: feature)
    }
}
```

`FeatureTile` and the feature models in this example remain app-owned. The
container does not infer product priority, navigation, interaction, surface
role, or wording. Keep the supporting set concise; use a native `List` when the
content is an open-ended collection that needs list behavior.

## Signature Composition

Use the signature route for screens whose main job is to present an overview,
detail, report, insight, or product-specific tool. Migrating an existing
`List` screen to this route is expected when the list is only providing generic
scrolling and grouping.

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

This route gives each layer a distinct responsibility:

- `mhScreen` owns screen scrolling, canvas treatment, readable width, and title
  rhythm.
- `MHSummary` establishes a concise editorial context block with a precise top
  rule rather than an elevated card.
- `MHFeatureGrid` preserves one leading feature and a concise supporting set
  across regular width, compact width, and accessibility text sizes.
- `mhSection` owns its neutral heading cue, supporting text, content surface,
  inset, and optional footer.
- `MHGroupedRows` applies row chrome and separators to its direct children.
- `mhInputChrome` gives native text-entry controls semantic input treatment.
- `MHActionGroup` owns action spacing and horizontal-to-vertical fallback.

Do not add `.mhRow()` to every direct child of `MHGroupedRows`. The container
already applies the row treatment. Standalone rows and rows in native
containers can use `.mhRow()` when they need that explicit treatment. Each
direct child should represent one row; place additional rows as sibling
children instead of nesting another row-styled view inside a composite child.

## Native List Bridge

Use `mhListChrome` for native grouping, including read-only details, or when
selection, swipe actions, editing, reordering, and list navigation fit the
screen. Choose it by the content and behavior the screen needs.

```swift
import MHUI
import SwiftUI

struct SettingsList: View {
    var body: some View {
        List {
            Section {
                Toggle("Use Cloud Sync", isOn: .constant(true))
                    .mhRow()

                LabeledContent("Theme", value: "System")
                    .labeledContentStyle(.mhKeyValue)
            } header: {
                MHSectionHeader(
                    "Preferences",
                    supporting: "Native list behavior remains available."
                )
            } footer: {
                MHSectionFooter(
                    "The app owns the setting and its consequences."
                )
            }
        }
        .mhListChrome()
        .navigationTitle("Workspace")
    }
}
```

Use `.mhRow()` only when a native row needs MHUI's explicit row treatment.
Native sections and controls can keep their platform-owned insets and styling.
The `.mhKeyValue` labeled-content style already includes its own row behavior
and compact-width fallback; do not add another row treatment around it.

For custom floating actions on iOS 26 and later, apply `safeAreaBar` directly
to the `List` before `mhListChrome`. Place any `scrollEdgeEffectStyle` modifier
on that same list. This keeps the scroll view and its bar inside MHUI's adaptive
layout scope, allowing the native scroll edge effect to separate reading
content from the fixed controls. The host app owns the actions and bar layout.

## Native Form Bridge

Use `mhFormChrome` for data entry that benefits from native form grouping and
control behavior. It is not the default presentation route for read-only
details, reports, dashboards, or tool screens.

```swift
import MHUI
import SwiftUI

struct ProfileForm: View {
    @State private var name = ""
    @State private var notificationsEnabled = true

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $name)

                Toggle(
                    "Notifications",
                    isOn: $notificationsEnabled
                )
                .mhRow()
            } header: {
                MHSectionHeader(
                    "Profile",
                    supporting: "System controls keep their native behavior."
                )
            } footer: {
                MHSectionFooter(
                    "Product validation and persistence stay in the app."
                )
            }
        }
        .mhFormChrome()
        .navigationTitle("Account")
    }
}
```

Keep validation state, persistence, navigation, and side effects in the host
app. Use native field styling inside `Form`; reserve `mhInputChrome` for
detached inputs in stack-based or custom compositions.

## Component Defaults and Explicit Roles

| API | Package-owned default | Adopter responsibility |
| --- | --- | --- |
| `mhTheme` | Propagates the complete theme, MHDesign metrics, and optional native tint | Select screen structure and roles that cannot be inferred |
| `MHSummary` | Ruled editorial summary and stronger system title hierarchy | Provide concise screen context and optional accessory |
| `MHFeatureGrid` | Adaptive leading-feature and supporting-content hierarchy | Select the primary feature, supporting set, and semantic treatments |
| `MHSectionHeader` | Neutral section cue and hierarchy | Provide product wording and optional accessory |
| `MHSectionFooter` | Quiet explanatory text | Provide concise supporting guidance |
| `MHGroupedRows` | Direct-child row chrome and separators | Provide native controls or semantic row content |
| `MHActionGroup` | Secondary style and adaptive layout | Mark primary, quiet, and destructive exceptions |
| `mhRow` | Standalone or native-container row chrome | Apply it outside `MHGroupedRows` when needed |

### Compact Metadata Badges

`mhBadge` styles one metadata token. It intentionally does not choose which
product facts belong in a compact row or arrange an arbitrary collection of
badges. Those decisions remain in the host app.

In `List` and `Form` rows, prioritize the signals people need to scan or
interpret the row. Avoid keeping every flag visible by allowing an ordinary row
to become a tall vertical badge list at standard text sizes. Move secondary
facts to the detail screen, or use a concise text or symbol treatment with an
explicit accessibility label.

When several badges are essential, the host app owns the adaptive composition.
Use a standard SwiftUI layout such as `ViewThatFits` or a product-appropriate
custom `Layout`, then verify compact width, Dynamic Type, localization, and
right-to-left layout. Promote a badge-group layout into MHUI only after the
same domain-neutral behavior is demonstrated by multiple adopters.

An unstyled button inside `MHActionGroup` uses `.mhSecondary`. Mark the single
prominent action explicitly:

```swift
MHActionGroup {
    Button("Save") {
        // Save.
    }
    .buttonStyle(.mhPrimary)

    Button("Cancel") {
        // Cancel.
    }
}
```

Use `.mhQuiet` or `.mhDestructive` only when that semantic role is intentional.
Do not make every action primary.

Native `Button(role: .destructive)` does not infer the MHUI destructive
treatment. Apply `.buttonStyle(.mhDestructive)` explicitly inside an
`MHActionGroup`.

## Staged Adoption

Before choosing a component route, separate the stable content plane from the
floating functional layer. Routine collections and forms normally keep native
container presentation. Use the signature composition when a concise overview,
summary, leading visual, or insight genuinely benefits from deliberate
proportion and whitespace.

Liquid Glass belongs to navigation and important interactive chrome. Do not use
it as a content background or apply it to rows, metadata, and static surfaces to
make a screen feel more styled. Let low-chroma content planes provide continuity
under native translucent controls, and reserve the host accent for semantic
state, focus, and the primary action.

Adopt one screen at a time in this order:

1. Apply `.mhTheme(.standard)` near the app root and keep the app-owned
   `AccentColor` asset.
2. Classify the screen by purpose and required interaction semantics.
3. Choose native containers or stack-based composition to fit that purpose.
4. Use shared semantic APIs where they add meaning or remove ad hoc styling;
   preserve native section and field treatment where it already fits.
5. Remove redundant local backgrounds, corner radii, insets, and button layout
   workarounds that duplicate package-owned treatments.
6. Review the complete screen before changing theme tokens.

Theme-only adoption establishes an inherited baseline; inspect the actual
screen before deciding whether it needs further composition. Native and
stack-based routes can both be finished implementations. Directional previews
remain proposals until their appearance is reviewed; do not freeze them as
golden baselines merely because they compile or render successfully.

## Migration from 1.11

### Native Containers Keep Their Full Viewport

`mhListChrome` and `mhFormChrome` no longer accept a title, subtitle, or header
block. Those overloads wrapped and padded the complete native scroll view,
which shortened its viewport and overrode platform list geometry.

Move page titles to navigation and keep screen-specific lead content in the
host composition. Apply `navigationTitle` inside the app-owned
`NavigationStack`:

```swift
List {
    // Native sections and rows.
}
.mhListChrome()
.navigationTitle("Workspace")
```

The modifiers no longer force the plain list style or clear native row
backgrounds and separators. Remove app-local workarounds that attempted to
restore grouped row shapes or extend the scroll view to the screen edges.

### Native Forms Own Field Grouping

Remove `mhInputChrome` from text fields inside `Form`. The form already
provides platform-appropriate grouping, and adding detached input chrome
creates a second visual frame.

Continue using `mhInputChrome` for fields in `mhScreen` or another custom stack
where the field does not already have container-owned chrome.

### Content Chrome Stays Solid

Metadata badges and detached input chrome no longer adopt Liquid Glass under
the automatic or enabled policy. They belong to the content layer and now use
their semantic solid fills consistently.

Filled MHUI actions remain eligible interactive controls. Native navigation,
toolbars, and other system controls continue to receive their platform
treatment from SwiftUI.

### Standard Surfaces Are Brighter and Rounder

The `MHBackground`, `MHSurface`, and `MHSurfaceMuted` assets use brighter
standard light appearances. Treat the asset catalog as the source of truth for
their concrete values.

The standard control corner radius changes from 6 points to 8 points, and the
standard surface corner radius changes from 8 points to 12 points. Update
visual snapshots and any layout assumptions that copied the previous standard
values. Explicit app-owned color and metric overrides remain in control.

## Migration from 1.10

### Standard Styling Is Achromatic

The standard background, surface, border, and text assets now form a fully
achromatic palette. Screen-title cues use dark ink, and section cues use a
neutral border color instead of the app accent.

The app still owns `AccentColor`, but the standard composition uses it
selectively for semantic status, focus, native controls, and primary actions.
Review custom color overrides and visual snapshots that assumed warm surfaces
or accent-colored decorative cues.

### Editorial Summaries Are New

MHUI now includes `MHSummary`, an inset editorial summary with a precise top
rule rather than an elevated card. This primitive was not part of 1.10, so
existing consumers do not need to remove a previous summary treatment. Its
title uses the new `MHTextRole.summaryTitle` role, which is stronger than an
ordinary section heading while remaining a Dynamic Type-compatible system
style.

Existing `MHTheme.Typography` initializers remain source compatible when
`summaryTitle` is omitted; the role inherits `sectionTitle`. Add an explicit
`summaryTitle` value when a custom theme needs a different hierarchy. Update
exhaustive `MHTextRole` switches and assumptions based on
`MHTextRole.allCases` for the new case.

The standard screen title and subtitle also use tighter spacing. This is a
visual change and does not require a source migration.

### Grouped Rows Own Row Chrome

`MHGroupedRows` now applies row chrome to each direct child. Existing direct
children that also call `.mhRow()` remain source compatible and do not receive
double outer row spacing, but the modifier is redundant and can be removed.
This compatibility applies to the direct row itself; separately styled rows
must not be nested inside that direct child's subtree.

Before:

```swift
MHGroupedRows {
    Toggle("Enabled", isOn: .constant(true))
        .mhRow()
}
```

After:

```swift
MHGroupedRows {
    Toggle("Enabled", isOn: .constant(true))
}
```

Use `.mhRow()` for standalone rows and native `List` or `Form` rows only when
they need MHUI's explicit treatment. Native rows can retain platform styling.

### Action Groups Default to Secondary

`MHActionGroup` now applies `.mhSecondary` to buttons that do not declare a
button style. Remove redundant `.buttonStyle(.mhSecondary)` calls. Keep
`.mhPrimary`, `.mhQuiet`, `.mhDestructive`, or a deliberate native button style
on individual child buttons when their role differs from the group default.

## Adoption Verification

Before considering a screen adopted, verify all of the following:

- The app applies one root theme and still owns its accent color.
- Standard base planes remain achromatic unless the app deliberately overrides
  a semantic color.
- Decorative headings and rules do not use the app accent.
- Accent appears selectively for semantic status, focus, native controls, and
  the primary action.
- The screen uses one screen-level route without nested scrolling containers.
- The chosen native or stack-based route fits the content hierarchy and
  required interactions.
- Native lists retain platform grouping and any required selection, swipe
  actions, editing, reordering, or hierarchical navigation.
- Native forms retain platform field grouping, focus, and control behavior.
- An `MHSummary` title adds context instead of repeating the navigation title.
- Stack-based sections use `mhSection` and grouped content uses
  `MHGroupedRows`.
- `MHSummary` reads as a ruled editorial block rather than an elevated card.
- Native `List` and `Form` sections use the shared header and footer views where
  shared hierarchy is desired.
- Standalone and native-container rows use `mhRow` only when its treatment is
  needed; grouped-row direct children do not require it.
- Every direct child of `MHGroupedRows` represents one row and does not contain
  another row-styled view.
- The primary action is explicit and ordinary grouped actions use the secondary
  default.
- Compact rows prioritize essential metadata instead of preserving every flag
  as a tall badge stack.
- Product behavior, validation, persistence, and navigation remain in the app.
- System typography remains readable at accessibility Dynamic Type sizes.
- The app accent is legible in light, dark, and Increase Contrast appearances.
- Layout remains usable at compact width and in right-to-left layout.
- VoiceOver labels and native control behavior remain intact.

Open the nested sample package and review its theme-only, signature, native
bridge, dark, accessibility, and right-to-left previews. This makes the
adoption hierarchy visible without maintaining an Xcode project.

Build that sample as an independent public API consumer with:

```sh
bash ci_scripts/tasks/test_mhui_consumer_adoption.sh
```
