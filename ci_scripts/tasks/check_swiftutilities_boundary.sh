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

  echo "SwiftUtilities boundary violation: $message" >&2
  failure_count=$((failure_count + 1))
}

dependency_reference_matches=$(
  find . \
    \( -path './.build' -o -path './.git' -o -path './.swiftpm' \) -prune -o \
    \( -name 'Package.swift' -o -name 'Package.resolved' -o -name 'project.pbxproj' \) \
    -type f \
    -print0 |
    xargs -0 grep -nE 'SwiftUtilities|github\.com/muhiro12/SwiftUtilities|\.\./SwiftUtilities' || true
)

if [[ -n "$dependency_reference_matches" ]]; then
  record_failure "Package and project dependency files must not reference SwiftUtilities."
  printf '%s\n' "$dependency_reference_matches" >&2
fi

swift_import_matches=$(
  find MHDesign/Sources MHUI/Sources MHDesign/Tests MHUI/Tests \
    -type f \
    -name '*.swift' \
    -print0 |
    xargs -0 grep -nE '^[[:space:]]*(@[^[:space:]]+[[:space:]]+)*import[[:space:]]+((class|enum|func|protocol|struct|var)[[:space:]]+)?SwiftUtilities([[:space:].]|$)' || true
)

if [[ -n "$swift_import_matches" ]]; then
  record_failure "Swift source files must not import SwiftUtilities."
  printf '%s\n' "$swift_import_matches" >&2
fi

swiftdata_import_matches=$(
  find MHDesign/Sources MHUI/Sources MHDesign/Tests MHUI/Tests \
    -type f \
    -name '*.swift' \
    -print0 |
    xargs -0 grep -nE '^[[:space:]]*(@[^[:space:]]+[[:space:]]+)*import[[:space:]]+SwiftData([[:space:].]|$)' || true
)

if [[ -n "$swiftdata_import_matches" ]]; then
  record_failure "MHUI and MHDesign must not import SwiftData; persistence helpers belong outside the presentation layer."
  printf '%s\n' "$swiftdata_import_matches" >&2
fi

swiftutilities_api_mirror_matches=$(
  find MHDesign/Sources MHUI/Sources \
    -type f \
    -name '*.swift' \
    -print0 |
    xargs -0 grep -nE 'public[[:space:]]+(struct|typealias)[[:space:]]+CloseButton([[:space:]:={]|$)|public[[:space:]]+enum[[:space:]]+SwiftUtilitiesError([[:space:]:{]|$)|enum[[:space:]]+Template[[:space:]]*:[[:space:]]*String|func[[:space:]]+hidden[[:space:]]*\(|func[[:space:]]+singleLine[[:space:]]*\(|func[[:space:]]+twoLines[[:space:]]*\(|func[[:space:]]+adjusted[[:space:]]*\([[:space:]]*by[[:space:]]|static[[:space:]]+func[[:space:]]+random[[:space:]]*\(|static[[:space:]]+func[[:space:]]+(space|icon|component)[[:space:]]*\(|static[[:space:]]+func[[:space:]]+fixed[[:space:]]*\([[:space:]]*_[[:space:]]+template[[:space:]]*:[[:space:]]*Template|static[[:space:]]+func[[:space:]]+default[[:space:]]*\([[:space:]]*_[[:space:]]+template[[:space:]]*:[[:space:]]*Template|init[[:space:]]*\([[:space:]]*data[[:space:]]*:[[:space:]]*Data|static[[:space:]]+var[[:space:]]+appIcon[[:space:]]*[:{]|(static[[:space:]]+)?var[[:space:]]+(empty|orEmpty|isNotEmpty|isZero|isNotZero|isPlus|isMinus|isEmptyOrDecimal|decimalValue|utc)[[:space:]]*[:{]|func[[:space:]]+(normalizedContains|fetchFirst|fetchRandom|base64Encoded|dateValueWithoutLocale|stringValue|endOfDay|startOfMonth|endOfMonth|startOfYear|endOfYear|shiftedDate|delete)[[:space:]]*(<[^>]+>)?[[:space:]]*\(|init[[:space:]]*\([[:space:]]*base64Encoded[[:space:]]+' || true
)

if [[ -n "$swiftutilities_api_mirror_matches" ]]; then
  record_failure "MHUI must not add source-compatible SwiftUtilities API mirrors."
  printf '%s\n' "$swiftutilities_api_mirror_matches" >&2
fi

swiftutilities_presentation_replacement_matches=$(
  find MHDesign/Sources MHUI/Sources \
    -type f \
    -name '*.swift' \
    -print0 |
    xargs -0 grep -nE '(struct|typealias)[[:space:]]+MHDismissButton([[:space:]:{]|$)|func[[:space:]]+mhHidden[[:space:]]*\(|func[[:space:]]+mhSingleLine[[:space:]]*\(|func[[:space:]]+mhTwoLines[[:space:]]*\(|func[[:space:]]+mhAdjusted[[:space:]]*\([[:space:]]*by[[:space:]]' || true
)

if [[ -n "$swiftutilities_presentation_replacement_matches" ]]; then
  record_failure "MHUI must not add MHUI-prefixed SwiftUtilities presentation replacements."
  printf '%s\n' "$swiftutilities_presentation_replacement_matches" >&2
fi

if [[ $failure_count -ne 0 ]]; then
  exit 1
fi

echo "SwiftUtilities boundary check passed."
