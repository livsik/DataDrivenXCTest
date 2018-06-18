//
//  TestDataDictionary.swift
//  DataDrivenTestsTests
//
//  Created by Dmitry Protserov on 6/14/18.
//  Copyright © 2018 Dmitry Protserov. All rights reserved.
//

open class TestDataDictionary: TestData {
    
    public let dataDictionary : [String: Any]
    
    public init(dictionary : [String: Any], nameKey : String?) {
        self.dataDictionary = dictionary
        super.init()
        
        if let nameKey = nameKey {
            if let strValue = dictionary[nameKey] as? String {
                self.setDataName(from: strValue)
            }
        }
    }
    
    open override var description: String {
        return super.description + " dictionary:" + dataDictionary.description
    }

}
