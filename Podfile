# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'pindergarten' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for pindergarten
	pod 'Alamofire', '~> 5.4'
	pod 'AlamofireNetworkActivityIndicator'
	pod 'SnapKit', '~> 5.0.0'
	pod 'Tabman', '~> 2.11'
	pod 'AnyFormatKit', '~> 2.5.1'
	pod 'ImageSlideshow', '~> 1.9.0'
	pod "ImageSlideshow/Alamofire"
	pod 'Kingfisher'
	pod 'DropDown'
	pod 'FloatingPanel'
	pod 'NMapsMap'

  target 'pindergartenTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'pindergartenUITests' do
    # Pods for testing
  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      end
    end
end