#!/usr/bin/env bash
set -euo pipefail

script_directory=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "$script_directory/../lib/task_utils.sh"
source "$script_directory/../lib/swiftlint.sh"

ci_task_require_no_arguments "$@"
ci_task_enter_repository "${BASH_SOURCE[0]}"
repository_root=$CI_TASK_REPOSITORY_ROOT

bash "$repository_root/ci_scripts/tasks/check_environment.sh" --profile swiftlint
ci_swiftlint_run "$repository_root" format
