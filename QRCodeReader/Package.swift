// swift-tools-version:5.3

import PackageDescription
import Foundation

let SCADE_SDK = ProcessInfo.processInfo.environment["SCADE_SDK"] ?? ""

let package = Package(
    name: "QRCodeReader",
    platforms: [.macOS(.v10_15), .iOS(.v13)],
    products: [
        .library(
            name: "QRCodeReader",
            type: .static,
            targets: [
                "QRCodeReader"
            ]
        )
    ],
    dependencies: [
      .package(name: "FusionCamera", url: "https://github.com/scade-platform/FusionCamera.git", .branch("main")),
    ],
    targets: [
        .target(
            name: "QRCodeReader",
            dependencies: [
              .product(name: "FusionCamera", package: "FusionCamera")
            ],
            exclude: ["main.page"],
            swiftSettings: [
                .unsafeFlags(["-F", SCADE_SDK], .when(platforms: [.macOS, .iOS])),
                .unsafeFlags(["-I", "\(SCADE_SDK)/include"], .when(platforms: [.android])),
            ]
        )
    ]
)
