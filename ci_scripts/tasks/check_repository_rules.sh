#!/usr/bin/env bash
set -euo pipefail

script_directory=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "$script_directory/../lib/task_utils.sh"

ci_task_require_no_arguments "$@"
ci_task_enter_repository "${BASH_SOURCE[0]}"
repository_root=$CI_TASK_REPOSITORY_ROOT

echo "Running MHUI repository rule checks."

bash "$repository_root/ci_scripts/tasks/check_environment.sh" --profile rules
bash "$repository_root/ci_scripts/tasks/check_models_directory_consistency.sh"
bash "$repository_root/ci_scripts/tasks/check_swiftutilities_boundary.sh"
bash "$repository_root/ci_scripts/tasks/test_swiftutilities_boundary.sh"
bash "$repository_root/ci_scripts/tasks/test_mhui_consumer_adoption.sh"
bash "$repository_root/ci_scripts/tasks/lint_swift.sh"

echo "Repository rules check passed."
