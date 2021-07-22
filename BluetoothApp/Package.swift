// swift-tools-version:5.3

import PackageDescription
import Foundation

let SCADE_SDK = ProcessInfo.processInfo.environment["SCADE_SDK"] ?? ""

let package = Package(
    name: "BluetoothApp",
    platforms: [
        .macOS(.v10_14)
    ],
    products: [
        .library(
            name: "BluetoothApp",
            type: .static,
            targets: [
                "BluetoothApp"
            ]
        )
    ],
    dependencies: [
		.package(name: "FusionBluetooth", url: "https://github.com/pavloboiko/FusionBluetooth.git", .branch("main")),
    ],
    targets: [
        .target(
            name: "BluetoothApp",
            dependencies: [
            	.product(name: "FusionBluetooth", package: "FusionBluetooth"),
            ],
            exclude: ["main.page"],
            swiftSettings: [
                .unsafeFlags(["-F", SCADE_SDK], .when(platforms: [.macOS, .iOS])),
                .unsafeFlags(["-I", "\(SCADE_SDK)/include"], .when(platforms: [.android])),
            ]
        )
    ]
)
