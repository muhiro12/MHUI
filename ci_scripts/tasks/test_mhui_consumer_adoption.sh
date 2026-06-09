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

work_parent="${CI_RUN_WORK_DIR:-${AI_RUN_WORK_DIR:-/tmp}}"
temporary_root=$(mktemp -d "$work_parent/mhui-consumer-adoption.XXXXXX")

cleanup() {
  rm -rf "$temporary_root"
}
trap cleanup EXIT

mkdir -p "$temporary_root/Sources/MHUIConsumerProbe"
mkdir -p \
  "$temporary_root/home" \
  "$temporary_root/tmp" \
  "$temporary_root/cache" \
  "$temporary_root/config" \
  "$temporary_root/build"

cat > "$temporary_root/Package.swift" <<EOF
// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "MHUIConsumerProbe",
    platforms: [
        .macOS(.v15)
    ],
    dependencies: [
        .package(path: "$repository_root")
    ],
    targets: [
        .executableTarget(
            name: "MHUIConsumerProbe",
            dependencies: [
                .product(
                    name: "MHUI",
                    package: "MHUI"
                )
            ]
        )
    ]
)
EOF

cat > "$temporary_root/Sources/MHUIConsumerProbe/MHUIConsumerProbe.swift" <<'EOF'
import MHUI
import SwiftUI

@main
struct MHUIConsumerProbe {
    @MainActor
    static func main() {
        let adjustedColor = Color.red.mhAdjusted(by: 50)
        let view = AnyView(
            NavigationStack {
                VStack {
                    Text("Primary")
                        .mhSingleLine()
                    Text("Supporting")
                        .mhTwoLines()
                    Rectangle()
                        .fill(adjustedColor)
                        .mhHidden(false)
                }
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        MHDismissButton()
                    }
                }
            }
        )

        print(String(reflecting: type(of: view)))
    }
}
EOF

HOME="$temporary_root/home" \
TMPDIR="$temporary_root/tmp" \
XDG_CACHE_HOME="$temporary_root/cache" \
swift build \
  --disable-sandbox \
  --cache-path "$temporary_root/cache" \
  --config-path "$temporary_root/config" \
  --scratch-path "$temporary_root/build" \
  --manifest-cache local \
  --package-path "$temporary_root"

echo "MHUI consumer adoption test passed."
