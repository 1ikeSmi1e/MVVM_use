source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
inhibit_all_warnings!

target 'MVVM_use' do
    use_frameworks!
    pod 'SVProgressHUD', '~> 2.2.5'
    pod 'ReactiveCocoa', '~> 2.5'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '8.0'
        end
    end
end
