
Pod::Spec.new do |s|
  s.name         = "GraphKit"
  s.version      = "0.1.0"
  s.summary      = "iOS kit for creating simple types of graphs / charts."
  s.homepage     = "https://github.com/michalkonturek/GraphKit"
  s.license      = 'MIT'

  s.author       = { 
    "Michal Konturek" => "michal.konturek@gmail.com" 
  }

  s.ios.deployment_target = '7.0'

  s.social_media_url = 'https://twitter.com/michalkonturek'
  s.source       = { 
    :git => "https://github.com/michalkonturek/GraphKit.git", 
    :tag => "0.1.0" 
  }

  s.source_files = 'Source/**/*.{h,m}'
  s.requires_arc = true

  s.dependency 'FrameAccessor', '~> 1.3.2'
  s.dependency 'MKFoundationKit/NSArray', '~> 1.2.2'
end