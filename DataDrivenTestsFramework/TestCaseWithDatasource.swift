//
//  TestCaseWithDatasource.swift
//  DataDrivenTestsTests
//
//  Created by Dmitry Protserov on 6/14/18.
//  Copyright © 2018 Dmitry Protserov. All rights reserved.
//


open class TestCaseWithDatasource: TestCaseWithData {
    
    override open class func name(forTest data:TestData) -> String? {
        if let name = data.dataName, name.count > 0 {
            return name
        }
        else {
            return nil
        }
    }
    override open class func dataCases(forTest test:String) -> [TestData]? {
        return nil
    }
    
    override open class func dataCases(forTest test:String, dataSource:TestDataSource?) -> [TestData]? {
        if let dataSource = dataSource {
            return dataSource.dataCases()
        }
        else {
            return dataCases(forTest: test)
        }
    }
}
