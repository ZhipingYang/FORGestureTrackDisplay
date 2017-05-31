Pod::Spec.new do |s|
s.name         = 'FORGestureTrackDisplay'
s.summary      = 'Tracking the gustures and displaying in window'
s.description      = <<-DESC
FORGestureTrackDisplay is debug tool to displaying and tracking all kinds of gustures when user touch the screen.
                       DESC
s.version      = '0.0.1'
s.homepage     = "https://github.com/ZhipingYang/FORGestureTrackDisplay"
s.license      = 'MIT'
s.authors      = { 'ZhipingYang' => 'XcodeYang@gmail.com' }
s.platform     = :ios, '8.0'
s.ios.deployment_target = '8.0'
s.source       = { :git => 'https://github.com/ZhipingYang/FORGestureTrackDisplay.git', :tag => s.version.to_s }

s.requires_arc = true

s.source_files = 'FORGestureTrackDisplay/**/*'

s.frameworks = 'UIKit'

end
