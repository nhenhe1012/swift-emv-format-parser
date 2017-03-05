// swift-tools-version: 5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftEmvFormatParser",
    
    platforms: [.macOS(.v11), .iOS(.v12), .tvOS(.v12), .watchOS(.v4)],
    
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SwiftEmvFormatParser",
            targets: ["SwiftEmvFormatParser"]),
    ],
    
    dependencies: [],
    
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SwiftEmvFormatParser"),
        .testTarget(
            name: "SwiftEmvFormatParserTests",
            dependencies: ["SwiftEmvFormatParser"]
        ),
    ]
)
