// swift-tools-version: 6.2

import PackageDescription

// swiftlint:disable:next prefixed_toplevel_constant
let package = Package(
    name: "MHUI",
    platforms: [
        .iOS(.v18),
        .macOS(.v15)
    ],
    products: [
        .library(
            name: "MHUI",
            targets: ["MHUI"]
        )
    ],
    targets: [
        .target(
            name: "MHUI"
        ),
        .testTarget(
            name: "MHUITests",
            dependencies: ["MHUI"]
        )
    ]
)
