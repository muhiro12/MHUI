# ADR 0003: Example Integrations Stay Outside Package

- Date: 2026-03-10
- Status: Accepted
- Last reviewed: 2026-07-17

## Context

Shared UI packages often grow sample screens or example applications to validate adoption.
Those examples are useful, but they can become a shadow design layer if package APIs are only exercised or refined there.

## Decision

Keep example integration code outside the public package targets.
Maintain `Examples/MHUIAdoptionSample` as a nested, source-only Swift package
that depends on the repository root and imports only the public `MHUI` product.
It may demonstrate integration patterns and host previews, but shared styling
behavior must still be defined in `MHUI/Sources`.

Do not add an Xcode project solely to host the sample. Opening the nested Swift
package is sufficient for build and Preview review.

## Consequences

- The sample remains a public consumer rather than an architectural peer of the
  root package targets.
- If an example introduces a reusable styling helper, move that helper into the package.
- Repository rules compile the nested sample independently to catch public API
  adoption drift.
- The repository remains buildable and testable without an app project.
- Preview and example scaffolding should prove package behavior, not replace package-owned APIs.
