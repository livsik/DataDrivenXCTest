//
//  TestDataString.swift
//  DataDrivenTestsTests
//
//  Created by Dmitry Protserov on 6/14/18.
//  Copyright © 2018 Dmitry Protserov. All rights reserved.
//

open class TestDataString: TestData {

    public let dataStringInner : String
    
    public init(dataString : String) {
        self.dataStringInner = dataString
        super.init()
        setDataName(from: dataString)
    }
    
    open override var description: String {
        return super.description + " string:" + dataStringInner
    }

}
