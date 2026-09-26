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

The canvas is pure white in light appearance and near-black (`#0E0E0E`) in dark
appearance. White supports a clear relationship between text and empty space.
Near-black keeps a neutral dark base while softening the transition to content. Primary text uses a softened gray (`#444444`) in light appearance
and softened light gray in dark appearance. Increased Contrast strengthens
foreground differentiation. These are screen design choices, not simulated
paper or ink.

Package-owned destructive and warning colors use restrained red and ochre,
with separate light, dark, and increased-contrast variants. Their meaning must
also be conveyed through labels or symbols. Native system controls retain their
platform semantics; these assets style MHUI-owned content and treatments.

Concrete asset RGB channels use hexadecimal sRGB notation consistently.
Identical high-contrast variants are omitted only when the normal variant
already supplies the intended result, as with the white and near-black canvas.

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
Within a composed section, the header-to-content and content-to-footer gaps use
`spacing.inline` (8 points by default). Adjacent sections should use
`spacing.section` (40 points by default). The header contributes no hidden
bottom padding in a stack. Row and button padding remains inside the content,
so visible text-to-text distances can exceed those structural gaps.
Native List/Form header geometry remains a separate container concern.
Use a screen-sized gap between independent groups in spacious compositions.
`MHGroupedRows` aligns rows and separators to that content edge; its parent owns
horizontal padding. A detached note or input group can explicitly opt into
`mhSurfaceInset()` and `mhSurface()`. Avoid using a surface simply to compensate
for unclear alignment or an ambiguous gap.

Screen names belong to native navigation, preserving scroll transitions and
platform title behavior. Standalone content headings use bold system type as a
clear entry point. Summary text keeps
regular weight, while section labels and row titles use moderate emphasis for
scanning. Use scale, weight, and whitespace before adding a different typeface
or tracking. Preserve Dynamic Type and native language shapes.

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
| Spacing | 8 / 16 / 24 / 40 / 48 points | Separate inline, control, content, section, and screen relationships with generous space between groups instead of decorative boundaries |
| Compact screen | 24-point horizontal and top inset; 40-point content spacing | Align content clearly and bring the first useful information closer to navigation |
| Regular screen | 40-point insets and spacing; available column width | Let text and media share the available width without a separate prose limit |
| Native content rows | Native horizontal margins on macOS; 16 / 40-point content inset elsewhere; 16-point vertical padding | Keep native row targets comfortably inset at compact / regular widths |
| Grouped content | No implicit horizontal inset or section surface; 8-point section gaps plus row padding | Align headings, rows, and captions while leaving outer padding to the screen or an explicit surface |
| Display hierarchy | Native navigation titles; bold standalone headings; regular-weight iOS summaries | Separate the leading thought from body copy through scale and weight without a badge or background |
| Section typography | System title3, medium | Give content sections an identifiable hierarchy above body copy |
| Surface / control radius | 8 / 8 points | Quiet, nearly rectangular content planes and softly bounded fields; native controls keep their contextual shapes |
| Minimum controls | 48 points; 32 on macOS | Preserve platform-appropriate interaction targets |
| Surface tones | White / near-black canvas; dark muted `#181818`, standard `#242424`, elevated `#323232` | Reserve progressively stronger tonal separation for explicit supporting planes |
| Motion | 0.18 / 0.30 seconds retained | Short state feedback; no decorative motion added |

Watch layouts use 16-point screen and surface insets. Other platforms use
16-point compact and 24-point regular surface insets. Action styles share
16-point horizontal and 8-point vertical padding across roles and arrangements.
Semantic status hues remain distinct; brand accent belongs to the host.
Surface values above describe normal contrast; accessibility variants and
contrast outlines provide stronger separation. Color differences alone do not
communicate selection, focus, or the boundaries of system navigation containers.

Navigation structure is not a styling canvas. Preserve native sidebar depth,
split dividers, tab bars, and sheet boundaries. Apply content treatment inside
individual destinations or columns, and verify their selected states as well
as their unselected appearance. MHUI text retains theme colors in content rows and resolves to the native
foreground hierarchy on prominent selection backgrounds. Themed native
container presentation retains the same MHUI text hierarchy. Navigation
titles can still share MHUI's primary text color through the app-wide iOS
startup configuration; this does not replace native title behavior.

### Dimension ownership and grid

MHDesign owns every package-defined dimension. MHUI maps these metrics to
presentation roles; it must not introduce independent point values. Standard
spacing, radii, thresholds, and component dimensions are multiples of 8 points.
Zero means no spacing. A 1-point stroke is a separate drawing metric. A 4-point
minimum spacing may be introduced only for a demonstrated need; it does not
permit 12, 20, or 28-point tokens. No 4-point token is currently needed.

The grid governs design parameters, not measured text or the final size of
responsive layouts. Native controls retain their intrinsic dimensions. System
text styles retain Dynamic Type. MHDesign does not define font sizes. Preview
device sizes describe test environments rather than design tokens.

Package-styled actions use a minimum target of 48 points on touch platforms
and 32 points on macOS; content can grow beyond that minimum. Padding does not
define a hit target by itself. The standard theme derives presentation and
stroke defaults from the metrics passed to `MHTheme.standard(metrics:)`.
Explicit host presentation overrides remain supported.

Native control sizing remains owned by the OS, even when its dimensions are not
multiples of 8. The minimum-target token is not a global control constraint.
MHUI applies it to its own custom action body and detached content chrome, where
standard control sizing is not supplied by the custom style. Do not apply that
minimum to system toggles, toolbar buttons, or native List/Form rows merely to
force them onto the grid. The control-sizing Preview distinguishes layout bounds
from hit regions; measured bounds alone do not prove hit-testing behavior.

A split view column is a placement, not a styling role. A primary library can
keep content presentation when shown next to its detail or as the initial
compact screen. Preserve the native split container and selection behavior;
do not require native row presentation solely because a column is leading.
Navigation-only source lists and content-first lists are distinct use cases.
