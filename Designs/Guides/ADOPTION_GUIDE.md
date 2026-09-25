# MHUI Adoption Guide

## Purpose

This guide turns an existing SwiftUI screen into a complete MHUI composition
without replacing native controls or moving product behavior into the package.
Native `List` and `Form` integration and stack-based composition are supported
routes. Choose the route that fits the content and platform behavior while
keeping the package's neutral semantic foundation and rhythm.

The source-only
[MHUI adoption sample](../../Examples/MHUIAdoptionSample/Package.swift)
contains theme-only, stack-based, and native-container routes under one
`MHUIDesignReviewRoot`. It is a nested Swift package, so no Xcode project is
required. Its deterministic reading, empty, and action-heavy routes provide
broader visual review without becoming package-owned product screens.

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

The standard foundation is achromatic and adapts to light, dark, and Increase
Contrast appearances. Keep per-screen typography and surface recipes at the
shared defaults.

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

The standard theme uses achromatic package-owned base colors and system
typography. It resolves its accent from the host app's `AccentColor`
asset, so each app can keep its own identity without changing the neutral
canvas.

Type hierarchy, proportion, spacing, and neutral tone establish the
hierarchy. Reserve the app accent for semantic status, focus, native controls,
and the primary action. Do not use it as the default color for headings,
metadata, rules, or surfaces.

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

Use the standard typography, metrics, and surface treatments consistently.
Choose the app-wide brand accent pair at the root, not per screen.

## Choose Composition by Screen Purpose

Choose a route from the screen's purpose and required interaction semantics,
not from a requirement to display custom package chrome.

| Screen purpose | Route | Fit |
| --- | --- | --- |
| Collection, hierarchy, or grouped read-only detail | `mhListChrome` with native sections and rows | Platform grouping, scrolling, selection, and navigation |
| Data entry, settings, or inspector | `mhFormChrome` with native sections and fields | Platform grouping, focus, and control behavior |
| Overview, report, insight, or other content needing an editorial arrangement | `mhScreen`, `mhSection`, `MHSummary`, `MHFeatureGrid`, `MHGroupedRows` | Deliberate stack-based content hierarchy |

Native containers are complete styled adoption paths. Keep their sections,
rows, and controls native; MHUI supplies one consistent canvas treatment.
For the system route, omit the container modifier entirely.

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

This route gives each layer a distinct responsibility:

- `mhScreen` owns screen scrolling, canvas treatment, readable width, and title
  rhythm.
- `MHSummary` establishes a concise editorial context through inset rhythm and
  whitespace rather than an elevated card.
- `MHFeatureGrid` preserves one leading feature and a concise supporting set
  across regular width, compact width, and accessibility text sizes.
- `mhSection` owns supporting text, content surface, inset, and optional footer.
- `MHGroupedRows` applies row chrome and separators to its direct children.
- `mhInputChrome` gives native text-entry controls semantic input treatment.
- `MHActionGroup` owns action spacing and horizontal-to-vertical fallback.

Do not add `.mhRow()` to every direct child of `MHGroupedRows`. The container
already applies the row treatment. Standalone rows and rows in native
containers can use `.mhRow()` when they need that explicit treatment. Each
direct child should represent one row; place additional rows as sibling
children instead of nesting another row-styled view inside a composite child.

## Native List Bridge

Start with native `List`, `Section`, controls, and labeled content when the
screen should follow the platform, including Settings-like screens and split
view sidebars. Apply the root theme for MHUI environment values and optional
host tint; it does not require row or section decoration.

```swift
List {
    Section {
        Toggle("Use Cloud Sync", isOn: $isSyncEnabled)
        LabeledContent("Theme", value: "System")
    } header: {
        Text("Preferences")
    } footer: {
        Text("The app owns the setting and its consequences.")
    }
}
.mhListChrome()
.navigationTitle("Workspace")
```

`mhListChrome()` supplies the neutral canvas and preserves native row
backgrounds, insets, section typography, separators, and selection. Omit it
for a fully system-owned container. There is no background-strength setting.

Keep automatic list styling unless the screen requires a specific native
style. In `NavigationSplitView`, leave the sidebar unmodified and use MHUI
chrome on content or detail containers; do not wrap the entire split view.

Use native `Text` section headers and footers, controls, and `LabeledContent`.
Reserve `mhRow`, MHUI section typography, and `mhKeyValue` for signature
compositions rather than mixing them into this native route.

For custom floating actions on iOS 26 and later, apply `safeAreaBar` directly
to the `List` before `mhListChrome`. Place any `scrollEdgeEffectStyle` modifier
on that same list. The host app owns the actions and bar layout.

## Native Form Bridge

Use native `Form` for settings and data entry. Keep its implicit automatic style,
or explicitly choose a supported `.formStyle` when the screen requires it.
`mhFormChrome()` supplies the theme canvas. Omit it for a system-owned form.

```swift
Form {
    Section {
        TextField("Name", text: $name)
        Toggle("Notifications", isOn: $notificationsEnabled)
        LabeledContent("Plan", value: "Personal")
    } header: {
        Text("Profile")
    } footer: {
        Text("Product validation and persistence stay in the app.")
    }
}
.mhFormChrome()
.navigationTitle("Account")
```

Keep validation, persistence, navigation, and side effects in the host app.
Use native field styling inside `Form`; reserve `mhInputChrome` for detached
inputs in custom compositions. Native buttons can retain their contextual form
appearance; an MHUI action style is an explicit visual choice, not a requirement.

The `MHNativeStyleComparisonPreview` fixture compares standard, system-background,
canvas, and explicitly decorated treatments across iOS list and form styles.
Each treatment renders as an independent navigation root. Assemble comparisons
from these captures rather than nesting sibling navigation stacks in one canvas,
which can distort the apparent large-title margins.
`MHNativeSplitViewPreview` exercises automatic styles in navigation columns.
These fixtures are review tools, not proof of every OS or accessibility mode.

## Component Defaults and Explicit Roles

| API | Package-owned default | Adopter responsibility |
| --- | --- | --- |
| `mhTheme` | Propagates the complete theme, MHDesign metrics, and optional native tint | Select screen structure and roles that cannot be inferred |
| `MHSummary` | Spacious editorial summary and stronger system title hierarchy | Provide concise screen context and optional accessory |
| `MHFeatureGrid` | Adaptive leading-feature and supporting-content hierarchy | Select the primary feature, supporting set, and semantic treatments |
| `MHSectionHeader` | Explicit MHUI section typography | Provide product wording and optional accessory |
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
make a screen feel more styled. Let neutral content planes provide continuity
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

## Migration to 2.0

MHUI 2.0 replaces the palette presets with one achromatic foundation and keeps
all content chrome off Liquid Glass. Host apps keep ownership of their accent
pair.

### Palettes Are Removed

`MHPalette` and every `MHTheme.standard(palette:...)` overload are removed.
Delete the `palette:` argument; the remaining factories keep their labels and
defaults.

| 1.x | 2.0 |
| --- | --- |
| `.standard(palette: .mist)` | `.standard` |
| `.standard(palette:accent:)` | `.standard(accent:)` |
| `.standard(palette:onAccent:)` | `.standard(onAccent:)` |
| `.standard(palette:metrics:accent:)` | `.standard(metrics:accent:)` |
| `.standard(palette:accent:onAccent:)` | `.standard(accent:onAccent:)` |
| `.standard(palette:metrics:accent:onAccent:)` | `.standard(metrics:accent:onAccent:)` |

An app that depended on tinted surfaces can assign its own asset-backed colors
to `MHTheme.Colors` in its root theme.

### Surface Treatments Cannot Request Glass

`MHTheme.SurfaceTreatment` now describes a non-glass content fill. The glass
properties are removed and the fill properties are renamed.

| 1.x | 2.0 |
| --- | --- |
| `fallbackColorRole` | `colorRole` |
| `fallbackOpacity` | `opacity` |
| `prefersGlass`, `glassTintColorRole`, `glassTintOpacity` | Removed |

Before:

```swift
theme.surfaces.standard = .init(
    prefersGlass: false,
    fallbackColorRole: .surface,
    fallbackOpacity: 1,
    glassTintColorRole: nil,
    glassTintOpacity: 0,
    borderColorRole: .border,
    borderOpacity: 0.14
)
```

After:

```swift
theme.surfaces.standard = .init(
    colorRole: .surface,
    borderOpacity: 0.14
)
```

The initializer defaults `opacity` to `1`, `borderColorRole` to `.border`, and
`borderOpacity` to `0`. Content surfaces, the screen canvas, badges, and inputs
never use Liquid Glass, regardless of `MHGlassPolicy`. The policy affects only
MHUI action buttons: `.enabled` opts them in where the system supports it, and
`.automatic` and `.disabled` keep non-glass fills.

### Standard Appearance Changes

These changes need no source edits, but they affect visual snapshots:

- Background, surface, border, and text assets are neutral grays matched to
  the luminance, and therefore the contrast, of the 1.x defaults. Warning and
  destructive keep their system hues.
- Standard surfaces and badges no longer draw a border. Increase Contrast adds
  an outline at the divider opacity, and detached inputs keep their boundary.
  Set `borderOpacity` on a surface treatment to restore a permanent outline.
- `metadata` and `caption` text use the standard system design with zero
  tracking instead of monospaced type. Set `design: .monospaced` on those
  `MHTheme.TextStyle` values if an app depends on the previous treatment.

## Migration from 1.11

### Heading Cues Are Removed

MHUI no longer draws decorative rules around screen and section headings.
Remove `MHCuePlacement` and the `screenCue*` and `sectionCue*` arguments from
custom `MHTheme.Presentation` values. Use spacing, type hierarchy, and semantic
surface roles for shared structure; keep any content-specific divider in the
host composition where its meaning is clear.

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

The standard background, surface, border, and text assets form a restrained
palette. Layout hierarchy uses proportion, whitespace, and tonal depth instead
of decorative heading marks.

The app still owns `AccentColor`, but the standard composition uses it
selectively for semantic status, focus, native controls, and primary actions.
Review custom color overrides and visual snapshots that assumed warm surfaces
or accent-colored decoration.

### Editorial Summaries Are New

MHUI now includes `MHSummary`, an inset editorial summary rather than an
elevated card. This primitive was not part of 1.10, so
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
- Standard base planes and text remain achromatic unless the app deliberately
  overrides a semantic color.
- Surfaces rely on tone and spacing instead of decorative borders, and no
  surface is framed inside another.
- Structural rules do not use the app accent.
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
- `MHSummary` reads as a spacious editorial block rather than an elevated card.
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
