// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftCheatSheet",
    platforms: [.macOS(.v13), .iOS(.v12), .tvOS(.v12), .watchOS(.v4)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SwiftCheatSheet", targets: ["SwiftCheatSheet"]),
    ],
    dependencies: [.package(url: "https://github.com/Alamofire/Alamofire", .upToNextMajor(from: "5.10.1"))],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "SwiftCheatSheet", dependencies: ["Alamofire"]),
        .testTarget(name: "SwiftCheatSheetTests", dependencies: ["SwiftCheatSheet"]),
    ]
)
