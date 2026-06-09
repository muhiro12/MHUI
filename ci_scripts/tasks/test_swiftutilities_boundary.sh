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

boundary_script="$repository_root/ci_scripts/tasks/check_swiftutilities_boundary.sh"
work_parent="${CI_RUN_WORK_DIR:-${AI_RUN_WORK_DIR:-/tmp}}"
temporary_root=$(mktemp -d "$work_parent/swiftutilities-boundary.XXXXXX")

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
    "$temporary_root/MHUI/Tests"

  cp "$boundary_script" "$temporary_root/ci_scripts/tasks/check_swiftutilities_boundary.sh"
  chmod +x "$temporary_root/ci_scripts/tasks/check_swiftutilities_boundary.sh"
}

write_clean_probe() {
  printf '%s\n' \
    '// swift-tools-version: 6.2' \
    'import PackageDescription' \
    'let package = Package(name: "BoundaryProbe")' \
    > "$temporary_root/Package.swift"

  printf '%s\n' \
    'import SwiftUI' \
    'public struct ProbeView: View {' \
    '    public var body: some View { Text("Probe") }' \
    '}' \
    > "$temporary_root/MHUI/Sources/ProbeView.swift"
}

write_violation_probe() {
  printf '%s\n' \
    '// swift-tools-version: 6.2' \
    'import PackageDescription' \
    'let package = Package(' \
    '    name: "BoundaryProbe",' \
    '    dependencies: [' \
    '        .package(url: "https://github.com/muhiro12/SwiftUtilities", from: "1.0.0")' \
    '    ]' \
    ')' \
    > "$temporary_root/Package.swift"

  printf '%s\n' \
    'import SwiftData' \
    'import SwiftUtilities' \
    'public struct CloseButton {}' \
    'public extension View {' \
    '    func hidden(_ hidden: Bool = true) -> some View { self }' \
    '}' \
    > "$temporary_root/MHUI/Sources/Violation.swift"
}

require_output() {
  local output=$1
  local expected=$2

  if ! grep -Fq "$expected" <<<"$output"; then
    echo "Expected boundary test output to contain: $expected" >&2
    printf '%s\n' "$output" >&2
    return 1
  fi
}

create_probe_layout
write_clean_probe

(
  cd "$temporary_root"
  bash ci_scripts/tasks/check_swiftutilities_boundary.sh
)

write_violation_probe

set +e
violation_output=$(
  cd "$temporary_root"
  bash ci_scripts/tasks/check_swiftutilities_boundary.sh 2>&1
)
violation_status=$?
set -e

if [[ $violation_status -eq 0 ]]; then
  echo "Expected SwiftUtilities boundary check to fail for the violation probe." >&2
  printf '%s\n' "$violation_output" >&2
  exit 1
fi

require_output "$violation_output" "Package and project dependency files must not reference SwiftUtilities."
require_output "$violation_output" "Swift source files must not import SwiftUtilities."
require_output "$violation_output" "MHUI and MHDesign must not import SwiftData"
require_output "$violation_output" "MHUI must not add source-compatible SwiftUtilities API mirrors."

echo "SwiftUtilities boundary guard test passed."
