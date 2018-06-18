//
//  TestDatasourceMutable.swift
//  DataDrivenTestsFramework
//
//  Created by Dmitry Protserov on 6/15/18.
//

import Foundation

open class TestDataSourceMutable: TestDataSource {
    var casesInner = [TestData]()
    
    convenience public init(cases:[TestData]) {
        self.init()
        casesInner = cases
    }
    
    override public func dataCases() -> [TestData] {
         return casesInner
    }
    
    public func add(case dataCase:TestData) {
        casesInner.append(dataCase)
    }
}
