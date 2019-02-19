#
#  Be sure to run `pod spec lint LTPopupController.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

 
  s.name         = "LTPopupController"
  s.version      = "0.0.1"
  s.summary      = "A Custom PopupController For Popup"


  s.description  = <<-DESC
  A Custom PopupController For Popup
                   DESC

  s.homepage     = "https://github.com/TopSkySir/LTPopupController.git"

  s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }


  s.author       = { "TopSkySir" => "TopSkyComeOn@163.com" }
  s.platform     = :ios, '9.0'

  s.source       = { :git => "https://github.com/TopSkySir/LTPopupController.git", :tag => "#{s.version}" }
  s.swift_version = "4.2"

  s.source_files  = "LTPopupController/Sources/*"

end
