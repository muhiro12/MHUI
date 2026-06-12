# AGENTS.md

This document defines the **repository-specific agent behavior contract** for
MHUI. It contains only strict, minimal rules that agents must always follow in
this repository.

## Agent Philosophy

- Follow existing repository conventions as the source of truth.
- Do not invent architecture or workflows.
- When uncertain, prefer leaving TODO comments rather than guessing.
- Prefer **minimal, safe changes** over large refactors.

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

## Naming and Language Rules

Use English for:

- Branch names
- Code comments
- Documentation
- Identifiers

Avoid non-English text unless required for UI localization or legal content.

## Markdown Guidelines

All Markdown files must follow:

https://github.com/DavidAnson/markdownlint/blob/main/doc/Rules.md

## Swift Code Guidelines

### Follow SwiftLint rules

All Swift code must comply with the project's SwiftLint configuration.

### Avoid abbreviated variable names

#### Preferred

- `result`
- `image`
- `button`

#### Not preferred

- `res`
- `img`
- `btn`

### Use `.init(...)` when return type is explicit

#### Preferred

```swift
var user: User {
    .init(name: "Alice")
}
```

#### Not preferred

```swift
var user: User {
    User(name: "Alice")
}
```

### Multiline control-flow formatting

Do NOT use single-line bodies for control-flow statements or trailing closures.

#### Preferred

```swift
guard let currentUser else {
    return
}

if isDebugMode {
    logger.debug("Entering debug state")
}

tasks.filter { task in
    task.isCompleted
}
```

#### Not preferred

```swift
guard let currentUser else { return }
if isDebugMode { logger.debug("Entering debug state") }
tasks.filter { $0.isCompleted }
```

## Build and Test Entry Point

Agents MUST use one of these standardized entrypoints:

```sh
bash ci_scripts/tasks/run_required_builds.sh
bash ci_scripts/tasks/verify.sh
```

CI run artifacts are written under `.build/ci/runs/<RUN_ID>/`.
Each run stores `summary.md`, `commands.txt`, `meta.json`, `logs/`, `results/`, and `work/`.
Shared CI directories are under `.build/ci/shared/` (`cache/`, `DerivedData/`, `tmp/`, `home/`).
Only the newest 5 run directories are retained.
The entire `.build/ci` directory is disposable.
