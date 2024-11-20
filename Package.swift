// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-cheat-sheet",
    platforms: [.macOS(.v13), .iOS(.v12), .tvOS(.v12), .watchOS(.v4)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "swift-cheat-sheet", targets: ["swift-cheat-sheet"]),
    ],
    dependencies: [.package(url: "https://github.com/Alamofire/Alamofire", .upToNextMajor(from: "5.10.1"))],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "swift-cheat-sheet", dependencies: ["Alamofire"]),
        .testTarget(name: "swift-cheat-sheetTests", dependencies: ["swift-cheat-sheet"]),
    ]
)
