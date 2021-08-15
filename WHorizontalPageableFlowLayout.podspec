Pod::Spec.new do |s|
  s.name             = 'WHorizontalPageableFlowLayout'
  s.version          = '0.0.1'
  s.summary          = 'Horizontal Pageable Flow Layout'
  s.description      = "Horizontal Pageable Flow Layout For CollectionView."
  s.homepage         = 'https://github.com/winterwd/WHorizontalPageableFlowLayout.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'winter.wd' => 'winterw201501@gmail.com' }
  s.source           = { :git => 'https://github.com/winterwd/WHorizontalPageableFlowLayout.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.source_files = 'HorizontalPageableFlowLayout/WHorizontalPageableFlowLayout.{h,m}'
  s.public_header_files = 'HorizontalPageableFlowLayout/WHorizontalPageableFlowLayout.h'
end
