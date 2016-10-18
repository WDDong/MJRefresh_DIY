Pod::Spec.new do |s|
  s.name         = "MJRefresh_DIY"
  s.version      = "0.0.1"
  s.summary      = "Use MJRefresh,Customize a GIF rotating style."
  s.homepage     = "https://github.com/WDDong/MJRefresh_DIY"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "WDDong" => "meng0928dong@163.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/WDDong/MJRefresh_DIY.git", :tag => "#{s.version}" }

  s.source_files  = "MJRefresh_DIY/**/*.{h,m}"
  s.resource  = "MJRefresh_DIY/MJRefresh.bundle"
  s.requires_arc = true
end
