// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Database",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v7)
    ],
    products: [
        .library(
            name: "Database",
            targets: ["Database"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/AlexanderKadyrov/DI.git", exact: "1.0.1"),
        .package(url: "https://github.com/groue/GRDB.swift.git", exact: "7.10.0")
    ],
    targets: [
        .target(
            name: "Database",
            dependencies: [
                .product(name: "GRDB", package: "GRDB.swift"),
                .product(name: "DI", package: "DI")
            ]
        )
    ]
)
