Pod::Spec.new do |s|
  s.name             = 'KeyboardSwift'
  s.version          = '0.1.4'
  s.summary          = 'Keyboard makes easy to use inputAccessoryView in UIViewController, UITextView, UITextField and UISearchBar.'
  s.description      = <<-DESC
Keyboard makes easy to use inputAccessoryView in UIViewController, UITextView, UITextField and UISearchBar.
                       DESC
  s.homepage         = 'https://github.com/adboco/Keyboard'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'adboco@telefonica.net' => 'https://github.com/adboco' }
  s.source           = { :git => 'https://github.com/adboco/Keyboard.git', :tag => s.version.to_s }
  s.social_media_url = 'https://instagram.com/adboco'
  s.ios.deployment_target = '12.0'
  s.swift_version = '5.0'
  s.source_files = 'Keyboard/Classes/**/*'
  s.frameworks = 'UIKit'
end
