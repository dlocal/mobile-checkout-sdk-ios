// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DLMobileCheckoutSDK",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "DLMobileCheckoutSDK",
            targets: ["DLMobileCheckoutSDK", "DLDirectSDK"])
    ],
    targets: [
        .binaryTarget(
            name: "DLMobileCheckoutSDK",
            url: "https://github.com/dlocal/mobile-checkout-sdk-ios/releases/download/v1.0.0/DLMobileCheckoutSDK-1.0.0.zip",
            checksum: "c7c4989ceab345f3fad90cb623fa42a89f428723067f2f3a83a8f10f395fec73"
        ),
        .binaryTarget(
            name: "DLDirectSDK",
            url: "https://github.com/dlocal/dlocal-direct-ios-sdk/releases/download/v1.0.0/DLDirectSDK-1.0.0.zip",
            checksum: "a763bc322ac1cb76c222e0b3783c166e21de5fa4437428785ef732899a4bd3be"
        )
    ]
)
