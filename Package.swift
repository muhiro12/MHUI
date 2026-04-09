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
            name: "MHDesign"
        ),
        .target(
            name: "MHUI",
            dependencies: ["MHDesign"]
        ),
        .testTarget(
            name: "MHDesignTests",
            dependencies: ["MHDesign"]
        ),
        .testTarget(
            name: "MHUITests",
            dependencies: [
                "MHDesign",
                "MHUI"
            ]
        )
    ]
)
