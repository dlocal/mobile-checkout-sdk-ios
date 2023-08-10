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
            targets: ["DLMobileCheckoutSDK"])
    ],
    dependencies: [
        .package(url: "https://github.com/dlocal/dlocal-direct-ios-sdk.git", exact: "0.2.12")
    ],
    targets: [
        .binaryTarget(
            name: "DLMobileCheckoutSDK",
            url: "https://github.com/dlocal/mobile-checkout-sdk-ios/releases/download/v0.1.16/DLMobileCheckoutSDK-0.1.16.zip",
            checksum: "0441e4ee50a260ba63a7244da7d8e798dc9a2e6c2e8eadd12143f6782fa46714"
        )
    ]
)
