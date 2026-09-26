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
    init() {
        #if os(iOS)
        MHTheme.standard.configureNavigationTitleAppearance()
        #endif
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .mhTheme(.standard)
        }
    }
}
```

The iOS startup call configures large and inline navigation title colors once
for the app, including `.native` screens. It is separate from the subtree
environment; see [Text Color Ownership](#text-color-ownership) for its scope.

The standard foundation is achromatic and adapts to light, dark, and Increase
Contrast appearances. Keep per-screen typography and surface recipes at the
shared defaults.

The call propagates colors, typography, metrics, presentation values, and
surface treatments to every MHUI component in the subtree. It also synchronizes
the `MHDesignMetrics` environment and, when the theme has a concrete
asset-backed accent, native-control tint. A narrower `.mhTheme(...)` call
overrides that baseline for one subtree through ordinary SwiftUI environment
scoping.

Theme propagation does not assign a visual role to arbitrary SwiftUI content.
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
native presentation. Use `.mhListChrome(.native)` or `.mhFormChrome(.native)`
to keep native grouping and row geometry on the MHUI canvas. Wrap the content
once in `MHContainerContent` for themed row surfaces. Both presentation styles
retain MHUI text colors. Omitting chrome and the content adapter leaves pure
system presentation; it is not a third MHUI design.
The app-wide navigation title color remains shared in either case.

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
| Main collection or browsing screen | `List` with `.mhListChrome(.content)` and `MHContainerContent` | MHUI content rhythm with native selection and navigation |
| Editor or product-specific form | `Form` with `.mhFormChrome(.content)` and `MHContainerContent` | MHUI hierarchy with native fields, focus, and validation behavior |
| Settings or familiar utility screen | `.mhListChrome(.native)` / `.mhFormChrome(.native)`, or theme only | Native structure and interaction with MHUI theme colors |
| Overview, report, or freely arranged detail | `mhScreen`, `mhSection`, `MHSummary`, `MHFeatureGrid`, `MHGroupedRows` | Deliberate stack-based content hierarchy |

Choose appearance independently of the container's behavior. A main screen
can use MHUI inside `List`; a settings screen can keep the native appearance
inside the same app. These are defaults by purpose, not restrictions on which
screens may use a treatment. Explicit row and header styles can be mixed when
they serve the product's hierarchy.

Signature composition does not imply replacement controls. Keep native
buttons, toggles, pickers, text fields, navigation, toolbars, search, sheets,
and system presentations, while MHUI owns the surrounding hierarchy, rhythm,
surfaces, and semantic emphasis.

Preserve the distinction between the stable content plane and floating
navigation or controls. Native grouping and shape can give content depth
without adding glass or shadows to every block. MHUI's identity does not depend
on replacing these platform conventions with flat, ruled surfaces.

`mhScreen` owns its `ScrollView`, canvas, readable width, margins, and subtitle.
Its default title is a native navigation title, with large presentation on iOS. Do not place a `List`, `Form`, or another screen-level scrolling
container inside it.

`mhListChrome(.content)` uses a plain list and the shared canvas.
`mhFormChrome(.content)` applies the canvas without forcing a form style.
Its automatic or explicit MHUI rows use the theme's muted surface, so native grouped forms remain
visible against a white or dark canvas. `MHSectionHeader` leaves outer form
margins to the system, avoiding a second horizontal inset on the heading.
Horizontal key-value rows align values to the trailing edge; stacked values
retain leading alignment for reading.
Both preserve native scrolling and controls. The `.native` choice preserves
the platform-selected background and style. Keep page titles and screen-specific lead content in the host
app.

Place a screen in the app's native navigation container. `mhScreen("Title")`
sets the navigation title; do not repeat it in content. Use
`titlePlacement: .content` only for a standalone scrolling heading. This explicit
option works without navigation and intentionally does not collapse into a bar.

### Summary And Navigation Hierarchy

`MHSummary` is an editorial lead, not a second page title. When native
navigation already names the current item, use an `MHSummary` only when its
title communicates a different result, status, or piece of context. Repeating
the item name in both places adds hierarchy without adding information and
becomes especially prominent at accessibility text sizes.

If the screen has no distinct editorial lead, omit `MHSummary` and begin with
the screen content. The package primitive is optional; complete adoption does
not require every screen to display one. `MHSummary` has no outer padding: use
`mhRow()` inside a list, or `mhSurfaceInset()` when placing it on a surface.
The surrounding composition owns its margins.

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

- `mhScreen` owns screen scrolling, canvas treatment, readable width, and the
  native navigation title.
- `MHSummary` establishes a concise editorial context through inset rhythm and
  whitespace rather than an elevated card.
- `MHFeatureGrid` preserves one leading feature and a concise supporting set
  across regular width, compact width, and accessibility text sizes.
- `mhSection` owns the header, supporting text, content spacing, and optional footer.
  Content remains on the canvas; add a surface explicitly when its role needs one.
- `MHGroupedRows` owns vertical row rhythm and separators. Its parent owns
  horizontal padding, so plain groups align with their section heading.
- `mhInputChrome` gives native text-entry controls semantic input treatment.
- `MHActionGroup` owns action spacing and horizontal-to-vertical fallback.

Do not add `.mhRow()` to every direct child of `MHGroupedRows`. The container
already applies the row treatment. Standalone rows and rows in native
containers can use `.mhRow()` when they need that explicit treatment. Each
direct child should represent one row; place additional rows as sibling
children instead of nesting another row-styled view inside a composite child.

## Native List Bridge

The container supplies scrolling, selection, navigation, swipe actions, and
editing. The app independently chooses its appearance. For a main collection:

```swift
List(selection: $selection) {
    MHContainerContent {
        Section {
            ForEach(documents) { document in
                NavigationLink(value: document.id) {
                    VStack(alignment: .leading) {
                        Text(document.title).mhRowTitle()
                        Text(document.summary).mhRowSupporting()
                    }
                }
                .tag(document.id)
            }
        } header: {
            MHSectionHeader("In use", supporting: "Keep what matters close.")
        }
    }
}
.mhListChrome(.content)
.navigationTitle("Collection")
```

`MHContainerContent` applies row insets and backgrounds to complete rows,
including navigation links. Per-row `mhRow()` is unnecessary inside it. The content route deliberately
uses a plain list; apply another supported `.listStyle` afterward when a
product needs its grouping. For themed native grouping and row geometry choose
`.mhListChrome(.native)`. The no-argument call chooses MHUI content.

MHUI text in content rows uses the theme's primary, secondary, and tertiary
colors. On prominent selected backgrounds, it resolves to the native
foreground hierarchy. Both chrome styles retain themed MHUI text elsewhere.
These choices require no additional per-row modifiers.
Explicit status and accent roles retain their semantic
colors and require selection-aware presentation when used on a selected row.

For custom floating actions on supported systems, apply `safeAreaBar` and
`scrollEdgeEffectStyle` directly to the `List`. The app owns their actions.

## Native Form Bridge

Settings can use `.mhFormChrome(.native)`. A product editor can instead use
MHUI hierarchy while retaining native fields and focus behavior:

```swift
Form {
    MHContainerContent {
        Section {
            TextField("Name", text: $name)
            Toggle("Keep offline", isOn: $keepsOffline)
            LabeledContent("Documents", value: "3")
        } header: {
            MHSectionHeader("Collection", supporting: "Your working copy")
        }
    }
}
.formStyle(.grouped)
.mhFormChrome(.content)
```

The example chooses grouped form presentation; the modifier does not force it.
`MHContainerContent` owns outer row insets and applies the MHUI labeled-content
style once, avoiding double padding. Outside the wrapper, `mhRow()` remains the
explicit per-row route. MHUI headers, footers, row text, and action styles are valid
inside native containers. Apply them selectively according to screen purpose.
Native field styling is sufficient in a form; `mhInputChrome` is useful for
inputs that need a visible detached boundary. Validation and persistence stay
in the app.

## Automatic Container Content

`MHContainerContent` is a content adapter, not a replacement for `List` or `Form`.
Choose presentation once with the enclosing container's `mhListChrome` or
`mhFormChrome`. In `.native` mode the original content receives a themed row background
without reconstructing its sections or changing their geometry and traits.
In `.content` mode the adapter uses SwiftUI's public section/subview composition
APIs to apply row chrome and the labeled-content style. Stable row identity,
app-owned values, tags, links, and control bindings stay with the supplied content.

Do not add another `mhRow()` inside the adapter. A complete row should be one
view; use a stack for several labels that belong to the same row. Both plain
rows and ordinary sections are supported. A primary content list may use this
adapter in any split-view column. For explicitly collapsible sections or
specialized section traits, keep
the native section structure and apply `mhRow()` explicitly: recomposing an
ordinary section does not forward every specialized section configuration.
For intentionally mixed row surfaces, use that explicit route as well.

Native horizontal row and section margins are retained on macOS. On other
platforms the content row metrics adapt to the available width and Dynamic Type.
Section title/supporting spacing consumes the same live width context rather
than assuming a device class. Readable-width limits, spacing tokens, and image
aspect ratios are constraints, not fixed screen frames; content can wrap and
stack when the window or column narrows.

## Navigation and Presentation Boundaries

### Text Color Ownership

`mhTheme` supplies theme values and an optional native tint; it does not recolor
every descendant. In composed content, `mhTextStyle` uses the same primary color
for screen titles, section titles, and body text unless another color role is
specified. Supporting and caption colors preserve the hierarchy.

MHUI components and text styles retain the theme colors in both List and
Form presentations. For an intentional text-only exception,
`mhTextAppearance(.native)` selects the system foreground hierarchy once for
the subtree.
Prominent native selection backgrounds also use the platform hierarchy.

Unstyled `Text` and native control labels can still use system black or white.
The root does not override their foreground:
blanket foreground styles also override prominent button labels and disabled
control treatments. Explicit host colors continue to take precedence.
The package does not require per-control corrections to undo a root override.

On iOS, configure native navigation titles once from the app initializer:

```swift
init() {
    #if os(iOS)
    MHTheme.standard.configureNavigationTitleAppearance()
    #endif
}
```

Use the same theme for this call and the root `mhTheme`. The primary text asset
supplies both large and inline title colors, including light, dark, and
increased-contrast variants. `.native` chooses the container presentation;
it does not opt navigation titles out of the app's shared appearance.
Native fonts, title collapse, backgrounds, Liquid Glass, and button tint remain
unchanged. The package uses UIKit's appearance proxy, without inspecting
SwiftUI's view controllers or installing replacement title views.

This startup configuration is application-wide across windows. Apply it before
navigation bars enter a window, not from `body`, `onAppear`, or a per-screen
modifier. Local `mhTheme` changes do not update this default. Existing bars and
explicit per-bar appearance settings take precedence; app-specific title
attribute defaults should be configured afterward. macOS and watchOS retain
platform title presentation. For Preview, configure it before returning the
preview's navigation hierarchy, as shown in the adoption sample.

### Container Placement

Apply the root theme to `TabView` or `NavigationSplitView`, but apply content
chrome only to the list, form, or scrolling content in each destination or
column. A shared theme does not paint navigation backgrounds. Navigation
containers, tab bars, toolbars, sheets, and split-view dividers
remain system-owned.

Choose `.native` when familiar native grouping serves a settings or utility
destination. A primary content list can retain `.content` in both expanded and
collapsed split views. Being passed to the `sidebar:` builder does not make
that list a navigation-only sidebar. A source list of destinations may favor
native presentation; a library or recipe list may favor content presentation.
MHUI does not force a style switch based on the device or column position.
Keep native selection and navigation behavior, and inspect both layouts.

`MHContentSplitViewPreview` demonstrates a content-first leading column.
Do not paint one canvas across all split columns
or replace system dividers with decorative rules. The MHUI canvas extends
vertically behind navigation chrome, stays within horizontal column bounds,
and respects the keyboard safe area.

Review `MHNativeStyleComparisonPreview` for the same List/Form data in both
styles, `MHNativeSplitViewPreview` for native and content columns, and
`MHNativeNavigationPreview` for tabs and a settings sheet. The public adoption
sample demonstrates the content list/editor alongside a settings form with
native controls and grouping on MHUI surfaces.

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
| `mhRow` | Standalone or native-container row chrome | Apply only when neither `MHGroupedRows` nor `MHContainerContent` already styles the complete row |
| `MHContainerContent` | Automatic content-row treatment or themed native-row surfaces | Wrap the container content once and choose its chrome style |
| `configureNavigationTitleAppearance()` | Shared iOS navigation title color | Call once before creating UI, using the app theme |
| `mhTextAppearance` | Theme-owned neutral text with selection adaptation | Choose `.native` only for a deliberate subtree exception; native chrome selects it automatically |

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
floating functional layer. Collections and forms choose native or MHUI content presentation by
screen purpose. Use the signature composition when a concise overview,
summary, leading visual, or insight genuinely benefits from deliberate
proportion and whitespace.

Liquid Glass belongs to navigation and important interactive chrome. Do not use
it as a content background or apply it to rows, metadata, and static surfaces to
make a screen feel more styled. Let neutral content planes provide continuity
under native translucent controls, and reserve the host accent for semantic
state, focus, and the primary action.

Adopt one screen at a time in this order:

1. Apply `.mhTheme(.standard)` near the app root and keep the app-owned
   `AccentColor` asset. On iOS, configure navigation title appearance once
   during app initialization using the same theme.
2. Classify the screen by purpose and required interaction semantics.
3. Choose native containers or stack-based composition to fit that purpose.
4. Use shared semantic APIs where they add meaning or remove ad hoc styling;
   choose native or MHUI section and row treatment where it fits.
5. Remove redundant local backgrounds, corner radii, insets, and button layout
   workarounds that duplicate package-owned treatments.
6. Review the complete screen before changing theme tokens.

Theme-only adoption establishes an inherited baseline; inspect the actual
screen before deciding whether it needs further composition. Native and
stack-based routes can both be finished implementations. Directional previews
remain proposals until their appearance is reviewed; do not freeze them as
golden baselines merely because they compile or render successfully.

## Presentation Choices After 2.0

MHUI offers two visual choices: content composition and themed native
presentation. Both share the theme's canvas, surface, and MHUI text colors.
Their technical entry points depend on who owns scrolling:

| Composition | Entry point | Structure |
| --- | --- | --- |
| MHUI scrolling content | `mhScreen` on a stack | MHUI supplies scrolling, readable width, and spacing |
| MHUI List or Form | `MHContainerContent` with `.content` chrome | MHUI supplies row rhythm; native controls and scrolling remain |
| Themed native List or Form | `MHContainerContent` with `.native` chrome | Native grouping, typography, insets, and editing structure remain |

In 2.0.0, `.native` left backgrounds and neutral text presentation to the OS.
It now retains MHUI colors. Add `MHContainerContent` once inside an existing
native List or Form to apply the theme's muted row surface. In native mode it
preserves the original section structure, including editing and collapse traits.
Without the adapter, chrome applies only the canvas and MHUI text environment;
it cannot reach through an arbitrary container to set each row's background.
Do not apply full-screen chrome to the navigation shell across its columns.
Apply content styling to an individual list, including a primary content list
that occupies the leading column of a split view.

Standard control labels, unstyled `Text`, and native selection/disabled states
retain system semantics; this is not an app-wide foreground override. Use MHUI
text roles for composed prose. `mhTextAppearance(.native)` remains an explicit
text-only escape hatch, independent of the two container presentations.

Action styles share horizontal and vertical padding in every arrangement.
Quiet and destructive actions differ in color and fill, not label indentation.

## Migration to 2.1

Version 2.1 preserves the 2.0 public call sites while updating visual defaults.
Existing MHDesign initializers also remain usable as function values.

- Quiet and filled actions share padding across roles and arrangements. Remove
  app-side padding added solely to compensate for their former misalignment.
- Standard dimensions now follow the MHDesign eight-point grid. Recheck wrapping
  and density; do not copy the previous numeric values into app code. Native
  control dimensions and system font sizes remain platform-owned.
- Themed native containers now use MHUI canvas and row colors. Wrap List/Form
  content once in `MHContainerContent`; do not add `mhRow()` to each child too.
  Native control labels and selection states retain system semantics.
- Light text is softer gray and the dark canvas is near-black. Recheck app-owned
  accent colors, images, placeholders, overlays, and explicitly colored text.
- Choose `.content` or `.native` by the screen's purpose, not the position of a
  split-view column. A main collection can remain `.content` at all widths.
  Same-color column boundaries may still appear subtle and require app review.

Retain the root `mhTheme` and the startup navigation-title configuration.
Validate light/dark appearance, increased contrast, large Dynamic Type, native
form editing, selected rows, and compact/expanded navigation after updating.

## Migration to 2.0

MHUI 2.0 replaces the palette presets with one achromatic foundation and keeps
all content chrome off Liquid Glass. Host apps keep ownership of their accent
pair.

### Container Choice and Layout

No-argument `mhListChrome()` and `mhFormChrome()` choose MHUI presentation.
Pass `.native` explicitly to preserve platform grouping and row geometry
while retaining the MHUI canvas, row surfaces, and styled text hierarchy.
A content list uses plain styling;
MHUI rows and headers are explicit, supported choices in both List and Form.
Wrap ordinary container content in `MHContainerContent` to style all rows, or
apply `mhRow()` explicitly for mixed or specialized structures.

`MHSummary` no longer inserts surface padding. Place it inside
`MHContainerContent`, apply `mhRow()` explicitly in a list, or add
`mhSurfaceInset()` when a surrounding surface needs an inset.

`mhSection` no longer wraps content in a surface or adds surface insets.
`MHGroupedRows` no longer adds horizontal row padding. These changes align
headings, rows, and footers on an open canvas. To retain a distinct group plane,
apply the surface to the content before adding its section:

```swift
MHGroupedRows {
    LabeledContent("Storage", value: "2.4 GB")
        .labeledContentStyle(.mhKeyValue)
}
.mhSurfaceInset()
.mhSurface()
.mhSection("On this device")
```

Standalone `mhRow()` and native List/Form rows retain their own insets;
macOS uses native horizontal row margins.
Screen titles now default to native navigation presentation. Standalone
content titles use bold system type; iOS summaries use the regular system `title`
style. Review long titles and controls alongside them at large text sizes.

The shared standard metrics are redesigned, including a
640-point readable width, 24-point compact screen margins and top inset, and
40-point section spacing. Explicit `standard(metrics:)` overrides still win.
`MHDesignMetrics.standard` remains the single generic baseline. Metrics-only
adopters also receive these changes when updating to 2.0 and should review
their screen layouts.
See [Visual Design Principles](VISUAL_DESIGN_PRINCIPLES.md#intentional-design-parameters)
for the decisions behind changed and retained parameters.

### Footer-Only Sections

Rename footer-only `mhSection(..., footer:)` calls to `mhSectionWithFooter`.
The distinct name prevents a trailing closure from being interpreted as header
accessory content after formatting. Both `Text` and localized string titles
are supported.

```swift
MHGroupedRows {
    Text("Content")
}
.mhSectionWithFooter("Ideas") {
    MHSectionFooter("Supporting guidance below the section.")
}
```

Header-only and accessory-only calls remain `mhSection`. Calls with both
`accessory:` and `footer:` also keep `mhSection`; an empty accessory is no longer
needed for footer-only content.

### Navigation Title Color

On iOS, add `configureNavigationTitleAppearance()` to app initialization using
the root theme. Existing `mhTheme` calls alone do not apply this global UIKit
default. Both native and content screens share the primary text color.
See [Text Color Ownership](#text-color-ownership) for setup and scope.

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

- Background, surface, border, and text assets are neutral grays. The 2.0
  canvas uses white / near-black; explicit surfaces provide graded separation.
  Primary text is softened from pure black and white; text contrast remains
  verified across supported appearances. Warning and
  destructive keep their semantic hues.
- Standard surfaces and badges no longer draw a border. Increase Contrast adds
  an outline at the divider opacity, and detached inputs keep their boundary.
  Set `borderOpacity` on a surface treatment to restore a permanent outline.
- `metadata` and `caption` text use the standard system design with zero
  tracking instead of monospaced type. Set `design: .monospaced` on those
  `MHTheme.TextStyle` values if an app depends on the previous treatment.

## Migration from 1.11

These historical changes explain older API removals. For an upgrade directly
to 2.0, also apply [Migration to 2.0](#migration-to-20); its defaults supersede
the intervening 1.x visual treatments.

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
.mhListChrome(.native)
.navigationTitle("Workspace")
```

The explicit `.native` route does not force plain list styling or clear row
backgrounds and separators. The 2.0 default `.content` route uses a plain list.
Remove app-local workarounds that attempted to
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

Intervening 1.x releases changed the control radius to 8 points and the surface
radius to 12 points. The 2.0.0 release used an 8-point control radius and a
6-point surface radius. The current baseline uses 8 points for both. Use the current metrics instead of carrying forward
those historical values. Explicit app-owned metric overrides remain in control.

## Migration from 1.10

### Standard Styling Became Low-Chroma

In 1.10, the standard background, surface, border, and text assets formed a
restrained low-chroma foundation. Version 2.0 makes that foundation achromatic
as described in [Migration to 2.0](#migration-to-20). Layout hierarchy uses
proportion, whitespace, and tonal depth instead of decorative heading marks.

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
- On iOS, startup title configuration uses that theme; large, collapsed, and
  pushed titles retain their color in light, dark, and Increase Contrast.
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

### Composed Section Spacing

Use `spacing.section` between sibling sections. `mhSection` keeps its header,
content, and optional footer close with `spacing.inline`; do not add compensating
padding under its header. Standalone `MHSectionHeader` leaves external spacing
to its parent stack. Native List/Form headers retain container-specific insets.
Review `MHSectionRhythmPreview` for grouped rows, actions, footers, and large text.
