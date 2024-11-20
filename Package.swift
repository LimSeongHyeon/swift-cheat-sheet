// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-cheat-sheet",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "swift-cheat-sheet",
            targets: ["swift-cheat-sheet"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "swift-cheat-sheet"),
        .testTarget(
            name: "swift-cheat-sheetTests",
            dependencies: ["swift-cheat-sheet"]),
    ]
)