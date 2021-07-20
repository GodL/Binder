Pod::Spec.new do |s|
  s.name             = "PropertyWrapperBinder"
  s.version          = "1.0.2"
  s.license          = { :type => "MIT" }
  s.homepage         = "https://github.com/GodL/Binder"
  s.author           = { "GodL" => "547188371@qq.com" }
  s.summary          = "`Binder` is a data binding library driven by PropertyWrapper."

  s.source           = { :git => "https://github.com/GodL/Binder.git", :tag => "#{s.version}" }
  s.source_files     = "Sources/Binder/*.swift"
  
  s.swift_version    = "5.0"

  s.ios.deployment_target = "9.0"
end
