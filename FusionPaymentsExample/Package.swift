// swift-tools-version:5.3

import PackageDescription
import Foundation

let SCADE_SDK = ProcessInfo.processInfo.environment["SCADE_SDK"] ?? ""

let package = Package(
    name: "FusionPayments3",
    platforms: [
        .macOS(.v10_14)
    ],
    products: [
        .library(
            name: "FusionPayments3",
            type: .static,
            targets: [
                "FusionPayments3"
            ]
        )
    ],
    dependencies: [
    .package(
      name: "FusionPayments", url: "https://github.com/scade-platform/FusionPayments.git",
      .branch("feature/ios_impl")),
   
  ],
    targets: [
        .target(
            name: "FusionPayments3",
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