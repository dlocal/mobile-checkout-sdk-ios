Pod::Spec.new do |spec|
    spec.name         = 'DLMobileCheckoutSDK'
    spec.version      = '0.0.2'
    spec.authors      = { 'dLocal' => 'mobile-dev@dlocal.com' }
    spec.homepage     = "https://bitbucket.org/dlocal-public/mobile-checkout-sdk-ios/"
    spec.summary      = 'dLocal checkout experience'
    spec.source       = { :http => "https://bitbucket.org/dlocal-public/mobile-checkout-sdk-ios/downloads/DLMobileCheckoutSDK-#{spec.version.to_s}.zip" }
    spec.license      = { :type => 'MIT', :file => 'LICENSE.md' }
    spec.platform     = :ios
    spec.ios.deployment_target = '13.0'
    spec.ios.vendored_frameworks = "DLMobileCheckoutSDK.xcframework"
    spec.dependency "DLDirectSDK"
end
