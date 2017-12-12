# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'WSApp' do
  use_frameworks!

  pod 'KeychainSwift'
  pod 'IQKeyboardManagerSwift'
  pod 'EasyRest'
  pod 'RealmSwift', '~> 3.0'
  pod 'AFNetworking'
 


end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        compatibility_pods = ['Genome', 'SweetAlert']
        if compatibility_pods.include? target.name
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '3.2'
            end
        end
    end
end
