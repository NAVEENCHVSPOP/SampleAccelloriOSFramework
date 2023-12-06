Pod::Spec.new do |spec|
  spec.name         = "SampleAccelloriOSFramework"
  spec.version      = "1.0.4"
  spec.summary      = "Initial version of SampleAccelloriOSFramework."
  spec.description  = "At present i have no idea what to write as a description"
  spec.homepage     = "https://github.com/NAVEENCHVSPOP/SampleAccelloriOSFramework.git"
  spec.license      = "MIT"
  spec.author       = { "Naveen Chintalapudi" => "naveen.chintalapudi@popcornapps.com" }
  spec.platform     = :ios, "15.2"
  spec.source       = { :git => "https://github.com/NAVEENCHVSPOP/SampleAccelloriOSFramework.git", :tag => "1.0.4" }
  spec.source_files  = "SampleAccelloriOSFramework/**/*.{swift,storyboard}"
  spec.swift_versions = "5.0"
end
