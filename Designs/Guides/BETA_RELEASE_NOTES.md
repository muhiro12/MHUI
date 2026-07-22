# Beta Release Notes

## Next Beta

### Changed

- Standard typography now keeps screen and summary titles on the platform's
  standard system font design for readability and Dynamic Type consistency.
- Metadata and compact captions keep a monospaced system treatment for scannable
  editorial labels.
- Screen and section cues use thin top rules, with tighter surface corners and
  quieter divider opacity for a more index-like presentation rhythm.
- Signature validation previews now use generic editorial review content and an
  image-free grid so package chrome can be reviewed without app-owned assets.

### Migration Notes

- If a beta consumer set `MHTheme.TextStyle.design` to `.serif`, replace it with
  `.standard` or remove the argument. The package does not keep a serif design
  token during beta.
- Review custom screenshots and snapshot baselines for `mhScreen`, `mhSection`,
  `MHSummary`, and `MHGroupedRows`; the default cue placement, rule weight,
  surface radius, and divider opacity changed intentionally.
- Apps that need a stronger brand voice should keep that in app-owned assets,
  copy, and root accent configuration rather than relying on package typography
  presets.
