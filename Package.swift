// swift-tools-version:4.2
// Managed by ice

import PackageDescription

let package = Package(
    name: "Poste",
    products: [
        .library(name: "Poste", targets: ["Poste"]),
    ],
    targets: [
        .target(name: "Poste", dependencies: []),
        .testTarget(name: "PosteTests", dependencies: ["Poste"]),
    ]
)
