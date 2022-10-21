// swift-tools-version:5.3

import PackageDescription
import Foundation

let SCADE_SDK = ProcessInfo.processInfo.environment["SCADE_SDK"] ?? ""

let package = Package(
    name: "NFCTool",
    platforms: [
        .macOS(.v10_14), .iOS(.v13)
    ],
    products: [
        .library(
            name: "NFCTool",
            type: .static,
            targets: [
                "NFCTool"
            ]
        )
    ],
    dependencies: [
      	.package(name: "FusionNFC", url: "https://github.com/scade-platform/FusionNFC.git", .branch("main")),
      	.package(name: "ScadeExtensions", url: "https://github.com/scade-platform/ScadeExtensions", .branch("main")),
    ],
    targets: [
        .target(
            name: "NFCTool",
            dependencies: [
            	"ScadeExtensions",
            	.product(name: "FusionNFC", package: "FusionNFC")
            ],
            exclude: ["main.page"],
            swiftSettings: [
                .unsafeFlags(["-F", SCADE_SDK], .when(platforms: [.macOS, .iOS])),
                .unsafeFlags(["-I", "\(SCADE_SDK)/include"], .when(platforms: [.android])),
            ]
        )
    ]
)
