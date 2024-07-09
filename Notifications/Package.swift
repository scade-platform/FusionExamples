// swift-tools-version:5.3

import PackageDescription
import Foundation

let SCADE_SDK = ProcessInfo.processInfo.environment["SCADE_SDK"] ?? ""

let package = Package(
    name: "Notifications",
    platforms: [
        .macOS(.v10_14)
    ],
    products: [
        .library(
            name: "Notifications",
            type: .static,
            targets: [
                "Notifications"
            ]
        )
    ],
    dependencies: [
      	.package(name: "FusionNotifications", url: "https://github.com/scade-platform/FusionNotifications.git", .branch("pavlo"))      
    ],
    targets: [
        .target(
            name: "Notifications",
            dependencies: [
            	.product(name: "FusionNotifications", package: "FusionNotifications")            	
            ],
            exclude: ["main.page"],
            swiftSettings: [
                .unsafeFlags(["-F", SCADE_SDK], .when(platforms: [.macOS, .iOS])),
                .unsafeFlags(["-I", "\(SCADE_SDK)/include"], .when(platforms: [.android])),
            ]
        )
    ]
)