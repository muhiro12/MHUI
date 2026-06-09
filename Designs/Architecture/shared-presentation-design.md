# Shared Presentation Design

## Purpose

This document describes the current boundary for shared design parameters in `MHDesign` and shared presentation logic in `MHUI`.
It explains where new code should live when the same visual rule or container pattern must work across multiple sibling apps.

## Core Principles

- `MHDesign/Sources` is the source of truth for shared spacing, corner radius, and generic screen or surface layout parameters that should work without MHUI chrome.
- `MHUI/Sources` is the source of truth for shared presentation logic built on `MHDesign`.
- `MHUI/Resources` is the source of truth for MHUI-owned standard theme assets that should remain package-owned but editable as resources.
- Host apps own product behavior, feature state, and navigation meaning.
- Example apps and previews are consumers of package APIs, not a second design layer.
- Views and modifiers in MHUI should stay domain neutral even when they feel screen-like.
- MHUI remains a single package target unless there is a stronger reason than file organization alone.
- Releases in the `1.x` line are beta, so package API clarity takes precedence over backward compatibility for consuming apps.

## Responsibility Boundaries

| Concern | Lives in | Examples |
| --- | --- | --- |
| Shared design parameters | `MHDesign/Sources` | `MHDesignMetrics`, spacing, corner radii, readable widths, generic screen or surface insets, compact thresholds, SwiftUI environment bridge |
| Shared presentation logic | `MHUI/Sources` | `MHTheme`, semantic roles, host-color variants, text styles, row and action fallback, key-value fallback, cue geometry, surface chrome, grouped rows, section chrome, screen chrome, small presentation affordances, and re-export of `MHDesign` |
| Package resource assets | `MHUI/Resources` | Standard theme color assets referenced by MHUI semantic roles |
| Package preview support | `MHDesign/Sources/PreviewSupport`, `MHUI/Sources/PreviewSupport`, plus local preview files beside the tuned API | minimal MHDesign preview helpers, `MHPreviewStyle`, `MHPreviewCatalog`, validation catalogs for compact width and native-container chrome, plus local previews kept beside the API they tune |
| Host app composition | App repositories that consume MHUI | feature screens, navigation state, form state, domain-driven copy, feature-specific layouts |
| Optional integration shell | `Example/` when present | package adoption checks, manual regression review, consumer-side examples |

## Adoption Model

- Metrics-only app: `import MHDesign`
- Styled app: `import MHUI`

The styled path still conceptually uses both layers, but `MHUI` re-exports `MHDesign` so consuming apps do not need two explicit imports.

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
- `MHColorReference`
- `MHTextRole`
- `MHColorRole`
- `Color.mhAdjusted(by:)`
- `mhTextStyle(_:colorRole:)`
- `MHDismissButton`
- `mhHidden(_:)`
- `mhSingleLine()`
- `mhTwoLines()`
- `mhSurface(role:)`
- `mhRow()`
- `MHActionPresentation`
- `MHActionGroup`
- `MHKeyValueLayoutPolicy`
- `mhSection(...)`
- `mhScreen(...)`
- `mhListChrome(...)`
- `mhFormChrome(...)`
- `mhEmptyStateLayout()`

## Liquid Glass Policy

MHUI may use Liquid Glass only as package-owned surface treatment for domain-neutral primitives.
The package should keep the policy high level: host apps choose `mhGlassPolicy(_:)`, while
MHUI resolves platform support, Reduce Transparency, and fallback fills.
Do not add low-level glass choreography, feature-specific morphing, or per-screen art direction
to shared APIs.
When several package-owned glass surfaces appear near each other, prefer `MHGlassContainer` so
SwiftUI can coordinate effects and avoid unnecessary standalone glass rendering.
Canvas backgrounds should stay solid by default; glass belongs on contained controls, rows,
badges, inputs, and surfaces where the fallback remains equally usable.

## Placement Rules

1. If a shared value should stay aligned across more than one app and does not require MHUI chrome, add or extend `MHDesign` first.
2. If a visual rule requires presentation behavior, semantic styling, or package-owned component chrome, add or extend `MHUI`.
3. If a component needs business models, persistence, networking, or app-specific routing to make sense, keep it outside MHUI.
4. If a standard visual value should remain package-owned but belongs in an Apple resource surface, add it under `MHUI/Resources` and keep source access semantic.
5. If an example or preview starts introducing helper APIs that sibling apps will need, move that API into `MHUI/Sources`.
6. Keep product wording, feature-specific empty states, and business-state branching out of the package.
7. Prefer semantic inputs such as roles, policies, and layout intent over app-specific configuration objects or low-level token graphs.
8. If glue code is reused only inside one consuming app, keep it in that app instead of promoting it into the shared package layers.
9. During `1.x`, do not add deprecated aliases, migration helpers, compatibility shims, or old-caller dual paths just to ease package upgrades for consuming apps.
10. Keep generic Foundation, SwiftData, date, string, numeric, image-decoding, and bundle-introspection utilities outside MHUI.
11. Do not import SwiftData in MHUI or MHDesign presentation source.
12. Do not add SwiftUtilities as a package/project dependency reference or source import; MHUI should own only the presentation APIs it adopts.
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
- `MHTheme.standard()` and `MHTheme.standard(accent:)` stay in the package because they define a reusable semantic baseline rather than one app's branding system.
- `Color.mhAdjusted(by:)` stays in the package because host apps sometimes need
  a deterministic presentation variant of a host-owned color without adding
  random colors or package-owned brand tokens.
- `MHDismissButton`, `mhHidden(_:)`, `mhSingleLine()`, and `mhTwoLines()` stay in
  the package because they are small, domain-neutral presentation affordances
  reused across sibling app screens.
- Row insets, compact action padding, key-value fallback widths, and cue geometry stay in `MHUI` because those values only make sense alongside MHUI presentation behavior.
- `mhListChrome(...)` and `mhFormChrome(...)` stay in the package because they shape container presentation without needing app-specific business state.
- MHDesign tuning previews stay beside the metrics files they tune, with only minimal helper views in `MHDesign/Sources/PreviewSupport`.
- Single-feature previews stay next to the implementation file so day-to-day tuning starts from the edited API instead of a detached preview index.
- Preview validation catalogs remain package-owned in `MHUI/Sources/PreviewSupport` because they verify shared compact-width and container behavior directly against the canonical APIs.
- Example app code, when present, should show integration but should not hide canonical styling logic outside `MHUI/Sources`.

## Refactoring Heuristic

When raw spacing, corner radius, or generic screen or surface layout values are duplicated across sibling apps, the default fix is to move that rule into `MHDesign`.
When a presentation rule is duplicated across sibling apps, the default fix is to move that rule into `MHUI`.
When the duplicated code still depends on one product's models, copy, or workflows, the default fix is to keep it in the host app and only extract the domain-neutral presentation layer.
When a duplicated helper is generic data, persistence, date, string, numeric,
image decoding, or bundle introspection, the default fix is to keep it out of
MHUI and evaluate it for a platform foundation instead.
When a breaking package API change improves the boundary during `1.x`, prefer the cleaner API over carrying a temporary compatibility layer.
