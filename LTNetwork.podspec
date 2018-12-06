#
#  Be sure to run `pod spec lint LTNetwork.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "LTNetwork"
  s.version      = "0.0.1"
  s.summary      = "A easy network with swift"

  s.description  = <<-DESC
  A easy network with swift
                   DESC

  s.homepage     = "https://github.com/TopSkySir/LTNetwork.git"


  s.license      = "MIT (example)"
  s.license      = { :type => "MIT", :file => "LICENSE" }


  s.author             = { "TopSkySir" => "TopSkyComeOn@163.com" }
  s.platform     = :ios, '8.0'

  s.source       = { :git => "https://github.com/TopSkySir/LTNetwork.git", :tag => "#{s.version}" }
  s.swift_version = "4.2"


  s.source_files  = "LTNetwork/Network/*"
  s.dependency "Moya", "12.0.1"

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
