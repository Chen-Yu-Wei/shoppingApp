# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'shoppingApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

    pod 'RxSwift', '5.1.1'
pod 'RxCocoa', '5.1.1'
pod 'SnapKit', '~> 4.0.0'
#綠界支付
pod 'ECPayPaymentGatewayKit', '1.4.0'
pod 'PromiseKit' , '6.8.5'
pod 'Alamofire', '5.2.2'
pod 'IQKeyboardManagerSwift'
pod 'KeychainSwift', '16.0.1'
pod 'SwiftyXMLParser', :git => 'https://github.com/yahoojapan/SwiftyXMLParser.git'
pod 'CryptoSwift', '1.4.1'

  target 'shoppingAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'shoppingAppUITests' do
    # Pods for testing
  end

end

static_frameworks = ['ECPayPaymentGatewayKit']
pre_install do |installer|
  installer.pod_targets.each do |pod|
    if static_frameworks.include?(pod.name)
      puts "#{pod.name} installed as static framework!"
      def pod.static_framework?;
        true
      end
    end
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
	config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
       end
    end
end
