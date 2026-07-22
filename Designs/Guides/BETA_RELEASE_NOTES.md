# Beta Release Notes

## Next Beta

### Changed

- Standard design metrics now use a wider readable content width, larger regular
  screen margins, and a broader section rhythm for a more editorial review
  layout.
- Standard surface radius is tighter, dividers and surface borders are quieter,
  and screen/section cue rules are longer to make package chrome feel more like
  a precise index frame than a dense settings panel.
- Standard typography keeps platform system font designs for readability and
  Dynamic Type consistency. Section titles now use a compact system subheadline
  treatment, while metadata and compact captions keep monospaced system treatment
  for scannable labels.
- Default semantic color assets move slightly toward a warmer neutral canvas and
  softer border contrast while keeping concrete colors in the asset catalog.
- Signature validation previews now use generic editorial review content and an
  image-free grid so package chrome can be reviewed without app-owned assets or
  design-source identifiers.

### Migration Notes

- Review snapshot baselines and custom spacing assumptions for `MHDesignMetrics`
  and `MHTheme.standard`; readable width, screen insets, section spacing, surface
  radius, row padding, cue length, divider opacity, and border opacity changed
  intentionally during beta.
- If a beta consumer set `MHTheme.TextStyle.design` to `.serif`, replace it with
  `.standard` or remove the argument. The package does not keep a serif design
  token during beta.
- Apps that need a stronger brand voice should keep that in app-owned assets,
  copy, navigation, and root accent configuration rather than relying on package
  typography presets.
