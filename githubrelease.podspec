
Pod::Spec.new do |s|
  s.name             = "githubrelease"
  s.version          = "1.0.0"
  s.summary          = "The open source fonts for githubrelease"
  s.homepage         = "https://github.com/"
  s.license          = 'Code is MIT, then custom font licenses.'
  s.author           = { "Orta" => "mykola.omelyanov@gmail.com" }
  s.source           = { :git => "https://github.com/MykolaOm/MultiPeer.git", :tag => s.version }
#  s.social_media_url = 'https://twitter.com/artsy'

  s.platform     = :ios, '11.0'
  s.requires_arc = true

  #s.source_files = 'Pod/Classes'
  #s.resources = 'Pod/Assets/*'

  s.frameworks = 'UIKit'
  s.module_name = 'githubrelease'
end
