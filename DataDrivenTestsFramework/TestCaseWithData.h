//
//  TestCaseWithData.h
//  DataDrivenTestsTests
//
//  Created by Dmitry Protserov on 6/12/18.
//  Copyright © 2018 Dmitry Protserov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

NS_ASSUME_NONNULL_BEGIN

@class TestData;
@class TestDataSource;

typedef enum : NSUInteger {
    TestNamePatchingDefault, //now  == TestNamePatchingFunctionName
    TestNamePatchingClassName,
    TestNamePatchingFunctionName,
    TestNamePatchingNoPathcing
} TestNamePatching;

@interface TestCaseWithData : XCTestCase

@property (nullable, strong) TestData *currentTestData;

+ (nullable NSArray <__kindof TestData *> *)dataCasesForTest:(NSString *)name;

//by default will retual all cases if datasource is loaded
+ (nullable NSArray <__kindof TestData *> *)dataCasesForTest:(NSString *)name dataSource:(nullable TestDataSource *)dataSource;

+ (nullable NSString *)nameForTestData:(TestData *)data;
+ (NSInteger)basketForTestData:(TestData *)data;
+ (TestDataSource *)loadDS;
+ (NSString *)suiteName; //== to class name by default
+ (TestNamePatching)namePatching;
+ (NSInteger)maxParallelThreads;

@end

NS_ASSUME_NONNULL_END
