// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FortuneWheel",
    platforms: [.macOS(.v10_15), .iOS(.v14)],
    products: [.library(name: "FortuneWheel", targets: ["FortuneWheel"])],
    dependencies: [],
    targets: [
        .target(name: "FortuneWheel", dependencies: []),
        .testTarget(name: "FortuneWheelTests", dependencies: ["FortuneWheel"]),
    ],
    swiftLanguageVersions: [.v4]
)
