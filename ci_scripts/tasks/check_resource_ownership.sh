#!/usr/bin/env bash
set -euo pipefail

argument_count=$#
if [[ $argument_count -ne 0 ]]; then
  echo "This script does not accept arguments." >&2
  exit 2
fi

script_directory=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
repository_root=$(cd "$script_directory/../.." && pwd)
cd "$repository_root"

failure_count=0

record_failure() {
  local message=$1

  echo "Resource ownership violation: $message" >&2
  failure_count=$((failure_count + 1))
}

swift_roots=(
  MHDesign/Sources
  MHDesign/Tests
  MHUI/Sources
  MHUI/Tests
  Examples
)

raw_color_matches=$(
  find "${swift_roots[@]}" \
    -type f \
    -name '*.swift' \
    -print0 |
    xargs -0 grep -nE \
      'Color[[:space:]]*\([[:space:]]*(red|white|hue|displayP3Red)[[:space:]]*:|Color[[:space:]]*\([[:space:]]*\.sRGB|Color[[:space:]]*\([[:space:]]*(uiColor|nsColor)[[:space:]]*:|UIColor[[:space:]]*\([[:space:]]*(red|white|hue)[[:space:]]*:|NSColor[[:space:]]*\([[:space:]]*(calibratedRed|deviceRed|sRGBRed|white|hue)[[:space:]]*:|(lightHex|darkHex)[[:space:]]*:|#[[:xdigit:]]{6}([[:xdigit:]]{2})?' ||
    true
)

if [[ -n "$raw_color_matches" ]]; then
  record_failure "Define concrete colors in asset catalogs, not Swift source."
  printf '%s\n' "$raw_color_matches" >&2
fi

static_color_pattern='(primary|secondary|tertiary|red|orange|yellow|green|mint|teal|cyan|blue|indigo|purple|pink|brown|gray|white|black)'
static_color_matches=$(
  find "${swift_roots[@]}" \
    -type f \
    -name '*.swift' \
    -print0 |
    xargs -0 grep -nE \
      "(^|[^[:alnum:]_])Color\\.${static_color_pattern}([^[:alnum:]_]|$)|(foregroundStyle|foregroundColor|background|fill|stroke|tint)[[:space:]]*\\([[:space:]]*\\.${static_color_pattern}([^[:alnum:]_]|$)" ||
    true
)

if [[ -n "$static_color_matches" ]]; then
  record_failure "Map asset colors to semantic roles instead of using static SwiftUI palette colors."
  printf '%s\n' "$static_color_matches" >&2
fi

unowned_image_matches=$(
  find MHDesign MHUI Examples \
    \( -path '*/.build' -o -path '*/.swiftpm' \) -prune -o \
    -type f \
    \( \
      -iname '*.heic' -o \
      -iname '*.jpeg' -o \
      -iname '*.jpg' -o \
      -iname '*.pdf' -o \
      -iname '*.png' -o \
      -iname '*.svg' \
    \) \
    -not -path '*.xcassets/*' \
    -print ||
    true
)

if [[ -n "$unowned_image_matches" ]]; then
  record_failure "Store custom image files in asset catalogs."
  printf '%s\n' "$unowned_image_matches" >&2
fi

if [[ $failure_count -ne 0 ]]; then
  exit 1
fi

echo "Resource ownership check passed."
