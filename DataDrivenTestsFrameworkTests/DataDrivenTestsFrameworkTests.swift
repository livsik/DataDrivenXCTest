//
//  DataDrivenTestsFrameworkTests.swift
//  DataDrivenTestsFrameworkTests
//
//  Created by Dmitry Protserov on 6/15/18.
//

import XCTest
import DataDrivenTestsFramework

class DataDrivenTestsFrameworkTests: TestCaseWithDatasource {
    
    class TestDataCustom: TestData {
        let customStr1:String
        let customStr2:String
        
        init(customStr1:String, customStr2:String) {
            self.customStr1 = customStr1
            self.customStr2 = customStr2
            super.init()
            setDataName(from: "\(customStr1)__\(customStr1)")
        }
    }
    
    override class func maxParallelThreads() -> Int {
        return 4
    }
    
    override open class func loadDS() -> TestDataSource {
        let ds = TestDataSourceMutable()
        ds.add(case: TestDataCustom(customStr1: "AAA", customStr2: "BBB"))
        ds.add(case: TestDataCustom(customStr1: "CCC", customStr2: "DDD"))
        ds.add(case: TestDataCustom(customStr1: "EEE", customStr2: "FFF"))
        ds.add(case: TestDataCustom(customStr1: "GGG", customStr2: "HHH"))
        
        return ds
        
    }
    
//    override class func dataCases(forTest test:String, dataSource: TestDataSource?) -> [TestData]? {
//        if let dataSource = dataSource, test == "testExample" {
//            return dataSource.dataCases()
//        }
//        else {
//            return dataCases(forTest: test)
//        }
//    }
//
    override class func namePatching() -> TestNamePatching {
        return TestNamePatchingFunctionName
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        Thread.sleep(forTimeInterval: 5)
        print("bla  \(self) bla \(String(describing: self.currentTestData))")
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    override class func tearDown() {
        print("DOWN!!!!! SUITE")
        super.tearDown()
    }
}
