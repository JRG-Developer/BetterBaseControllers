Pod::Spec.new do |s|
  s.platform     = :ios
  s.ios.deployment_target = "7.0"
  s.name         = "BetterBaseControllers"
  s.version      = "1.0.1"
  s.summary      = "BetterBaseControllers are abstract, base controllers meant to be subclassed. They make creating CocoaPods easier."
  s.homepage     = "https://github.com/JRG-Developer/BetterBaseControllers"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Joshua Greene" => "jrg.developer@gmail.com" }
  s.source   	   = { :git => "https://github.com/JRG-Developer/BetterBaseControllers.git", :tag => "#{s.version}"}
  s.framework    = "UIKit"
  s.requires_arc = true
  s.source_files = "BetterBaseControllers/*.{h,m}"
end
