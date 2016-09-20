Pod::Spec.new do |s|
  s.name						= "Marshal"
  s.version						= "0.9.6"
  s.summary						= "Marshal is a simple, lightweight framework for safely extracting values from [String: AnyObject]"
  s.description					= <<-DESC
                   					In Swift, we all deal with JSON, plists, and various forms of [String: AnyObject]. Marshal believes you don't need a Ph.D. in Monads or large, complex frameworks to deal with these in an expressive and type safe way. Marshal is a simple, lightweight framework for safely extracting values from [String: AnyObject].
                   				  DESC
  s.homepage					= "https://github.com/utahiosmac/Marshal"
  s.license						= "MIT"
  s.author						= "Utah iOS & Mac"
  s.osx.deployment_target		= "10.9"
  s.ios.deployment_target		= "8.0"
  s.tvos.deployment_target		= "9.0"
  s.watchos.deployment_target	= "2.0"
  s.source						= { :git => "https://github.com/utahiosmac/Marshal.git", 
									:tag => "v" + s.version.to_s }
  s.source_files				= "Marshal/**/*.swift", "Sources/**/*.swift"
  s.requires_arc				= true
  s.module_name					= "Marshal"
end
