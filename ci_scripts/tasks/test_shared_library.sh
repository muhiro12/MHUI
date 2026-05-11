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
test_destination="${MHUI_TEST_DESTINATION:-platform=iOS Simulator,name=iPhone 17 Pro Max}"
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

echo "Running Xcode tests for MHUI package."
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
