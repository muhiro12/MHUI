# AGENTS.md

Repository-specific agent contract for MHUI.

## Repository Boundaries

- `MHDesign` owns shared spacing, corner-radius, generic screen and surface
  layout metrics, and the SwiftUI environment bridge that work without MHUI
  chrome.
- `MHUI` owns semantic theme application, standard theme assets, presentation
  primitives, native-container chrome, package-owned fallback behavior, preview
  validation, and re-export of `MHDesign` for styled adopters.
- Host apps own business logic, domain models, product wording, navigation
  meaning, app-specific screen shells, persistence, networking, analytics,
  logging, configuration, and platform side effects.
- Do not add replacement controls that shadow native SwiftUI controls.
- Do not add low-level Liquid Glass choreography APIs without a concrete
  package-owned primitive that needs them.

## Repository Rules

- Use English for branch names, code comments, documentation, and identifiers
  unless UI localization or legal content requires otherwise.
- Follow existing architecture and source style; keep changes small and
  repository-local.
- Markdown must follow
  <https://github.com/DavidAnson/markdownlint/blob/main/doc/Rules.md>.
- Swift code must comply with the repository SwiftLint configuration.

## Build and Test Entry Point

Agents MUST prefer XcodeBuildMCP for Apple build, test, run, Simulator,
runtime log, screenshot, and UI snapshot verification.

For MHUI package compile checks, use XcodeBuildMCP `build_sim` with:

- Workspace: `.swiftpm/xcode/package.xcworkspace`
- Scheme: `MHUI-Package`
- Simulator: an available iPhone simulator

For package tests, use XcodeBuildMCP `test_sim` with the same workspace and
scheme. Before the first MCP build or test call in a session, run XcodeBuildMCP
`session_show_defaults`. If defaults do not point at MHUI, set them for the
current session instead of relying on shell wrappers.

Agents should also run the retained repository rule checks:

```sh
bash ci_scripts/tasks/check_repository_rules.sh
```

`check_repository_rules.sh` runs SwiftLint, package boundary checks, consumer
adoption checks, and static architecture checks that are not naturally covered
by XcodeBuildMCP.

`verify.sh` is retained as a pre-commit plus repository-rules compatibility
wrapper. Direct shell build and test scripts are compatibility or fallback tools;
do not treat them as the primary agent verification surface when MCP is
available.

Compatibility scripts write disposable CI artifacts under
`.build/ci/runs/<RUN_ID>/` and shared data under `.build/ci/shared/`. Only the
newest 5 run directories are retained.
