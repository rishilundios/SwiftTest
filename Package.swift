// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "SwiftTest",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "SwiftTest",
            targets: ["SwiftTest"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.4.0"),
    ],
    targets: [
        .target(
            name: "SwiftTest",
            dependencies: ["Alamofire"]),
        .testTarget(
            name: "SwiftTestTests",
            dependencies: ["SwiftTest"]),
    ]
)


