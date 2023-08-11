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
            url: "https://github.com/dlocal/mobile-checkout-sdk-ios/releases/download/v0.1.17/DLMobileCheckoutSDK-0.1.17.zip",
            checksum: "bd3f6839b5039f5dfb27cfe015fc1d8b7a016df681e16ab6cc2b33cbb8c796e4"
        ),
        .binaryTarget(
            name: "DLDirectSDK",
            url: "https://github.com/dlocal/dlocal-direct-ios-sdk/releases/download/v0.2.43/DLDirectSDK-0.2.43.zip",
            checksum: "eb202ffa4448cd43ca271867f397699eaaf5f1bd49a6a6f8ffc6032d662c4c4d"
        )
    ]
)
