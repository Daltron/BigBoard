#
# Be sure to run `pod lib lint BigBoard.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = "BigBoard"
    s.version          = "1.0.0"
    s.summary          = "A Powerful Finance Library Written in Swift"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
                       DESC

    s.homepage         = "https://github.com/Daltron/BigBoard"
    s.license          = 'MIT'
    s.author           = { "Dalton" => "daltonhint4@gmail.com" }
    s.source           = { :git => "https://github.com/Daltron/BigBoard.git", :tag => s.version.to_s }

    s.requires_arc = true

    s.source_files = 'Pod/Classes/**/*'
    s.resource_bundles = {
        'BigBoard' => ['Pod/Assets/*.png']
    }

    s.ios.deployment_target = '8.3'
    s.osx.deployment_target = '10.9'

    s.dependency 'AlamofireObjectMapper', '~> 3.0'
    s.dependency 'Timepiece'
    s.dependency 'AlamofireImage', '~> 2.0'
end
