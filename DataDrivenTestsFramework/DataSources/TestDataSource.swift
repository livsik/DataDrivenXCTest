//
//  TestDataSource.swift
//  DataDrivenTestsTests
//
//  Created by Dmitry Protserov on 6/14/18.
//  Copyright © 2018 Dmitry Protserov. All rights reserved.
//
import Foundation

open class TestDataSource : NSObject {

    public func dataCases() -> [TestData] {
        return []
    }
    
    public func randomizeParallelBaskets(maxBaskets: Int) {
        guard maxBaskets > 1 else {
            return
        }
        let hasCustomBackets = dataCases().first { $0.basketNumber != 0 }
        guard hasCustomBackets == nil else {
            return
        }
        for (index, oneCase) in dataCases().enumerated() {
            oneCase.basketNumber = index % maxBaskets + 1
        }
    }
}
