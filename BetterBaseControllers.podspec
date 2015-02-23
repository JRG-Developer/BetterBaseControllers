Pod::Spec.new do |s|
  s.platform     = :ios
  s.ios.deployment_target = "8.0"
  s.name         = "BetterBaseControllers"
  s.version      = "1.0.0"
  s.summary      = "BetterBaseControllers are abstract, base controllers meant to be subclassed."
  s.homepage     = "https://github.com/JRG-Developer/BetterBaseControllers"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Joshua Greene" => "jrg.developer@gmail.com" }
  s.source   	   = { :git => "https://github.com/JRG-Developer/BetterBaseControllers.git", :tag => "#{s.version}"}
  s.framework    = "UIKit"
  s.requires_arc = true
  s.source_files = "BetterBaseControllers/*.{h,m}"
end