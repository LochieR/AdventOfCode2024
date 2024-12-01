// swift-tools-version: 5.11
import PackageDescription

let package = Package(
    name: "AoC",
    products: [
        .executable(
            name: "AoC",
            targets: ["AoC"]
        ),
        .library(
            name: "SharedAoC",
            type: .static,
            targets: ["SharedAoC"]
        ),
        .library(
            name: "y2024",
            type: .static,
            targets: ["y2024"]
        )
    ],
    targets: [
        .executableTarget(
            name: "AoC",
            dependencies: ["SharedAoC", "y2024"]
        ),
        .target(
            name: "SharedAoC"
        ),
        .target(
            name: "y2024",
            dependencies: ["SharedAoC"]
        )
    ]
)
