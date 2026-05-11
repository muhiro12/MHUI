// swift-tools-version: 6.2

import PackageDescription

// swiftlint:disable:next prefixed_toplevel_constant
let package = Package(
    name: "MHUI",
    platforms: [
        .iOS(.v18),
        .macOS(.v15),
        .watchOS(.v11)
    ],
    products: [
        .library(
            name: "MHDesign",
            targets: ["MHDesign"]
        ),
        .library(
            name: "MHUI",
            targets: ["MHUI"]
        )
    ],
    targets: [
        .target(
            name: "MHDesign",
            path: "MHDesign",
            exclude: ["Tests"],
            sources: ["Sources"]
        ),
        .target(
            name: "MHUI",
            dependencies: ["MHDesign"],
            path: "MHUI",
            exclude: ["Tests"],
            sources: ["Sources"],
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "MHDesignTests",
            dependencies: ["MHDesign"],
            path: "MHDesign/Tests"
        ),
        .testTarget(
            name: "MHUITests",
            dependencies: ["MHUI"],
            path: "MHUI/Tests"
        )
    ]
)
