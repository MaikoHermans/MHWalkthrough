Pod::Spec.new do |s|

    # 1
    s.platform 					= :ios
    s.ios.deployment_target 	= '9.0'
    s.name 						= "MHWalkthrough"
    s.summary 					= "MHwalthrough let's you create a walkthrough with a customizable PageControl"
    s.requires_arc 				= true

    # 2
    s.version 					= "0.0.1"

    # 3
    s.license 					= { :type => "MIT", :file => "LICENSE" }

    # 4
    s.author 					= { "Maiko Hermans" => "mwmhermans@outlook.com" }

    # 5
    s.homepage 					= "http://EXAMPLE/MHWalkthrough"

    # 6
    s.source 					= { :git => "https://github.com/MaikoHermans/MHWalkthrough.git", :tag => "#{s.version}"}

    # 7
    s.framework 				= "UIKit"

    # 8
    s.source_files 				= "MHWalkthrough/**/*.{swift}"

end