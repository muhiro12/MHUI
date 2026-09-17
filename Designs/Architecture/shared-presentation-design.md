# Shared Presentation Design

## Purpose

This document describes the current boundary for shared design parameters in `MHDesign` and shared presentation logic in `MHUI`.
It explains where new code should live when the same visual rule or container pattern must work across multiple sibling apps.

## Core Principles

- `MHDesign/Sources` is the source of truth for shared spacing, corner radius, and generic screen or surface layout parameters that should work without MHUI chrome.
- `MHUI/Sources` is the source of truth for shared presentation logic built on `MHDesign`.
- `MHUI/Resources` is the source of truth for package-owned color and image
  resources, including luminous, low-chroma standard base colors.
- Host apps own their accent color; the standard theme resolves it from the app's `AccentColor` asset and uses it selectively for semantic emphasis.
- Durable color and image values live in asset catalogs. Source code may map
  assets to semantic roles and derive treatment properties such as opacity,
  but it does not define RGB or hexadecimal base colors.
- Host apps own product behavior, feature state, and navigation meaning.
- The adoption sample and previews are consumers of package APIs, not a second
  design layer.
- Views and modifiers in MHUI should stay domain neutral even when they feel screen-like.
- MHUI remains a single package target unless there is a stronger reason than file organization alone.
- Releases in the `1.x` line are beta, so package API clarity takes precedence over backward compatibility for consuming apps.

## Responsibility Boundaries

| Concern | Lives in | Examples |
| --- | --- | --- |
| Shared design parameters | `MHDesign/Sources` | `MHDesignMetrics`, spacing, corner radii, readable widths, generic screen or surface insets, compact thresholds, SwiftUI environment bridge |
| Shared presentation logic | `MHUI/Sources` | `MHTheme`, semantic roles, text styles, row and action fallback, key-value fallback, surface chrome, grouped rows, section chrome, screen chrome, and re-export of `MHDesign` |
| Package resource assets | `MHUI/Resources` | Achromatic background, surface, border, dark-ink text, status, fallback foreground, and preview assets referenced by semantic roles |
| Package preview support | `MHDesign/Sources/PreviewSupport`, `MHUI/Sources/PreviewSupport`, plus local preview files beside the tuned API | minimal MHDesign preview helpers, `MHPreviewStyle`, `MHPreviewCatalog`, validation catalogs for compact width and native-container chrome, plus local previews kept beside the API they tune |
| Host app composition | App repositories that consume MHUI | feature screens, navigation state, form state, domain-driven copy, feature-specific layouts |
| Public adoption sample | `Examples/MHUIAdoptionSample` | independent public API build and one app-like consumer review Preview |

## Adoption Model

- Metrics-only app: `import MHDesign`
- Styled app: `import MHUI`

The styled path still conceptually uses both layers, but `MHUI` re-exports `MHDesign` so consuming apps do not need two explicit imports.
Styled apps can apply the opinionated `MHTheme.standard` baseline unchanged or
derive one app-owned theme from it. They apply that theme near the app root with
`mhTheme(_:)` and use a narrower theme only for deliberate local exceptions.
The unchanged baseline uses the host app's `AccentColor` asset.
Its decorative hierarchy remains low-chroma: dark-ink headings and quiet
boundaries distinguish content without borrowing the app's brand color. Accent is
reserved for semantic status, focus, native controls, and primary actions.

The root theme is the canonical root-first styling entry point. It propagates
the complete semantic theme, synchronizes MHDesign metrics, and applies a
concrete asset accent to native-control tint. It is the maximum safe cascade
for arbitrary SwiftUI content: blanket root button, font, foreground, list,
and form styles are excluded because they would cross semantic and system
presentation boundaries. Styled adoption supports three complementary routes:

1. Native `List` and `Form` integration preserves platform grouping, scrolling,
   controls, and navigation conventions with `mhListChrome` or `mhFormChrome`.
2. Stack-based composition uses `mhScreen`, `MHSummary`, `mhSection`, and
   `MHGroupedRows` when content needs a deliberate editorial layout.
3. Theme-only integration establishes the inherited baseline without inserting
   visible screen structure around arbitrary descendants.

The host app chooses by screen purpose, content hierarchy, and required
behavior. Read-only detail screens can use native grouped lists; they do not
need custom composition merely to demonstrate MHUI adoption. Shared headers,
footers, and row treatments are optional when native sections already provide
the intended hierarchy. Preserve MHUI's quiet semantic palette and rhythm
without requiring every screen to repeat its rules or surface frames.

`mhScreen` owns screen scrolling, so it must not wrap a native `List` or `Form`.
The native-container routes preserve their container behavior.

## Canonical Shared APIs

The following types and helpers are the current shared entry points for package-owned presentation:

- `MHDesignMetrics`
- `MHSpacingMetrics`
- `MHSpacingRole`
- `MHCornerRadiusMetrics`
- `MHCornerRadiusRole`
- `MHLayoutMetrics`
- `MHScreenLayoutMetrics`
- `MHSurfaceLayoutMetrics`
- `MHControlLayoutMetrics`
- `MHLayoutMode`
- `mhDesignMetrics(_:)`
- `MHTheme`
- `MHPalette`
- `MHTheme.Colors`
- `MHTheme.Typography`
- `MHTheme.Presentation`
- `MHTheme.Surfaces`
- `MHColorReference`
- `MHFontDesign`
- `MHTextRole`
- `MHColorRole`
- `mhTheme(_:)`
- `mhForegroundStyle(_:)`
- `mhTint(_:)`
- `mhTextStyle(_:colorRole:)`
- `mhSurface(role:)`
- `mhRow()`
- `MHGroupedRows`
- `MHSummary`
- `MHSectionHeader`
- `MHSectionFooter`
- `MHActionPresentation`
- `MHActionGroup`
- `MHKeyValueLayoutPolicy`
- `mhSection(...)`
- `mhScreen(...)`
- `mhListChrome(...)`
- `mhFormChrome(...)`
- `mhInputChrome(state:)`
- `mhEmptyStateLayout()`

## Liquid Glass Policy

MHUI may use Liquid Glass only as package-owned surface treatment for domain-neutral primitives.
The package should keep the policy high level: host apps choose `mhGlassPolicy(_:)`, while
MHUI resolves platform support, Reduce Transparency, and fallback fills.
Do not add low-level glass choreography, feature-specific morphing, or per-screen art direction
to shared APIs.
When several package-owned glass surfaces appear near each other, keep
coordination inside MHUI-owned primitives so SwiftUI can coordinate effects and
avoid unnecessary standalone glass rendering without exposing low-level glass
choreography to adopters.
Use depth to express hierarchy: content provides a stable reading plane, while
navigation and controls can occupy the system's floating interactive layer.
Prefer native controls and their system-provided glass treatment. Package-owned
filled actions apply glass to the complete padded label in a capsule so the
foreground and interactive effect share one surface. Their opaque fallback
continues to use the theme's control radius and semantic fills.

Canvas backgrounds, content surfaces, metadata badges, and inputs currently
use solid fills. Do not spread Liquid Glass across the content layer or add
decorative shadows to every surface. Native grouping, shape, spacing, and
semantic contrast can establish depth while preserving a quiet palette.
Any new content material needs a concrete content role and separate visual
review; it is not implied by enabling the glass policy.

Directional previews are review material, not accepted appearance baselines.
Changes to MHUI treatments do not imply changes to MHDesign's standard metrics.

## Placement Rules

1. If a shared value should stay aligned across more than one app and does not require MHUI chrome, add or extend `MHDesign` first.
2. If a visual rule requires presentation behavior, semantic styling, or package-owned component chrome, add or extend `MHUI`.
3. If a component needs business models, persistence, networking, or app-specific routing to make sense, keep it outside MHUI.
4. If a standard visual value should remain package-owned but belongs in an Apple resource surface, add it under `MHUI/Resources` and keep source access semantic.
5. If an example or preview starts introducing helper APIs that sibling apps will need and the helper fits MHUI's semantic styling or chrome boundary, move that API into `MHUI/Sources`.
6. Keep product wording, feature-specific empty states, and business-state branching out of the package.
7. Prefer semantic inputs such as roles, policies, and layout intent over app-specific configuration objects or low-level token graphs.
8. If glue code is reused only inside one consuming app, keep it in that app instead of promoting it into the shared package layers.
9. During `1.x`, do not add deprecated aliases, migration helpers, compatibility shims, or old-caller dual paths just to ease package upgrades for consuming apps.
10. Keep generic Foundation, SwiftData, date, string, numeric, image-decoding, and bundle-introspection utilities outside MHUI.
11. Do not import SwiftData in MHUI or MHDesign presentation source.
12. Do not add SwiftUtilities as a package/project dependency reference or source import; do not add source-compatible or MHUI-prefixed SwiftUtilities helper replacements just to support consumer migration.
13. Keep MHDesign tuning previews in same-directory `+Preview.swift` sidecar
    files so CoreGraphics-first value types stay uncluttered, and keep MHUI
    development previews in the implementation file under `// MARK: - Preview`.
14. Prefer direct `View` extensions for environment writes or light styling
    sugar, and use private `ViewModifier` types only when environment reads,
    adaptive layout resolution, multi-step chrome, or shared implementation
    justify the extra structure.

## Current Examples

- `MHDesignMetrics.standard` stays in the package because sibling apps need one shared baseline for spacing, corner radii, and generic screen or surface layout thresholds even when they do not adopt MHUI chrome.
- Re-export of `MHDesign` in `MHUI` stays in the package because styled adopters should reach both layers through one import.
- `MHTheme.standard()` and `MHTheme.standard(accent:)` stay in the package
  because they define a reusable semantic baseline rather than one app's
  branding system. The baseline uses package-owned luminous low-chroma planes,
  dark-ink hierarchy, quiet boundaries, host-provided accent, system
  typography, and restrained geometry.
- Apps choose a root palette and brand accent. Typography, metrics, and surface
  treatments are package-owned defaults; existing theme customization remains
  compatible but is not a required adoption step.
- The standard theme uses the app's `AccentColor` without installing a tint
  override. An app-provided concrete theme
  accent also tints native controls in the same subtree and should be paired
  with an app-tested `onAccent` foreground.
- Theme propagation does not remove explicit semantic role selection at the
  use site and does not globally replace native SwiftUI controls.
- `MHSummary` stays in the package because its stronger system title role and
  inset rhythm form a reusable editorial summary without presenting the
  content as an elevated card.
- `mhSection(...)` stays in the package because it establishes reusable
  hierarchy and surface composition without owning screen meaning.
- `MHSectionHeader` and `MHSectionFooter` express signature composition
  hierarchy. Native List/Form adoption uses plain section text and native rows.
- The three routes are system containers without chrome, native containers with
  the MHUI canvas, and signature composition. Native adoption has no per-screen
  background-strength control.
- `MHGroupedRows` owns direct-child row chrome and separator placement.
- `MHActionGroup` owns adaptive layout and treats unstyled child buttons as
  secondary actions. Primary, quiet, and destructive roles remain explicit at
  the call site.
- Row insets, compact action padding, and key-value fallback widths stay in
  `MHUI` because those values only make sense alongside MHUI presentation
  behavior.
- `mhListChrome(...)` and `mhFormChrome(...)` stay in the package because they shape container presentation without needing app-specific business state.
- MHDesign tuning previews stay beside the metrics files they tune, with only minimal helper views in `MHDesign/Sources/PreviewSupport`.
- Single-feature previews stay next to the implementation file so day-to-day tuning starts from the edited API instead of a detached preview index.
- Preview validation catalogs remain package-owned in `MHUI/Sources/PreviewSupport` because they verify shared compact-width and container behavior directly against the canonical APIs.
- `Examples/MHUIAdoptionSample` stays outside the root package targets. It
  demonstrates public integration and previews but does not hide canonical
  styling logic outside `MHUI/Sources`.

## Refactoring Heuristic

When raw spacing, corner radius, or generic screen or surface layout values are duplicated across sibling apps, the default fix is to move that rule into `MHDesign`.
When a presentation rule is duplicated across sibling apps, the default fix is to move that rule into `MHUI`.
When the duplicated code still depends on one product's models, copy, or workflows, the default fix is to keep it in the host app and only extract the domain-neutral presentation layer.
When a duplicated helper is a thin app-local presentation shortcut, or is
generic data, persistence, date, string, numeric, image decoding, or bundle
introspection, the default fix is to keep it out of MHUI and evaluate durable
non-UI utilities for a platform foundation instead.
When a breaking package API change improves the boundary during `1.x`, prefer the cleaner API over carrying a temporary compatibility layer.
