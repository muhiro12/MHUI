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

The canvas is pure white in light appearance and pure black in dark appearance.
White supports a clear relationship between text and empty space. Black provides
an equally neutral dark base; normal primary text is softened to 90% sRGB gray
instead of using maximum white everywhere. Increased Contrast restores full
black and white. These are screen design choices, not simulated paper or ink.

Most screens should remain visually quiet. A surface earns distinction through
its content role, not because every region needs a card treatment.

## Composition on an Open Canvas

Place related information along a common leading edge. Keep a caption close to
its subject and leave a larger interval before the next independent group.
Do not give every item equal area: a useful leading figure or summary can be
larger while its supporting details occupy a narrower column. At compact widths,
stack that relationship without changing reading order; at accessibility sizes,
allow every item the full width.

`mhSection` groups a header, content, and footer without painting a background.
`MHGroupedRows` aligns rows and separators to that content edge; its parent owns
horizontal padding. A detached note or input group can explicitly opt into
`mhSurfaceInset()` and `mhSurface()`. Avoid using a surface simply to compensate
for unclear alignment or an ambiguous gap.

Large headings use regular-weight system type. Section labels and row titles
retain more weight for scanning. This contrast of scale and weight should make
hierarchy visible on a blank canvas without all-caps transformations, condensed
fonts, or artificial tracking. Preserve Dynamic Type and native language shapes.

Photography, documents, charts, and other app content may provide shape, texture,
and color. Shared chrome must not imitate those materials or force every app to
include imagery. The same composition must work with plain text and numbers.

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

Emphasis is selective. Native semantics do not require native appearance.
A main collection or editor can use MHUI hierarchy inside List or Form, while
settings retain familiar system presentation. The app chooses by purpose. A screen does not need a hero block,
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

## Intentional Design Parameters

Shared spacing and layout are defined once in `MHDesignMetrics.standard` and
used by the standard MHUI theme. Explicit host metrics remain supported. These
choices establish a working rhythm rather than reproducing an earlier release.
Metrics-only adopters also need to review layout when updating the package.

| Parameter | Standard choice | Reason |
| --- | --- | --- |
| Spacing | 8 / 16 / 20 / 32 / 48 points | Separate inline, control, content, section, and screen relationships without excessive blank space |
| Compact screen | 24-point horizontal and top inset; 32-point content spacing | Align content clearly and bring the first useful information closer to navigation |
| Regular screen | 40-point insets and spacing; 640-point readable width | Keep prose and summaries coherent within wide content columns |
| Native content rows | 24 / 32-point horizontal inset; 16 / 20-point vertical padding | Keep native row targets comfortably inset at compact / regular widths |
| Grouped content | No implicit horizontal inset or section surface; 8-point section gaps plus row padding | Align headings, rows, and captions while leaving outer padding to the screen or an explicit surface |
| Display hierarchy | Regular-weight screen titles; iOS summaries use system title | Separate the leading thought from body copy through scale rather than a badge or background |
| Section typography | System title3, medium | Give content sections an identifiable hierarchy above body copy |
| Surface / control radius | 6 / 8 points retained | Quiet, nearly rectangular content planes and softly bounded fields; native controls keep their contextual shapes |
| Minimum controls | 44 points; 28 on macOS, retained | Preserve platform-appropriate interaction targets |
| Surface tones | White / black canvas; muted 98% / 4%, standard 96% / 8%, elevated 92% / 14% sRGB gray | Reserve progressively stronger tonal separation for explicit supporting planes |
| Motion | 0.18 / 0.30 seconds retained | Short state feedback; no decorative motion added |

Watch layouts retain their compact platform baseline. Surface insets retain
20 / 18 points on compact layouts and 28 / 24 on regular layouts because they
separate a surface's contents without competing with the screen margin.
Semantic status hues remain distinct; brand accent belongs to the host.
Surface values above describe normal contrast; accessibility variants and
contrast outlines provide stronger separation. Color differences alone do not
communicate selection, focus, or the boundaries of system navigation containers.

Navigation structure is not a styling canvas. Preserve native sidebar depth,
split dividers, tab bars, and sheet boundaries. Apply content treatment inside
individual destinations or columns, and verify their selected states as well
as their unselected appearance. Native-relative row foreground hierarchy
allows selected text to remain readable without changing MHUI typography.
