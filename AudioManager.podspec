Pod::Spec.new do |spec|

  spec.name         = "AudioManager"
  spec.version      = "0.0.2"
  spec.summary      = "Simple wrapper for AVAudioSession."
  spec.homepage     = "https://github.com/robinlieb/AudioManager"
  spec.license      = "MIT"
  spec.author    = "Robin Lieb"
  spec.source       = { :git => "https://github.com/robinlieb/AudioManager.git", :tag => "#{spec.version}" }
  spec.documentation_url = "https://github.com/robinlieb/AudioManager"

  spec.platform     = :ios, "10.0"
  spec.swift_versions = ['5.0', '5.1']

  spec.source_files  = "Sources/AudioManager/*.swift"

end
