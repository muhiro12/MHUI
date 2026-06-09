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

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "This script must run inside a git repository." >&2
  exit 1
fi

shared_directory="${CI_SHARED_DIR:-$repository_root/.build/ci/shared}"
cache_directory="${CI_CACHE_DIR:-$shared_directory/cache}"
temporary_directory="$shared_directory/tmp"
local_home_directory="$shared_directory/home"
derived_data_path="${CI_DERIVED_DATA_DIR:-$shared_directory/DerivedData}"
results_directory="${CI_RUN_RESULTS_DIR:-${AI_RUN_RESULTS_DIR:-$shared_directory/results}}"
package_cache_directory="$cache_directory/package"
cloned_source_packages_directory="$cache_directory/source_packages"
clang_module_cache_directory="$cache_directory/clang/ModuleCache"
package_workspace_path="$repository_root/.swiftpm/xcode/package.xcworkspace"
package_scheme="MHUI-Package"

resolve_test_destination() {
  if [[ -n "${MHUI_TEST_DESTINATION:-}" ]]; then
    printf '%s\n' "$MHUI_TEST_DESTINATION"
    return 0
  fi

  local available_destinations
  available_destinations=$(HOME="$local_home_directory" \
    TMPDIR="$temporary_directory" \
    XDG_CACHE_HOME="$cache_directory" \
    CLANG_MODULE_CACHE_PATH="$clang_module_cache_directory" \
    xcodebuild \
    -workspace "$package_workspace_path" \
    -scheme "$package_scheme" \
    -showdestinations 2>/dev/null || true)

  local preferred_device_names=(
    "iPhone 17 Pro Max"
    "iPhone 17 Pro"
    "iPhone 16 Pro Max"
    "iPhone 16 Pro"
    "iPhone 15 Pro Max"
    "iPhone 15 Pro"
  )
  local device_name
  for device_name in "${preferred_device_names[@]}"; do
    if grep -Fq "name:$device_name" <<<"$available_destinations"; then
      printf 'platform=iOS Simulator,name=%s\n' "$device_name"
      return 0
    fi
  done

  local first_available_iphone
  first_available_iphone=$(sed -nE \
    's/.*platform:iOS Simulator.*name:(iPhone[^,}]+).*/\1/p' \
    <<<"$available_destinations" | head -n 1)

  if [[ -n "$first_available_iphone" ]]; then
    printf 'platform=iOS Simulator,name=%s\n' "$first_available_iphone"
    return 0
  fi

  printf '%s\n' 'platform=iOS Simulator,name=iPhone 17 Pro Max'
}

timestamp=$(date +%s)
result_bundle_path="$results_directory/TestResults_MHUIPackage_${timestamp}.xcresult"

mkdir -p \
  "$cache_directory" \
  "$clang_module_cache_directory" \
  "$derived_data_path" \
  "$results_directory" \
  "$package_cache_directory" \
  "$cloned_source_packages_directory" \
  "$temporary_directory" \
  "$local_home_directory/Library/Caches"

test_destination=$(resolve_test_destination)

echo "Running Xcode tests for MHUI package."
echo "Using test destination: $test_destination"
HOME="$local_home_directory" \
TMPDIR="$temporary_directory" \
XDG_CACHE_HOME="$cache_directory" \
CLANG_MODULE_CACHE_PATH="$clang_module_cache_directory" \
xcodebuild \
  -workspace "$package_workspace_path" \
  -scheme "$package_scheme" \
  -destination "$test_destination" \
  -derivedDataPath "$derived_data_path" \
  -resultBundlePath "$result_bundle_path" \
  -clonedSourcePackagesDirPath "$cloned_source_packages_directory" \
  -packageCachePath "$package_cache_directory" \
  CODE_SIGNING_ALLOWED=NO \
  "CLANG_MODULE_CACHE_PATH=$clang_module_cache_directory" \
  test

echo "Finished MHUI package tests. Result bundle: $result_bundle_path"
