#
#  Be sure to run `pod spec lint PodsTest.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "PodsTest_AAAA"
  spec.version      = "1.0.0"
  spec.summary      = "Pods Test"
  spec.swift_version = "5.0" 

  spec.description  = "Just Pods Test For CocoaPods"

  spec.homepage     = "https://github.com/Kuo0202/CocoaPodsTest"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  spec.license      = "MIT"
  # spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  spec.author             = { "Kuo0202" => "bryant01020304@gmail.com" }
  # Or just: spec.author    = "Kuo0202"
  # spec.authors            = { "Kuo0202" => "bryant01020304@gmail.com" }
  # spec.social_media_url   = "https://twitter.com/Kuo0202"

  # spec.platform     = :ios

  spec.platform     = :ios, "12.0"

  spec.source       = { :git => "https://github.com/Kuo0202/MyPods.git", :tag => spec.version }

  # spec.source_files  = "PodsTest/**/*.{h,m,swift}"
  # spec.exclude_files = "PodsTest/**/*.plist"

  # spec.public_header_files = "Classes/**/*.h"

  # spec.resource  = "PallyConSite.plist"
  # spec.resources = "Resources/*.png"

  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"

  # spec.framework  = "SomeFramework"
  spec.frameworks = "UIKit", "AVKit", "AVFoundation"
  
  spec.vendored_frameworks = "PallyConFPSSDK.xcframework" 

  # spec.library   = "Frameworks/PallyConFPSSDK"
  # spec.libraries = "iconv", "xml2"
  spec.static_framework = true

  spec.requires_arc = true

  spec.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  spec.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  # spec.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }

   spec.dependency "CryptoSwift"

end
