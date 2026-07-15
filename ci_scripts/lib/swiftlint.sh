#!/usr/bin/env bash

ci_swiftlint_shared_directory() {
  local repository_root=$1
  printf '%s\n' "${CI_SHARED_DIR:-$repository_root/.build/ci/shared}"
}

ci_swiftlint_cache_directory() {
  local repository_root=$1
  local shared_directory

  shared_directory=$(ci_swiftlint_shared_directory "$repository_root")
  printf '%s\n' "${CI_CACHE_DIR:-${AI_RUN_CACHE_ROOT:-$shared_directory/cache}}"
}

ci_swiftlint_scratch_directory() {
  local repository_root=$1
  local shared_directory

  shared_directory=$(ci_swiftlint_shared_directory "$repository_root")
  printf '%s\n' "$shared_directory/swiftpm"
}

ci_swiftlint_package_cache_directory() {
  local repository_root=$1
  local cache_directory

  cache_directory=$(ci_swiftlint_cache_directory "$repository_root")
  printf '%s\n' "$cache_directory/package"
}

ci_swiftlint_swiftpm_config_directory() {
  local repository_root=$1
  local cache_directory

  cache_directory=$(ci_swiftlint_cache_directory "$repository_root")
  printf '%s\n' "$cache_directory/swiftpm/config"
}

ci_swiftlint_security_directory() {
  local repository_root=$1
  local cache_directory

  cache_directory=$(ci_swiftlint_cache_directory "$repository_root")
  printf '%s\n' "$cache_directory/swiftpm/security"
}

ci_swiftlint_temporary_directory() {
  local repository_root=$1
  local shared_directory

  shared_directory=$(ci_swiftlint_shared_directory "$repository_root")
  printf '%s\n' "$shared_directory/tmp"
}

ci_swiftlint_local_home_directory() {
  local repository_root=$1
  local shared_directory

  shared_directory=$(ci_swiftlint_shared_directory "$repository_root")
  printf '%s\n' "$shared_directory/home"
}

ci_swiftlint_prepare_directories() {
  local repository_root=$1
  local shared_directory
  local cache_directory
  local scratch_directory
  local package_cache_directory
  local swiftpm_config_directory
  local security_directory
  local temporary_directory
  local local_home_directory

  shared_directory=$(ci_swiftlint_shared_directory "$repository_root")
  cache_directory=$(ci_swiftlint_cache_directory "$repository_root")
  scratch_directory=$(ci_swiftlint_scratch_directory "$repository_root")
  package_cache_directory=$(ci_swiftlint_package_cache_directory "$repository_root")
  swiftpm_config_directory=$(ci_swiftlint_swiftpm_config_directory "$repository_root")
  security_directory=$(ci_swiftlint_security_directory "$repository_root")
  temporary_directory=$(ci_swiftlint_temporary_directory "$repository_root")
  local_home_directory=$(ci_swiftlint_local_home_directory "$repository_root")

  mkdir -p \
    "$shared_directory" \
    "$cache_directory" \
    "$scratch_directory" \
    "$package_cache_directory" \
    "$swiftpm_config_directory" \
    "$security_directory" \
    "$temporary_directory" \
    "$local_home_directory/Library/Caches" \
    "$local_home_directory/Library/Developer" \
    "$local_home_directory/Library/Logs"
}

ci_swiftlint_collect_files() {
  git ls-files -z -- '*.swift'
  git ls-files -z --others --exclude-standard -- '*.swift'
}

ci_swiftlint_find_binary() {
  local repository_root=$1
  local scratch_directory
  local search_root
  local candidate

  if [[ -n "${CI_SWIFTLINT_BIN:-}" && -x "${CI_SWIFTLINT_BIN:-}" ]]; then
    printf '%s\n' "$CI_SWIFTLINT_BIN"
    return 0
  fi

  scratch_directory=$(ci_swiftlint_scratch_directory "$repository_root")

  for search_root in \
    "$scratch_directory" \
    "$repository_root/.build"
  do
    if [[ ! -d "$search_root/artifacts" ]]; then
      continue
    fi

    candidate=$(
      find \
        "$search_root/artifacts" \
        -path '*/SwiftLintBinary.artifactbundle/macos/swiftlint' \
        -type f \
        -print 2>/dev/null | LC_ALL=C sort | head -n 1
    )

    if [[ -n "$candidate" ]]; then
      printf '%s\n' "$candidate"
      return 0
    fi
  done

  return 1
}

ci_swiftlint_resolve_binary() {
  local repository_root=$1
  local package_cache_directory
  local scratch_directory
  local swiftpm_config_directory
  local security_directory
  local temporary_directory
  local local_home_directory
  local resolve_output
  local resolve_status
  local candidate

  if candidate=$(ci_swiftlint_find_binary "$repository_root"); then
    printf '%s\n' "$candidate"
    return 0
  fi

  ci_swiftlint_prepare_directories "$repository_root"

  if ! command -v swift >/dev/null 2>&1; then
    echo "swift command not found while resolving the package-managed SwiftLint binary." >&2
    return 1
  fi

  package_cache_directory=$(ci_swiftlint_package_cache_directory "$repository_root")
  scratch_directory=$(ci_swiftlint_scratch_directory "$repository_root")
  swiftpm_config_directory=$(ci_swiftlint_swiftpm_config_directory "$repository_root")
  security_directory=$(ci_swiftlint_security_directory "$repository_root")
  temporary_directory=$(ci_swiftlint_temporary_directory "$repository_root")
  local_home_directory=$(ci_swiftlint_local_home_directory "$repository_root")

  resolve_output=$(mktemp "${TMPDIR:-/tmp}/swiftlint-resolve.XXXXXX")
  echo "Resolving package-managed SwiftLint binary..." >&2
  set +e
  HOME="$local_home_directory" \
    TMPDIR="$temporary_directory" \
    XDG_CACHE_HOME="$(ci_swiftlint_cache_directory "$repository_root")" \
    swift package \
      --package-path "$repository_root" \
      --scratch-path "$scratch_directory" \
      --cache-path "$package_cache_directory" \
      --config-path "$swiftpm_config_directory" \
      --security-path "$security_directory" \
      resolve >"$resolve_output" 2>&1
  resolve_status=$?
  set -e

  if [[ $resolve_status -ne 0 ]]; then
    cat "$resolve_output" >&2
    rm -f "$resolve_output"
    return "$resolve_status"
  fi

  rm -f "$resolve_output"

  if candidate=$(ci_swiftlint_find_binary "$repository_root"); then
    printf '%s\n' "$candidate"
    return 0
  fi

  echo "Could not locate the package-managed SwiftLint binary after resolving package dependencies." >&2
  return 1
}

ci_swiftlint_run() {
  local repository_root=$1
  local mode=$2
  local empty_message
  local start_message
  local finish_message
  local swiftlint_binary
  local -a swift_files=()

  case "$mode" in
    format)
      empty_message="No Swift files found to format."
      start_message="Formatting Swift files with SwiftLint..."
      finish_message="Finished formatting Swift files."
      ;;
    lint)
      empty_message="No Swift files found to lint."
      start_message="Linting Swift files with SwiftLint..."
      finish_message="Finished linting Swift files."
      ;;
    *)
      echo "Unknown SwiftLint mode: $mode" >&2
      return 2
      ;;
  esac

  while IFS= read -r -d '' file; do
    swift_files+=("$file")
  done < <(ci_swiftlint_collect_files)

  if [[ ${#swift_files[@]} -eq 0 ]]; then
    echo "$empty_message"
    return 0
  fi

  swiftlint_binary=$(ci_swiftlint_resolve_binary "$repository_root")

  echo "$start_message"
  case "$mode" in
    format)
      "$swiftlint_binary" lint --quiet --no-cache --fix --format "${swift_files[@]}"
      ;;
    lint)
      "$swiftlint_binary" lint --quiet --no-cache --strict "${swift_files[@]}"
      ;;
  esac
  echo "$finish_message"
}
