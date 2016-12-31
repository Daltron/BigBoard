#
# Be sure to run `pod lib lint BigBoard.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = "BigBoard"
    s.version          = "1.1.3"
    s.summary          = "An Elegant Financial Markets Library Written in Swift"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description      = <<-DESC
BigBoard is an elegant financial markets library for iOS written in Swift. Under the hood, BigBoard makes requests to Yahoo Finance API's. Those requests are then processed and clean, friendly, and easy to use objects are returned. The goal of BigBoard is to take the learning curve out of the Yahoo Finance API's and centralize all finanical market data into one core library.
                       DESC

    s.homepage         = "https://github.com/Daltron/BigBoard"
    s.license          = 'MIT'
    s.author           = { "Dalton Hinterscher" => "daltonhint4@gmail.com" }
    s.source           = { :git => "https://github.com/Daltron/BigBoard.git", :tag => s.version.to_s }

    s.requires_arc = true

    s.source_files = 'Pod/Classes/**/*'

    s.platform = :ios
    s.ios.deployment_target = '9.0'

    s.dependency 'AlamofireObjectMapper', '~> 4.0'
    s.dependency 'AlamofireImage', '~> 3.0'
end
