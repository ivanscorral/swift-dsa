// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-dsa",
    platforms: [
        .macOS(.v15)
    ],
    products: [
        .executable(name: "Main", targets: ["Main"]),
        .library(name: "Arrays", targets: ["Arrays"]),
        .library(name: "LinkedList", targets: ["LinkedList"]),
    ],
    dependencies: [
        // Empty for now
    ],
    targets: [
        .executableTarget(
            name: "Main",
            dependencies: [
                "Arrays",
                "LinkedList"
            ],
            path: "Sources/Main"
        ),
        .target(
            name: "Arrays",
            path: "Sources/Arrays"
        ),
        .target(
            name: "LinkedList",
            path: "Sources/LinkedList"
        ),
        .testTarget(
            name: "ArraysTests",
            dependencies: ["Arrays"],
            path: "Tests/ArraysTests"
        ),
        .testTarget(
            name: "LinkedListTests",
            dependencies: ["LinkedList"],
            path: "Tests/LinkedListTests"
        )
    ]
)
