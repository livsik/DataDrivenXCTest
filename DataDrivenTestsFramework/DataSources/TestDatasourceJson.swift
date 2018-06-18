//
//  TestDatasourceJson.swift
//  DataDrivenTestsTests
//
//  Created by Dmitry Protserov on 6/14/18.
//  Copyright © 2018 Dmitry Protserov. All rights reserved.
//

open class TestDatasourceJson: TestDataSource {

   let loadBlock: ((Any) -> ([TestData]?))
    
    var allCasesInternal:[TestData]?
    
    public init(path:String, loadBlock:@escaping (Any)->[TestData]?) {
        self.loadBlock = loadBlock
        super.init()
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            assert(false)
            return
        }
        loadFromData(data: data)
    }
    
    func loadFromData(data:Data) {
    
        if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0)) {
            self.allCasesInternal = self.loadBlock(jsonObject)
        }
    }
    
    override public func dataCases() -> [TestData] {
        return allCasesInternal ?? []
    }

}
