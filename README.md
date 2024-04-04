# DLMobileCheckoutSDK for iOS

Allows integration of dLocal's checkout process

## Requirements
- Xcode 13+
- iOS 13+

## Installation

### Cocoapods

Add the following to your `Podfile`:

```ruby
pod 'DLMobileCheckoutSDK', '~> 1.0.1'
```

### Swift Package Manager

In Xcode, go to `File > Add Packages...` and paste this repo URL (https://github.com/dlocal/mobile-checkout-sdk-ios) in the search box.

### Manual

1. Download the latest release from [here](https://github.com/dlocal/mobile-checkout-sdk-ios/releases).
2. Drag and drop the downloaded `DLMobileCheckoutSDK.xcframework` into the project.
3. Go to your project configuration **General** tab and ensure that `Embed & Sign` is selected for `DLMobileCheckoutSDK`.
4. `DLMobileCheckoutSDK` has a dependency to `DLDirectSDK` so you will have to manually download it as well. Look at the [podspec](https://github.com/dlocal/mobile-checkout-sdk-ios/blob/master/DLMobileCheckoutSDK.podspec) to understand what version of `DLDirectSDK` matches the version of `DLMobileCheckoutSDK` you are installing. Once you find the version, download it from [here](https://github.com/dlocal/dlocal-direct-ios-sdk/releases).
5. Drag and drop the downloaded `DLDirectSDK.xcframework` into the project.
6. Go to your project configuration General tab again and ensure that `Embed & Sign` is selected for `DLDirectSDK`.

# Getting started

## Initialize the SDK

```swift
import DLMobileCheckoutSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    {...}

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        DLMobileCheckout.initialize(apiKey: "API KEY", allowInstallments: true)
                                   
        return true
    }
}
```

Replace `apiKey` with your key and `countryCode` with the two letter country code, for example "UY" for "Uruguay", or "US" for "United States".

You can find full list of country codes [here](https://documentation.dlocal.com/reference/country-reference).

## Allow installments

Use `allowInstallments` parameter to specify whether user will be able to select installments as part of the checkout process.

```swift
DLMobileCheckout.initialize(apiKey: "API KEY",
                            allowInstallments: true) // defaults to `false` if not specified
```

## Testing the integration

Use `testMode` parameter to specify whether you are going to be doing testing with fake data or if you are going to be performing real transactions.

```swift
DLMobileCheckout.initialize(apiKey: "API KEY",
                            testMode: true) // defaults to `false` if not specified
```

# Checkout

```swift
let viewController = DLMobileCheckout.createFormViewController(
    amount: 500 /* amount to charge */,
    currencyCode: USD /* currency of the amount */,
    countryCode: "UY" /* two letter country code */,
    mainButtonTitle: "Add Card" /* text to show in the main button */,
    onSuccess: { result in
        print("Card token successfully generated: \(result.cardToken) to charge \(result.totalAmount)")
        if result.installmentsId != nil {
            print("Payment will be processed in \(result.installments) installments, each installments has a value of \(installmentsAmount)")
        } else {
            print("Installments not allowed, payment will be processed in a single transaction for total amount")
        }
    },
    onError: { 
        error in print("Checkout process failed: \(error)") 
    }
)

if let viewController {
    present(viewController, animated: true)
} else {
    // something went wrong initializing the view controller
    // check console for details
}
```

## Theme

You can customize the look and feel of the checkout interface as follows:

```swift
class MyCheckoutTheme: DLFormTheme {
    override var accentColor: UIColor { .blue }
    override var textFieldBorderStyle: DLBorderStyle { .bottomLine }
    
    // add other theme overrides here
}
```

All customization options:

```swift
open var textFieldBorderStyle: DLBorderStyle { .bottomLine }

// MARK: - Colors
open var primaryTextColor: UIColor { .label }
open var secondaryTextColor: UIColor { .secondaryLabel }
open var dragIndicatorColor: UIColor { .systemGray }
open var textFieldBorderColor: UIColor { .secondaryLabel }
open var focusTextFieldBorderColor: UIColor { .secondaryLabel }
open var errorColor: UIColor { .systemRed }
open var buttonTitleColor: UIColor { .white }
open var accentColor: UIColor { .systemBlue }
open var backgroundColor: UIColor { .systemBackground }
open var progressColor: UIColor { UIColor(red: 0.086, green: 0.110, blue: 0.141, alpha: 0.3) }

// MARK: - Fonts
open var title: UIFont { UIFont.preferredFont(forTextStyle: .title3) }
open var body: UIFont { UIFont.preferredFont(forTextStyle: .body) }
open var body2: UIFont { UIFont.preferredFont(for: .body, weight: .bold) }
open var footnote: UIFont { UIFont.preferredFont(forTextStyle: .footnote) }
open var caption1: UIFont { UIFont.preferredFont(forTextStyle: .caption1) }
open var caption2: UIFont { UIFont.preferredFont(forTextStyle: .caption2) }

open var mainButtonStyle: DLButtonStyle { .edgeToEdge }
```

### Note about dark mode

If your app supports dark mode, make sure that you use dynamic colors to have the checkout UI adapt in both light and dark interface styles. Here is a useful code snippet that you can use:

```swift
public extension UIColor {
    static func dynamicColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else { return lightMode }

        return UIColor { (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? lightMode : darkMode
        }
    }
}

// Example scenario: we want primary text color to be red in light mode, and blue in dark mode

open var primaryTextColor: UIColor { 
    UIColor.dynamicColor(lightMode: UIColor.red, darkMode: UIColor.blue) 
}
```

You can read more about dark mode support in SwiftLee's [Dark Mode: Adding support to your app in Swift](https://www.avanderlee.com/swift/dark-mode-support-ios/).

# Localization

The checkout experience is localized in *English*, *Spanish* and *Portuguese*. 

Depending on what languages your app supports is how the Checkout UI will be localized:

| Your App Supported Localizations | System Localization | Your App Localization | Checkout Localization | Comments |
| --- | --- | --- | --- | --- |
| EN, ES | EN | EN | EN | Normal scenario, all UI is in English to match system preference. |
| EN, ES | ES | ES | ES | Normal scenario, all UI is in Spanish to match system preference. |
| EN, ES | IT | EN | EN | In this case user's preferred language is Italian, but neither your app nor Checkout support it so language is defaulted to English. |
| IT | IT | IT | EN | In this case user's preferred language is Italian, your app supports it so your app UI is shown in that language. Checkout UI does not support Italian so it defaults back to English. |
| EN, ES | PT | EN | EN | While checkout supports Portuguese and user's preferred language is Portuguese, we continue showing in English to match the experience in your app. |

In the last scenario, if you'd like Checkout UI to be shown in Portuguese to match system's language, set `Localized resources can be mixed = YES` in your `Info.plist`.

# Objective-C Support

In order to call our SDK from Objective-C code you'll need to include a compatibility Swift file which is provided separately. Please reach out to us if you're facing this scenario.

# SwiftUI Support

In order to call our SDK from a SwiftUI View, you'll need to wrap our Checkout form with a SwiftUI wrapper, calling 
```swift
DLMobileCheckout.createFormView
```
instead of 
```swift
DLMobileCheckout.createFormViewController
```
EXAMPLE: 
```swift
.sheet(isPresented: $showingCheckout) {
    DLMobileCheckout.createFormView(
        amount: 5000, 
        currencyCode: "ARS",
        countryCode: "UY",
        mainButtonTitle: "PAY", 
        onSuccess: { result in print(result.cardToken) }, 
        onError: { error in print(error) })
}
```
(See full example in DLMobileCheckoutSDKExampleSwiftUI project)
# Landscape support

The checkout interface supports Portrait orientation only.

# API Reference

[View API Reference for DLMobileCheckoutSDK v1.0.1](https://dlocal.github.io/mobile-checkout-sdk-ios/1.0.1/documentation/dlmobilecheckoutsdk).

You can view reference for previous versions [here](https://dlocal.github.io/mobile-checkout-sdk-ios/).

# Report Issues
If you have a problem or find an issue with the SDK please contact us at [mobile-dev@dlocal.com](mailto:mobile-dev@dlocal.com)

# License

```text
MIT License

Copyright (c) 2022 DLOCAL

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
