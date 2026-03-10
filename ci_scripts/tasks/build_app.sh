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
work_directory="${CI_RUN_WORK_DIR:-${AI_RUN_WORK_DIR:-$shared_directory/work}}"
cache_directory="${CI_CACHE_DIR:-${AI_RUN_CACHE_ROOT:-$shared_directory/cache}}"
derived_data_path="${CI_DERIVED_DATA_DIR:-$shared_directory/DerivedData}"
results_directory="${CI_RUN_RESULTS_DIR:-${AI_RUN_RESULTS_DIR:-$work_directory/results}}"

local_home_directory="$shared_directory/home"
temporary_directory="$shared_directory/tmp"
clang_module_cache_directory="$cache_directory/clang/ModuleCache"
package_cache_directory="$cache_directory/package"
cloned_source_packages_directory="$cache_directory/source_packages"
swiftpm_cache_directory="$cache_directory/swiftpm/cache"
swiftpm_config_directory="$cache_directory/swiftpm/config"

mkdir -p \
  "$work_directory" \
  "$local_home_directory/Library/Caches" \
  "$local_home_directory/Library/Developer" \
  "$local_home_directory/Library/Logs" \
  "$cache_directory" \
  "$clang_module_cache_directory" \
  "$package_cache_directory" \
  "$cloned_source_packages_directory" \
  "$swiftpm_cache_directory" \
  "$swiftpm_config_directory" \
  "$temporary_directory" \
  "$derived_data_path" \
  "$results_directory"

echo "Running swift build for MHUI package."
HOME="$local_home_directory" \
TMPDIR="$temporary_directory" \
XDG_CACHE_HOME="$cache_directory" \
CLANG_MODULE_CACHE_PATH="$clang_module_cache_directory" \
SWIFTPM_CACHE_PATH="$swiftpm_cache_directory" \
SWIFTPM_CONFIG_PATH="$swiftpm_config_directory" \
swift build

example_project_path="$repository_root/Example/MHUIExample.xcodeproj"
if [[ ! -d "$example_project_path" ]]; then
  echo "Example project not found. Skipping MHUIExample build."
  exit 0
fi

timestamp=$(date +%s)
result_bundle_path="$results_directory/BuildResults_MHUIExample_${timestamp}.xcresult"

echo "Building MHUIExample (macOS)."
HOME="$local_home_directory" \
TMPDIR="$temporary_directory" \
XDG_CACHE_HOME="$cache_directory" \
CLANG_MODULE_CACHE_PATH="$clang_module_cache_directory" \
SWIFTPM_CACHE_PATH="$swiftpm_cache_directory" \
SWIFTPM_CONFIG_PATH="$swiftpm_config_directory" \
xcodebuild \
  -project "$example_project_path" \
  -scheme "MHUIExample" \
  -destination 'generic/platform=macOS' \
  -derivedDataPath "$derived_data_path" \
  -resultBundlePath "$result_bundle_path" \
  -clonedSourcePackagesDirPath "$cloned_source_packages_directory" \
  -packageCachePath "$package_cache_directory" \
  CODE_SIGNING_ALLOWED=NO \
  CODE_SIGNING_REQUIRED=NO \
  "CLANG_MODULE_CACHE_PATH=$clang_module_cache_directory" \
  build

echo "Finished MHUIExample build. Result bundle: $result_bundle_path"
