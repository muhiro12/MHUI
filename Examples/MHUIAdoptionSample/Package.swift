// swift-tools-version: 6.2

import PackageDescription

// swiftlint:disable:next prefixed_toplevel_constant
let package = Package(
    name: "MHUIAdoptionSample",
    platforms: [
        .iOS(.v18),
        .macOS(.v15)
    ],
    products: [
        .library(
            name: "MHUIAdoptionSample",
            targets: ["MHUIAdoptionSample"]
        )
    ],
    dependencies: [
        .package(path: "../..")
    ],
    targets: [
        .target(
            name: "MHUIAdoptionSample",
            dependencies: [
                .product(
                    name: "MHUI",
                    package: "MHUI"
                )
            ]
        )
    ]
)
