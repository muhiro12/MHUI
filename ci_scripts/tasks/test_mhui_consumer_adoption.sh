#!/usr/bin/env bash
set -euo pipefail

script_directory=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "$script_directory/../lib/task_utils.sh"

ci_task_require_no_arguments "$@"
ci_task_enter_repository "${BASH_SOURCE[0]}"
repository_root=$CI_TASK_REPOSITORY_ROOT

sample_package_path="$repository_root/Examples/MHUIAdoptionSample"
default_shared_directory="${TMPDIR:-/tmp}/mhui-ci/shared"
shared_directory="${CI_SHARED_DIR:-$default_shared_directory}"
scratch_directory="$shared_directory/mhui-consumer-adoption"
cache_directory="$shared_directory/cache"
package_cache_directory="$cache_directory/package"
swiftpm_config_directory="$cache_directory/swiftpm/config"
swiftpm_security_directory="$cache_directory/swiftpm/security"
clang_module_cache_directory="$cache_directory/clang/ModuleCache"
local_home_directory="$shared_directory/home"
temporary_directory="$shared_directory/tmp"

mkdir -p \
  "$scratch_directory" \
  "$package_cache_directory" \
  "$swiftpm_config_directory" \
  "$swiftpm_security_directory" \
  "$clang_module_cache_directory" \
  "$local_home_directory/Library/Caches" \
  "$local_home_directory/Library/Developer" \
  "$local_home_directory/Library/Logs" \
  "$temporary_directory"

echo "Building the public MHUI adoption sample."
HOME="$local_home_directory" \
TMPDIR="$temporary_directory" \
XDG_CACHE_HOME="$cache_directory" \
CLANG_MODULE_CACHE_PATH="$clang_module_cache_directory" \
swift build \
  --package-path "$sample_package_path" \
  --disable-sandbox \
  --scratch-path "$scratch_directory" \
  --cache-path "$package_cache_directory" \
  --config-path "$swiftpm_config_directory" \
  --security-path "$swiftpm_security_directory" \
  -Xswiftc -module-cache-path \
  -Xswiftc "$clang_module_cache_directory" \
  --product MHUIAdoptionSample

echo "Public MHUI adoption sample build passed."
