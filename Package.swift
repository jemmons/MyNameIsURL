// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "MyNameIsURL",
    products: [
        .library(name: "MyNameIsURL", targets: ["MyNameIsURL"]),
    ],
    targets: [
        .target(
            name: "MyNameIsURL",
            dependencies: []),
        .testTarget(
            name: "MyNameIsURLTests",
            dependencies: ["MyNameIsURL"]),
    ]
)