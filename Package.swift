// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "Poste",
    platforms: [
        .macOS(.v10_10),
        .iOS(.v8),
        .tvOS(.v9),
        .watchOS(.v2),
    ],
    products: [
        .library(name: "Poste", targets: ["Poste"]),
    ],
    targets: [
        .target(name: "Poste", dependencies: []),
        .testTarget(name: "PosteTests", dependencies: ["Poste"]),
    ],
    swiftLanguageVersions: [.v5]
)
