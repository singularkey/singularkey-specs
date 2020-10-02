#
# Be sure to run `pod lib lint Singularkey.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Singularkey'
  s.version          = '1.0.3'
  s.summary          = 'Singularkey is Passwordless Storng Authentication Service Provider.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'Singular Key harnesses the power hardware-grade (HSM) security and biometrics available on today\s devices to create strong, password free authentication solutions for enterprises; Our multi factor authentication service minimizes the possibility of scalable phishing and man-in-the-middle attacks attributed to 80% of cyber security breaches.'

  s.homepage         = 'https://github.com/singularkey/iosfido2demo'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'Commercial', :text => 'See https://singularkey.com/' }
  s.author           = { 'Singular Key Inc.' => 'info@singularkey.com' }
  s.source           = { :http => 'https://singularkey.s3-us-west-2.amazonaws.com/ios/frameworks/singularkey/SingularKey-v1.0.3.zip'}
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.swift_versions = '5.3'
  s.ios.deployment_target = '11.3'

  # s.source_files = 'Singularkey.framework/Headers/*.h'
  
  # s.resource_bundles = {
  #   'Singularkey' => ['Singularkey/Assets/*.png']
  # }
  s.ios.vendored_frameworks = 'SingularKey.xcframework'
  # s.public_header_files = 'SingularKey.framework/Headers/*.h'
  
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
