# Visual Design Principles

MHUI gives calm, tool-like SwiftUI apps a recognizable presentation while
remaining at home on Apple platforms. Platform conventions are the foundation,
not a source of visual decoration. Shared styling must preserve native behavior,
accessibility, hierarchy, and adaptation before adding an MHUI treatment.

## A Quiet Content Plane

Content should feel stable, spacious, and easy to read. The standard theme uses
an achromatic foundation: neutral planes and text without hue, restrained
geometry, and generous whitespace. Structure comes from geometry, spacing,
proportion, and useful hierarchy. It avoids decorative borders and shadows,
stacked frames, simulated materials or textures, and color that does not
communicate meaning.

Most screens should remain visually quiet. A surface earns distinction through
its content role, not because every region needs a card treatment.

## A Floating Functional Layer

Navigation and controls form a functional layer above content. On platforms
that provide Liquid Glass, MHUI prefers native controls and system containers so
this depth appears naturally. Package-owned glass is limited to important,
domain-neutral interactive chrome and retains opaque accessibility and runtime
fallbacks.

Liquid Glass is not a content background or a universal card material. Content
surfaces, rows, metadata, and inputs remain on the stable content plane unless a
concrete interaction requires system-provided glass.

## Selective Emphasis

MHUI provides deliberate composition for moments that benefit from attention:
an overview, a concise summary, a leading figure, an insight, or a meaningful
transition in a task. Hierarchy comes from proportion, alignment, whitespace,
and pacing before it comes from color.

Emphasis is selective. Routine collections, forms, settings, and navigation
keep their native semantics and should not be restyled into a magazine-like
composition merely to appear distinctive. A screen does not need a hero block,
and one surface should not be framed inside another.

## Structure Before Decoration

The content and functional layers stay connected through consistent spacing,
alignment, and measured motion rather than repeated decoration. Standard
surfaces are borderless and differ from the canvas by neutral tone alone.

Rules and outlines are structural aids, not identity marks. Keep separators
between grouped rows, visible boundaries on detached inputs, and clear pressed,
focused, and disabled states. Increase Contrast adds outlines where tone alone
would be too subtle. Do not add ornamental rules or frames.

Color remains sparse. The host accent identifies primary action, focus, status,
and native control state, and warning and destructive colors carry their
semantic status. Large areas of saturated color belong to meaningful app
content, such as media, rather than shared MHUI chrome.

## Decision Order

When designing or reviewing an MHUI screen, decide in this order:

1. Preserve the native container and control behavior required by the task.
2. Establish a legible, quiet content hierarchy.
3. Identify whether one moment genuinely benefits from emphasis.
4. Let navigation and important actions occupy the floating functional layer.
5. Remove any color, surface, rule, or motion that does not clarify the result.

The result should feel calm before it feels styled, spatial before it feels
decorated, and distinctive through restraint rather than novelty.
