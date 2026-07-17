# MHUI Adoption Guide

## Purpose

This guide turns an existing SwiftUI screen into a complete MHUI composition
without replacing native controls or moving product behavior into the package.
It covers both stack-based screens and native `List` or `Form` containers.

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

Apply one theme near the app root:

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

The theme is semantic configuration rather than a global skin. It supplies
colors, typography, metrics, and presentation values to MHUI components. It
does not automatically restyle every native `List`, `Form`, `Section`, row, or
button in its subtree.

As a result, adding only `.mhTheme(.standard)` to an unchanged app can look
almost identical to the original interface. Complete adoption requires the
screen-level and component-level APIs described below.

### Keep the Accent App-Owned

The standard theme uses bright, fully achromatic package-owned base colors and
system typography. It resolves its accent from the host app's `AccentColor`
asset, so each app can keep its own identity without changing the neutral
canvas.

Dark-ink headings and neutral rules own the decorative hierarchy. Reserve the
app accent for semantic status, focus, native controls, and the primary action.
Do not use it as the default color for headings, metadata, rules, or surfaces.

If an app must define the accent in code, use
`MHTheme.standard(accent:onAccent:)`. The host app owns both values and must
verify that the pair remains legible in light, dark, and Increase Contrast
appearances.

Start with the standard achromatic surfaces and system fonts. Tune semantic
theme values only after the complete composition is visible and reviewed.

## Choose One Screen Route

Do not combine the screen containers. Choose the route that matches the
screen's existing structure.

| Existing structure | Screen-level API | Section and row APIs |
| --- | --- | --- |
| Stack or custom layout | `mhScreen` | `mhSection`, `MHSummary`, `MHGroupedRows` |
| `List` | `mhListChrome` | `MHSectionHeader`, `MHSectionFooter`, `mhRow` |
| `Form` | `mhFormChrome` | `MHSectionHeader`, `MHSectionFooter`, `mhRow` |

`mhScreen` owns its `ScrollView`, canvas, readable width, margins, and title
block. Do not place a `List`, `Form`, or another screen-level scrolling
container inside it.

`mhListChrome` and `mhFormChrome` preserve the native container's edge-to-edge
scrolling, platform-selected style, and control behavior while applying the
shared canvas. Keep page titles and screen-specific lead content in the host
app.

Use either the MHUI screen title or the host navigation title as the visible
page heading. Avoid presenting the same title in both places.

## Stack-Based Golden Path

Use the stack route when the screen is composed from `VStack`, `LazyVStack`, or
other custom layout content.

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
- `mhSection` owns its neutral heading cue, supporting text, content surface,
  inset, and optional footer.
- `MHGroupedRows` applies row chrome and separators to its direct children.
- `mhInputChrome` gives native text-entry controls semantic input treatment.
- `MHActionGroup` owns action spacing and horizontal-to-vertical fallback.

Do not add `.mhRow()` to every direct child of `MHGroupedRows`. The container
already applies the row treatment. Standalone rows and rows in native
containers still use `.mhRow()` explicitly. Each direct child should represent
one row; place additional rows as sibling children instead of nesting another
row-styled view inside a composite child.

## Native List Route

Use `mhListChrome` when list behavior such as selection, swipe actions, or
native list semantics should remain intact.

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

Use `.mhRow()` for ordinary native list rows. The `.mhKeyValue` labeled-content
style already includes its own row behavior and compact-width fallback.

## Native Form Route

Use `mhFormChrome` for data entry that benefits from native form grouping and
control behavior.

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
| `mhTheme` | Supplies semantic values | Select the components and roles that use them |
| `MHSummary` | Ruled editorial summary and stronger system title hierarchy | Provide concise screen context and optional accessory |
| `MHSectionHeader` | Neutral section cue and hierarchy | Provide product wording and optional accessory |
| `MHSectionFooter` | Quiet explanatory text | Provide concise supporting guidance |
| `MHGroupedRows` | Direct-child row chrome and separators | Provide native controls or semantic row content |
| `MHActionGroup` | Secondary style and adaptive layout | Mark primary, quiet, and destructive exceptions |
| `mhRow` | Standalone or native-container row chrome | Apply it outside `MHGroupedRows` when needed |

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

Adopt one screen at a time in this order:

1. Apply `.mhTheme(.standard)` near the app root and keep the app-owned
   `AccentColor` asset.
2. Choose exactly one screen route: stack, `List`, or `Form`.
3. Add the screen-level chrome for that route.
4. Replace ad hoc section headers, footers, rows, inputs, summaries, and action
   layouts with the matching semantic APIs.
5. Remove redundant local backgrounds, corner radii, insets, and button layout
   workarounds that duplicate package-owned treatments.
6. Review the complete screen before changing theme tokens.

Theme-only adoption is a valid intermediate compile step, but it is not the
finished visual integration.

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

The standard light background changes from `#F2F2F2` to `#FAFAFA`, the
standard surface changes from `#F9F9F9` to `#FFFFFF`, and the muted surface
changes from `#E8E8E8` to `#F2F2F2`.

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

Continue using `.mhRow()` for standalone rows and ordinary rows inside a native
`List` or `Form`.

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
- Stack-based sections use `mhSection` and grouped content uses
  `MHGroupedRows`.
- `MHSummary` reads as a ruled editorial block rather than an elevated card.
- Native `List` and `Form` sections use the shared header and footer views where
  shared hierarchy is desired.
- Standalone and native-container rows use `mhRow`; grouped-row direct children
  do not require it.
- Every direct child of `MHGroupedRows` represents one row and does not contain
  another row-styled view.
- The primary action is explicit and ordinary grouped actions use the secondary
  default.
- Product behavior, validation, persistence, and navigation remain in the app.
- System typography remains readable at accessibility Dynamic Type sizes.
- The app accent is legible in light, dark, and Increase Contrast appearances.
- Layout remains usable at compact width and in right-to-left layout.
- VoiceOver labels and native control behavior remain intact.

Open the nested sample package and review its theme-only, composed, native
container, dark, accessibility, and right-to-left previews. This makes the
difference between configuration-only adoption and complete composition
visible without maintaining an Xcode project.

Build that sample as an independent public API consumer with:

```sh
bash ci_scripts/tasks/test_mhui_consumer_adoption.sh
```
