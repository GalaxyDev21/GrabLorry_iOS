# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'GrabLorry' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
    
 pod ‘KSToastView’, ‘0.5.7’
   pod 'IQKeyboardManagerSwift'
   pod 'AlamofireSwiftyJSON'
   pod ‘SwiftValidator’, :git => ‘https://github.com/jpotts18/SwiftValidator.git’, :branch => ‘master’
   pod ‘NVActivityIndicatorView’
   pod 'ReachabilitySwift'
   pod 'GoogleMaps'
   pod 'GooglePlaces'
    pod 'DropDown'
  # Pods for GrabLorry
 
 post_install do |installer|
     installer.pods_project.build_configurations.each do |config|
         config.build_settings.delete('CODE_SIGNING_ALLOWED')
         config.build_settings.delete('CODE_SIGNING_REQUIRED')
     end
 end
end
