#
# Be sure to run `pod lib lint KeyboardSwift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KeyboardSwift'
  s.version          = '0.1.2'
  s.summary          = 'Keyboard makes easy to use inputAccessoryView in UIViewController, UITextView, UITextField and UISearchBar.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Keyboard makes easy to use inputAccessoryView in UIViewController, UITextView, UITextField and UISearchBar.
                       DESC

  s.homepage         = 'https://github.com/adboco/Keyboard'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'adboco@telefonica.net' => 'https://github.com/adboco' }
  s.source           = { :git => 'https://github.com/adboco/Keyboard.git', :tag => s.version.to_s }
  s.social_media_url = 'https://instagram.com/adboco'

  s.ios.deployment_target = '8.0'
  s.swift_version = '4.1'

  s.source_files = 'Keyboard/Classes/**/*'
  
  # s.resource_bundles = {
  #   'Keyboard' => ['Keyboard/Assets/*.png']
  # }

  s.frameworks = 'UIKit'
end
