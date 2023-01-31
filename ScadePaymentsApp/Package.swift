// swift-tools-version:5.3

import PackageDescription
import Foundation

let SCADE_SDK = ProcessInfo.processInfo.environment["SCADE_SDK"] ?? ""

let package = Package(
    name: "ScadePaymentsApp",
    platforms: [
        .macOS(.v10_14)
    ],
    products: [
        .library(
            name: "ScadePaymentsApp",
            type: .static,
            targets: [
                "ScadePaymentsApp"
            ]
        )
    ],
   dependencies: [
    .package(
      name: "FusionPayments", url: "https://github.com/scade-platform/FusionPayments.git",
      .branch("main")),
   
  ],
    targets: [
        .target(
            name: "ScadePaymentsApp",
            dependencies: [
            	.product(name: "FusionPayments", package: "FusionPayments"),
            ],
            exclude: ["main.page"],
            swiftSettings: [
                .unsafeFlags(["-F", SCADE_SDK], .when(platforms: [.macOS, .iOS])),
                .unsafeFlags(["-I", "\(SCADE_SDK)/include"], .when(platforms: [.android])),
            ]
        )
    ]
)