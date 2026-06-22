#!/usr/bin/env bash

ci_swiftlint_collect_files() {
  git ls-files -z -- '*.swift'
  git ls-files -z --others --exclude-standard -- '*.swift'
}

ci_swiftlint_require_binary() {
  if command -v swiftlint >/dev/null 2>&1; then
    return 0
  fi

  echo "swiftlint is not installed. Install it and retry." >&2
  echo "Install with: brew install swiftlint" >&2
  return 1
}

ci_swiftlint_run() {
  local mode=$1
  local empty_message
  local start_message
  local finish_message
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

  ci_swiftlint_require_binary

  echo "$start_message"
  case "$mode" in
    format)
      swiftlint lint --quiet --no-cache --fix --format "${swift_files[@]}"
      ;;
    lint)
      swiftlint lint --quiet --no-cache --strict "${swift_files[@]}"
      ;;
  esac
  echo "$finish_message"
}
