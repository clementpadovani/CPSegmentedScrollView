#
# Be sure to run `pod lib lint CPSegmentedScrollView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CPSegmentedScrollView'
  s.version          = '1.0.1'
  s.summary          = 'CPSegmentedScrollView is a consul to animate a segmented control when paired with a scroll view.'

  s.homepage         = 'https://github.com/ClementPadovani/CPSegmentedScrollView'
  s.screenshots     = 'https://raw.githubusercontent.com/ClementPadovani/CPSegmentedScrollView/master/CPSegmentedScrollView.gif'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Clément Padovani' => 'clement.padovani@gmail.com' }
  s.source           = { :git => 'https://github.com/ClementPadovani/CPSegmentedScrollView.git', :tag => s.version.to_s }

  s.platform = :ios
  
  s.requires_arc = true

  s.ios.deployment_target = '8.0'

  s.source_files = 'CPSegmentedScrollView/Classes/**/*'

  s.public_header_files = 'CPSegmentedScrollView/Classes/Public/*.h'
  
  s.private_header_files = 'CPSegmentedScrollView/Classes/Private/*.h'
  
  s.frameworks = 'UIKit', 'Foundation'
end
