// swift-tools-version:5.3

import PackageDescription
import Foundation

let SCADE_SDK = ProcessInfo.processInfo.environment["SCADE_SDK"] ?? ""

let package = Package(
    name: "AudioPlayer",
    platforms: [
        .macOS(.v10_14)
    ],
    products: [
        .library(
            name: "AudioPlayer",
            type: .static,
            targets: [
                "AudioPlayer"
            ]
        )
    ],
    dependencies: [
      .package(name: "FusionMedia", url: "https://github.com/scade-platform/FusionMedia.git", .branch("main")),
      .package(name: "ScadeExtensions", url: "https://github.com/scade-platform/ScadeExtensions.git", .branch("main"))
    ],
    targets: [
        .target(
            name: "AudioPlayer",
            dependencies: [
            	.product(name: "FusionMedia", package: "FusionMedia"),
            	.product(name: "ScadeExtensions", package: "ScadeExtensions")
            ],
            exclude: ["main.page"],
            swiftSettings: [
                .unsafeFlags(["-F", SCADE_SDK], .when(platforms: [.macOS, .iOS])),
                .unsafeFlags(["-I", "\(SCADE_SDK)/include"], .when(platforms: [.android])),
            ]
        )
    ]
)
