# ADR 0001: Shared Package Source of Truth

- Date: 2026-03-10
- Status: Accepted

## Context

MHUI is intended to support multiple sibling apps with one shared visual language.
If each app redefines tokens, modifiers, or screen chrome locally, visual drift becomes the default and design maintenance gets expensive.

## Decision

`Sources/MHUI` is the single source of truth for reusable presentation primitives in this repository.
Shared theme recipes, semantic roles, modifiers, layout helpers, and screen chrome belong in the package target.

## Consequences

- New shared styling APIs should land in `Sources/MHUI` first.
- README examples, docs, and any example app should point back to package-owned APIs.
- Host apps may configure tint and theme inputs, but should not fork the common visual language by default.
- Example integrations can validate package behavior, but they do not define the canonical API surface.
