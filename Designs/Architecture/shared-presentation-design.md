# Shared Presentation Design

## Purpose

This document describes the current boundary for shared presentation logic in MHUI.
It explains where new code should live when the same visual rule or container pattern must work across multiple sibling apps.

## Core Principles

- `Sources/MHUI` is the source of truth for shared presentation logic.
- Host apps own product behavior, feature state, and navigation meaning.
- Example apps and previews are consumers of package APIs, not a second design layer.
- Views and modifiers in MHUI should stay domain neutral even when they feel screen-like.
- MHUI remains a single package target unless there is a stronger reason than file organization alone.

## Responsibility Boundaries

| Concern | Lives in | Examples |
| --- | --- | --- |
| Shared presentation logic | `Sources/MHUI` | `MHTheme`, semantic roles, text styles, surface chrome, grouped rows, section chrome, screen chrome |
| Package preview support | `Sources/MHUI/PreviewSupport` | preview catalogs, review scenarios, accent and material comparisons |
| Host app composition | App repositories that consume MHUI | feature screens, navigation state, form state, domain-driven copy, feature-specific layouts |
| Optional integration shell | `Example/` when present | package adoption checks, manual regression review, consumer-side examples |

## Canonical Shared APIs

The following types and helpers are the current shared entry points for package-owned presentation:

- `MHTheme`
- `MHAccentStyle`
- `MHTextRole`
- `MHColorRole`
- `mhTextStyle(_:colorRole:)`
- `mhSurface(role:)`
- `mhRow()`
- `mhSection(...)`
- `mhScreen(...)`
- `mhListChrome(...)`
- `mhFormChrome(...)`
- `mhEmptyStateLayout()`

## Placement Rules

1. If a visual rule is intended to stay aligned across more than one app, add or extend MHUI first.
2. If a component needs business models, persistence, networking, or app-specific routing to make sense, keep it outside MHUI.
3. If an example or preview starts introducing helper APIs that sibling apps will need, move that API into `Sources/MHUI`.
4. Keep product wording, feature-specific empty states, and business-state branching out of the package.
5. Prefer semantic inputs such as roles, policies, and layout intent over app-specific configuration objects.
6. If glue code is reused only inside one consuming app, keep it in that app instead of promoting it into MHUI.

## Current Examples

- `MHTheme.standard()` stays in the package because it is a reusable visual baseline rather than one app's branding logic.
- `mhListChrome(...)` and `mhFormChrome(...)` stay in the package because they shape container presentation without needing app-specific business state.
- Preview catalogs remain package-owned because they verify shared visual rules directly against the canonical APIs.
- Example app code, when present, should show integration but should not hide canonical styling logic outside `Sources/MHUI`.

## Refactoring Heuristic

When a visual rule is duplicated across sibling apps, the default fix is to move that rule into MHUI.
When the duplicated code still depends on one product's models, copy, or workflows, the default fix is to keep it in the host app and only extract the domain-neutral presentation layer.
