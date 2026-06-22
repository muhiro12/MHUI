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

mkdir -p \
  "$temporary_root/Sources/MHDesignConsumerProbe" \
  "$temporary_root/Sources/MHUIConsumerProbe"
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
        ),
        .executableTarget(
            name: "MHDesignConsumerProbe",
            dependencies: [
                .product(
                    name: "MHDesign",
                    package: "MHUI"
                )
            ]
        )
    ]
)
EOF

cat > "$temporary_root/Sources/MHDesignConsumerProbe/MHDesignConsumerProbe.swift" <<'EOF'
import MHDesign
import SwiftUI

@main
struct MHDesignConsumerProbe {
    @MainActor
    static func main() {
        let metrics = MHDesignMetrics(
            spacing: .init(
                inline: 6,
                control: 12,
                content: 18,
                section: 24,
                screen: 36
            ),
            cornerRadius: .init(
                control: 7,
                surface: 14
            ),
            layout: .init(
                readableContentWidth: 640,
                compactWidthThreshold: 560,
                screen: .init(
                    contentInsetHorizontal: 32,
                    contentInsetVertical: 48,
                    contentSpacing: 28,
                    compactContentInsetHorizontal: 16,
                    compactContentInsetVertical: 24,
                    compactContentSpacing: 18
                ),
                surface: .init(
                    insetHorizontal: 20,
                    insetVertical: 18,
                    compactInsetHorizontal: 14,
                    compactInsetVertical: 12
                ),
                control: .init(
                    minimumTouchTarget: 44
                )
            )
        )
        let view = AnyView(
            Text("Metrics")
                .padding(metrics.spacing[.control])
                .mhDesignMetrics(metrics)
        )

        print(String(reflecting: type(of: view)))
        print(metrics.layout.mode(for: 320))
    }
}
EOF

cat > "$temporary_root/Sources/MHUIConsumerProbe/MHUIConsumerProbe.swift" <<'EOF'
import MHUI
import SwiftUI

@main
struct MHUIConsumerProbe {
    @MainActor
    static func main() {
        let view = AnyView(
            NavigationStack {
                List {
                    Section {
                        LabeledContent("Mode", value: "Focused")
                            .labeledContentStyle(.mhKeyValue)

                        MHActionGroup {
                            Button("Continue") {}
                                .buttonStyle(.mhPrimary)

                            Button("Review") {}
                                .buttonStyle(.mhSecondary)
                        }
                    }
                }
                .mhListChrome(
                    "Workspace",
                    subtitle: "Shared package chrome."
                )
            }
        )
        .mhTheme(.standard())
        let fixedAccentView = AnyView(
            Text("Fixed accent")
                .mhTextStyle(.body, colorRole: .accent)
                .mhTheme(.standard(
                    metrics: .standard,
                    accent: .fixed(
                        lightHex: 0x2473E6,
                        darkHex: 0x73ADFF
                    )
                ))
        )
        let unlabeledChrome = AnyView(
            VStack {
                Color.clear
                    .mhScreen()

                List {
                    Text("Row")
                }
                .mhListChrome()

                Form {
                    Text("Field")
                }
                .mhFormChrome()
            }
        )

        print(String(reflecting: type(of: view)))
        print(String(reflecting: type(of: fixedAccentView)))
        print(String(reflecting: type(of: unlabeledChrome)))
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
  -Xswiftc -D \
  -Xswiftc MHUI_DISABLE_PACKAGE_PREVIEWS \
  --manifest-cache local \
  --package-path "$temporary_root"

echo "MHUI consumer adoption test passed."
