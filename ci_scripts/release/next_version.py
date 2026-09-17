#!/usr/bin/env python3
"""Select a stable release tag, retaining legacy major.minor tags as history."""

import re
import subprocess


def parse_version(tag):
    if not re.fullmatch(r"(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)(\.(0|[1-9][0-9]*))?", tag):
        return None
    parts = tuple(map(int, tag.split(".")))
    return parts if len(parts) == 3 else (*parts, 0)


def next_version(tags, target_tags):
    versions = [(parse_version(tag), tag) for tag in tags if parse_version(tag) is not None]
    existing = [item for item in versions if item[1] in target_tags]
    if existing:
        # Prefer the three-component spelling when both refer to the same version.
        return max(existing, key=lambda item: (item[0], len(item[1].split("."))))[1]
    if not versions:
        return "1.0.0"
    major, minor, _ = max(version for version, _ in versions)
    return f"{major}.{minor + 1}.0"


if __name__ == "__main__":
    tags = subprocess.check_output(["git", "tag", "--list"], text=True).splitlines()
    target_tags = subprocess.check_output(
        ["git", "tag", "--points-at", "HEAD"], text=True
    ).splitlines()
    print(next_version(tags, target_tags))
