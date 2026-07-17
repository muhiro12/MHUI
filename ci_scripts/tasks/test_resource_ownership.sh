#!/usr/bin/env bash
set -euo pipefail

argument_count=$#
if [[ $argument_count -ne 0 ]]; then
  echo "This script does not accept arguments." >&2
  exit 2
fi

script_directory=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
repository_root=$(cd "$script_directory/../.." && pwd)
resource_script="$repository_root/ci_scripts/tasks/check_resource_ownership.sh"
work_parent="${CI_RUN_WORK_DIR:-${AI_RUN_WORK_DIR:-/tmp}}"
temporary_root=$(mktemp -d "$work_parent/resource-ownership.XXXXXX")

cleanup() {
  rm -rf "$temporary_root"
}
trap cleanup EXIT

create_probe_layout() {
  mkdir -p \
    "$temporary_root/ci_scripts/tasks" \
    "$temporary_root/MHDesign/Sources" \
    "$temporary_root/MHDesign/Tests" \
    "$temporary_root/MHUI/Sources" \
    "$temporary_root/MHUI/Tests" \
    "$temporary_root/Examples"

  cp "$resource_script" "$temporary_root/ci_scripts/tasks/check_resource_ownership.sh"
  chmod +x "$temporary_root/ci_scripts/tasks/check_resource_ownership.sh"
}

write_clean_probe() {
  printf '%s\n' \
    'import SwiftUI' \
    'let accent = Color(ColorResource(name: "Accent", bundle: .module))' \
    'let symbol = Image(systemName: "star")' \
    'let treatment = accent.opacity(0.5)' \
    > "$temporary_root/MHUI/Sources/Clean.swift"
}

write_violation_probe() {
  printf '%s\n' \
    'import SwiftUI' \
    'let componentColor = Color(red: 0.2, green: 0.4, blue: 0.6)' \
    'let coreGraphicsColor = CGColor(red: 0.2, green: 0.4, blue: 0.6, alpha: 1)' \
    'let staticColor = Color.blue' \
    'let semanticColor = Text("Probe").foregroundStyle(.secondary)' \
    > "$temporary_root/MHUI/Sources/Violation.swift"

  printf 'not-a-real-image\n' \
    > "$temporary_root/Examples/LooseImage.png"
}

require_output() {
  local output=$1
  local expected=$2

  if ! grep -Fq "$expected" <<<"$output"; then
    echo "Expected resource ownership test output to contain: $expected" >&2
    printf '%s\n' "$output" >&2
    return 1
  fi
}

create_probe_layout
write_clean_probe

(
  cd "$temporary_root"
  bash ci_scripts/tasks/check_resource_ownership.sh
)

write_violation_probe

set +e
violation_output=$(
  cd "$temporary_root"
  bash ci_scripts/tasks/check_resource_ownership.sh 2>&1
)
violation_status=$?
set -e

if [[ $violation_status -eq 0 ]]; then
  echo "Expected resource ownership check to fail for the violation probe." >&2
  printf '%s\n' "$violation_output" >&2
  exit 1
fi

require_output "$violation_output" "Define concrete colors in asset catalogs"
require_output "$violation_output" "Map asset colors to semantic roles"
require_output "$violation_output" "Store custom image files in asset catalogs"

echo "Resource ownership guard test passed."
