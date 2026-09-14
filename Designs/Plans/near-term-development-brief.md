# Near-Term Development Brief

> Status: Temporary execution brief, current as of August 22, 2026. Use it
> until the visual direction is accepted in Stally and ready for Cookle's first
> post-iOS 27 adoption, then replace it with durable package decisions.

## Mission

Make MHUI produce a visual result worth sharing across the app family. The
current priority is not API growth or adoption count; it is an accepted,
native-feeling output with clear hierarchy, calm rhythm, useful adaptation,
and a coherent relationship between MHDesign metrics and MHUI treatments.

Use Stally as the primary full-MHUI proving ground. Use Fluel as secondary
evidence only while its future remains undecided. Prepare Cookle as the next
intentional adopter after iOS 27, while keeping current Incomes and Cookle
MHDesign consumers safe.

## First Work

1. Capture the current package output and representative Stally screens before
   changing code. Include at least an overview, a detail or reading surface, a
   native List or Form path, an empty state, and an action-heavy state.
2. Separate technical correctness from visual acceptance:
   - technical: clipping, adaptation, Dynamic Type, appearance, contrast,
     accessibility, input, and native container behavior;
   - visual: information hierarchy, density, spacing rhythm, typography,
     surfaces, cues, actions, native character, and room for app identity.
3. Describe the desired output and acceptance criteria through explicit visual
   review. Do not treat the current standard theme as correct merely because it
   compiles or passes structural tests.
4. Redesign one small vertical slice in the order tokens, semantic roles, then
   treatments. Exercise both a signature composition path and a native List or
   Form bridge when the product needs both.
5. Compare the slice in package previews and Stally. Only after the direction
   is accepted should it expand across MHUI and become a visual regression
   baseline.
6. Apply the accepted direction to Cookle's first post-iOS 27 full-MHUI
   adoption. Cookle controls its migration scope and app-owned composition.

## MHDesign Boundary

Treat MHDesign as the neutral shared metrics layer, not as an automatic part of
every MHUI visual change. Change standard metrics only when Incomes, Cookle,
and the styled consumers genuinely need the same value. Keep app-specific
screen density, composition, and product identity outside the package.

MHUI may use current SDK capabilities behind explicit availability and
fallback behavior. Do not raise its iOS 18, macOS 15, or watchOS 11 deployment
contracts merely because Stally targets iOS 27; such a change requires a
separate package decision.

## Non-Goals

- Increasing component or modifier count as a measure of progress.
- Freezing the current unaccepted appearance as a golden baseline.
- Replacing native SwiftUI controls, List, Form, navigation, or system
  interaction behavior.
- Owning product wording, domain state, navigation meaning, or app shells.
- Forcing simultaneous full-MHUI adoption across all apps.
- Using Liet as a priority design pilot.
- Changing the established direct-to-`main` and tag workflow.

## Completion Evidence

Completion requires accepted before-and-after results on representative
screens, not only tests. Build and test `MHUI-Package`, run
`bash ci_scripts/tasks/check_repository_rules.sh`, render targeted previews,
and review compact and regular widths, light and dark appearance, Dynamic Type,
Increase Contrast, and Reduce Transparency where relevant. Add Stally runtime
screenshots and logs; repeat equivalent consumer evidence when Cookle adoption
begins.
