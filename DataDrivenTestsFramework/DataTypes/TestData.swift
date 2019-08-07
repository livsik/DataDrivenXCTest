//
//  TestData.swift
//  DataDrivenTestsTests
//
//  Created by Dmitry Protserov on 6/14/18.
//  Copyright © 2018 Dmitry Protserov. All rights reserved.
//

import Foundation

open class TestData : NSObject {
    
    public var dataName: String?
    public var basketNumber: Int = 0
    
    public func setDataName(from string:String) {
        dataName = string.replacingOccurrences(of: " ", with: "_")
    }
    
    open override var description: String {
        return super.description + " testName:" + (dataName ?? "")
    }
}
