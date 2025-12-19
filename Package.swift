// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "OTPKit",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "OTPKit",
            targets: ["OTPKit"]
        )
    ],
    targets: [
        .target(
            name: "OTPKit",
            dependencies: [],
            path: "Sources/OTPKit"
        )
    ]
)
