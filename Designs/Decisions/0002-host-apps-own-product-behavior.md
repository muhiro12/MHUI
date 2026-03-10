# ADR 0002: Host Apps Own Product Behavior

- Date: 2026-03-10
- Status: Accepted

## Context

Shared UI packages often accumulate business models, feature navigation, logging, analytics, or network concerns as they grow.
That makes the package harder to reuse and couples sibling apps to one product's decisions.

## Decision

Keep business logic, product-specific navigation, persistence, logging, configuration, and infrastructure outside `MHUI`.
The package stays focused on presentation primitives and host-configurable visual composition.

## Consequences

- Public package APIs should stay domain neutral.
- Host apps remain responsible for models, workflows, and platform integrations.
- Example-specific code should stay outside the public API unless it proves broadly reusable.
- A request that needs business branching is a sign to add code in a host app or a different shared module, not in `MHUI`.
