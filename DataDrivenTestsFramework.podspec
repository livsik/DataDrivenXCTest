Pod::Spec.new do |s|
  s.name         = "DataDrivenTestsFramework"
  s.version      = "0.0.1"
  s.summary      = "DataDrivenTestsFramework"
  s.description  = <<-DESC
                Library run running tests with different input data
                   DESC
  s.homepage     = "https://git.readdle.com/spark/spark-common"
  s.license      = { :type => 'MIT', :text => 'Copyright 2018 Dmitry Protserov' }

  s.author       = { "Dmitry Protserov" => "livsik@readdle.com" }
  s.source       = { :git => "https://github.com/livsik/DataDrivenXCTest.git", :tag => 'v0.0.1' }
  s.platforms    = { :ios => "10.0", :osx => "10.11" }

  s.requires_arc = true

  s.source_files =
	"DataDrivenTestsFramework/DataDrivenTestsFramework.h",
    "DataDrivenTestsFramework/DataSources/*.swift",
    "DataDrivenTestsFramework/DataTypes/*.swift",
    "DataDrivenTestsFramework/TestCaseWithData.{h,m}",
    "DataDrivenTestsFramework/TestCaseWithDatasource.swift"


  s.framework = 'XCTest'
  
end

