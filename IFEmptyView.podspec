#
#  Be sure to run `pod spec lint IFEmptyView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "IFEmptyView"
  spec.version      = "0.0.1.5"
  spec.summary      = "空视图"

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  spec.description  = <<-DESC
  空视图简化版，仍需完善
                   DESC

  spec.homepage     = "https://ifgitlab.gwm.cn/iov-ios/IFUIKit"
  spec.license      = { :type => 'Copyright', :text => 'Copyright 2021 - 2030 mrglzh All rights reserved.\n' }
  spec.author       = { "张高磊" => "mrglzh@yeah.net" }

  spec.source       = { :git => "http://10.255.35.174/iov-ios/IFUIKit.git", :tag => spec.version.to_s }


  spec.requires_arc = true
  spec.ios.deployment_target = '9.0'

  #s.resources = ['Sources/Device/*.json']
  spec.resources = 'Sources/IFEmptyView/*.bundle'
  spec.source_files = 'Sources/IFEmptyView/*.{h,m}'
  spec.public_header_files = 'Sources/IFEmptyView/*.h'

  spec.dependency 'Masonry'
  spec.dependency 'YYText'
  spec.dependency 'IFCommonKit'

end
