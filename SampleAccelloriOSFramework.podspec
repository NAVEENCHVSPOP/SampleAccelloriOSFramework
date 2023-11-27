Pod::Spec.new do |spec|
  spec.name         = "SampleAccelloriOSFramework"
  spec.version      = "1.0.0"
  spec.summary      = "Initial version of SampleAccelloriOSFramework."
  spec.description  = "At present i have no idea what to write as a description"
  spec.homepage     = "https://dev.azure.com/popcornappsdevops/RacetracPOC"
  spec.license      = "MIT"
  spec.author       = { "Naveen Chintalapudi" => "naveen.chintalapudi@accellor.com" }
  spec.platform     = :ios, "15.2"
  spec.source       = { :git => "https://popcornappsdevops@dev.azure.com/popcornappsdevops/RacetracPOC/_git/RacetracPOC", :tag => "1.0.0" }
  spec.source_files  = "RacetracPOC/iOS/SampleAccelloriOSFramework/**/*.{swift,storyboard}"
  spec.swift_versions = "5.0"
end
