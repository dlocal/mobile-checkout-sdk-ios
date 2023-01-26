Pod::Spec.new do |spec|
    spec.name         = 'DLMobileCheckoutSDK'
    spec.version      = '0.1.1'
    spec.authors      = { 'dLocal' => 'mobile-dev@dlocal.com' }
    spec.homepage     = "https://github.com/dlocal/mobile-checkout-sdk-ios/"
    spec.summary      = 'dLocal checkout experience'
    spec.source       = { :http => "https://github.com/dlocal/mobile-checkout-sdk-ios/blob/#{spec.version.to_s}/DLMobileCheckoutSDK.zip?raw=true" }
    spec.license      = { :type => 'MIT', :file => 'LICENSE.md' }
    spec.platform     = :ios
    spec.ios.deployment_target = '13.0'
    spec.ios.vendored_frameworks = "DLMobileCheckoutSDK.xcframework"
    spec.dependency "DLDirectSDK", "0.2.6"
end
