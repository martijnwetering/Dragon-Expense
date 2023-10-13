// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DragonExpenseData",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        .library(
            name: "DragonExpenseData",
            type: .dynamic,
            targets: ["DragonExpenseData"]
        ),
    ],
    targets: [
        .target(
            name: "DragonExpenseData",
            path: "."
        )
    ]
)
