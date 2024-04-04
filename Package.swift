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
            url: "https://github.com/dlocal/mobile-checkout-sdk-ios/releases/download/v1.0.1/DLMobileCheckoutSDK-1.0.1.zip",
            checksum: "d77fb5cff9621735356d9b6903a0747f428e48dd11c13014207b9cddb944f965"
        ),
        .binaryTarget(
            name: "DLDirectSDK",
            url: "https://github.com/dlocal/dlocal-direct-ios-sdk/releases/download/v2.0.0/DLDirectSDK-2.0.0.zip",
            checksum: "c2ae1e2492d46bbb907b9c98af24abb2d2b17bb8e730cd873a6c222f8d199403"
        )
    ]
)
