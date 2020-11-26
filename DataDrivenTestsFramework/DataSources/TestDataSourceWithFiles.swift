//
//  TestDataSourceWithFiles.swift
//  DataDrivenTestsTests
//
//  Created by Dmitry Protserov on 6/14/18.
//  Copyright © 2018 Dmitry Protserov. All rights reserved.
//

public class TestDataWithFilePath : TestData {
    
    public let filePath: String
    
    init(filePath: String) {
        self.filePath = filePath
        super.init()
    }
}

public class TestDataSourceWithFiles: TestDataSource {

    let filesList: [TestDataWithFilePath]
    
    public init(filesList: [String]) {
        self.filesList = filesList.map({ TestDataWithFilePath(filePath: $0) })
        super.init()
    }
    
    public override func dataCases() -> [TestData] {
        return self.filesList
    }

}
