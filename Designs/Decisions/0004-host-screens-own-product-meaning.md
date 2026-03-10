# ADR 0004: Host Screens Own Product Meaning

- Date: 2026-03-10
- Status: Accepted

## Context

Shared UI packages make it easy to centralize not only styling but also empty-state wording, screen-level semantics, and feature-specific layouts.
That drift turns a presentation package into an application shell and makes reuse across sibling apps more brittle.

## Decision

MHUI owns reusable presentation primitives and container patterns.
Host apps own product wording, feature meaning, business-state branching, and navigation semantics.

## Consequences

- Package APIs should favor generic layout and styling intent over feature-specific screen types.
- Host apps remain responsible for composing domain-specific screens out of MHUI primitives.
- If a package API starts depending on one product's vocabulary, that is a refactoring signal.
- Shared visual consistency improves without forcing sibling apps into one product's information architecture.
