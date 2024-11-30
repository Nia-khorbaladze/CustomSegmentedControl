// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CustomSegmentedControl",
    platforms: [
        .iOS(.v13) 
    ],
    products: [
        .library(
            name: "CustomSegmentedControl",
            targets: ["CustomSegmentedControl"]
        ),
    ],
    targets: [
        .target(
            name: "CustomSegmentedControl",
            dependencies: [],
            path: "Sources/CustomSegmentedControl"
        ),
    ]
)



