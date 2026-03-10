# ADR 0003: Example Integrations Stay Outside Package

- Date: 2026-03-10
- Status: Accepted

## Context

Shared UI packages often grow sample screens or example applications to validate adoption.
Those examples are useful, but they can become a shadow design layer if package APIs are only exercised or refined there.

## Decision

Keep example-app integration code outside the public package target.
Examples may consume MHUI and demonstrate integration patterns, but shared styling behavior must still be defined in `Sources/MHUI`.

## Consequences

- Example projects remain optional consumers rather than architectural peers of the package target.
- If an example introduces a reusable styling helper, move that helper into the package.
- Build automation may validate an example project when present, but the repository must still work without it.
- Preview and example scaffolding should prove package behavior, not replace package-owned APIs.
