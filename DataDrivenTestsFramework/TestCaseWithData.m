//
//  TestCaseWithData.m
//  DataDrivenTestsTests
//
//  Created by Dmitry Protserov on 6/12/18.
//  Copyright © 2018 Dmitry Protserov. All rights reserved.
//

#import "TestCaseWithData.h"
#include <objc/runtime.h>

@interface TestCaseWithData ()

@end

@implementation TestCaseWithData

+ (NSString *)suiteName {
    return NSStringFromClass(self);
}

+ (XCTestSuite *)defaultTestSuite {
    NSInteger threads = [self maxParallelThreads];
    if (threads > 1 && [self basketNumber] == 0) {
        return nil;
    }
    TestNamePatching pathcingStyle = [self namePatching];
    if (pathcingStyle == TestNamePatchingDefault) {
        pathcingStyle = TestNamePatchingFunctionName;
    }
    
    TestDataSource *ds = [self loadDS];
    
    XCTestSuite *suite = [[XCTestSuite alloc] initWithName:[self suiteName]];
    
    NSArray <NSInvocation *> *allTestInvoations = [self testInvocations];
    NSMutableArray <TestCaseWithData *> *allTestCases = [NSMutableArray new];
    
    for (NSInvocation *invocation in allTestInvoations) {
        NSArray<TestCaseWithData *> *testCases = [self casesForInvocation:invocation dataSource:ds namePathcing:pathcingStyle burrentBasket:[self basketNumber]];
        
        for (TestCaseWithData *test in testCases) {
            [allTestCases addObject:test];
        }
    }
    
    
    
    [allTestCases sortUsingComparator:^NSComparisonResult(TestCaseWithData *obj1, TestCaseWithData *obj2) {
        return [NSStringFromClass(obj1.class) compare:NSStringFromClass(obj2.class)];
    }];
    
    for (TestCaseWithData *test in allTestCases) {
        [suite addTest:test];
    }
    
    return suite;
}

+ (TestCaseWithData *)caseWithData:(TestData *)oneCase invocation:(NSInvocation *)invocation namePathcing:(TestNamePatching)pStyle {
    Class mySubclass;
    NSString *caseName =  oneCase ? [self nameForTestData:oneCase] : nil;
    if (pStyle == TestNamePatchingClassName && caseName != nil) {
        NSString *name = [NSString stringWithFormat:@"%@_%@", NSStringFromClass([self class]), caseName];
        mySubclass = objc_allocateClassPair(self, [name cStringUsingEncoding:NSUTF8StringEncoding], 0);
    }
    else {
        mySubclass = self;
    }
    
    SEL selector;
    if (pStyle == TestNamePatchingFunctionName && caseName != nil) {
        NSString *selectorName = [NSString stringWithFormat:@"%@:%@", NSStringFromSelector(invocation.selector), caseName];
        IMP implementation =  class_getMethodImplementation(self, invocation.selector);
        const char *types = [[NSString stringWithFormat:@"%s%s%s%s", @encode(void), @encode(id), @encode(SEL), @encode(char *)] UTF8String];
        selector = NSSelectorFromString(selectorName);
        class_addMethod(self, selector, implementation, types);
    }
    else {
        selector = invocation.selector;
    }
    
    TestCaseWithData *newCase = [[mySubclass alloc] initWithSelector:selector];
    newCase.currentTestData = oneCase;
    
    return newCase;
}

+ (NSArray <TestCaseWithData *> *)casesForInvocation:(NSInvocation *)invocation dataSource:(TestDataSource *)dataSource namePathcing:(TestNamePatching)pStyle burrentBasket:(NSInteger)basket {
    
    NSString *methodName = NSStringFromSelector(invocation.selector);
    NSArray <TestData *> *dataCases = [self dataCasesForTest:methodName dataSource:dataSource];
    if (dataCases != nil) {
        NSMutableArray <TestCaseWithData *> *result = [NSMutableArray new];
        for (TestData *oneCase in dataCases) {
            NSInteger b = [self basketForTestData:oneCase];
            if (basket > 0 && b > 0 && b != basket) {
                continue;
            }
            TestCaseWithData *newCase = [self caseWithData:oneCase invocation:invocation namePathcing:pStyle];
            [result addObject:newCase];
        }
        
        return result;
    }
    else {
        TestCaseWithData *newCase = [self caseWithData:nil invocation:invocation namePathcing:TestNamePatchingNoPathcing];
        return @[newCase];
    }
}

+ (NSArray <TestData *> *)dataCasesForTest:(NSString *)name {
    return nil;
}

+ (NSArray <TestData *> *)dataCasesForTest:(NSString *)name dataSource:(TestDataSource *)dataSource {
    return nil;
}

+ (TestDataSource *)loadDS {
    return nil;
}

+ (TestNamePatching)namePatching {
    return TestNamePatchingFunctionName;
}

+ (NSString *)nameForTestData:(TestData *)data {
    return nil;
}

+ (NSInteger)basketForTestData:(TestData *)data {
    return 0;
}

+ (NSInteger)maxParallelThreads {
    return 0;
}

+ (NSInteger)basketNumber {
    NSString *className = NSStringFromClass(self);
    NSArray *dashParts = [className componentsSeparatedByString:@"_"];
    if (dashParts.count < 2) {
        return 0;
    }
    NSString *numberStr = [[dashParts lastObject] stringByReplacingOccurrencesOfString:@"instance" withString:@""];
    return [numberStr integerValue];
}
@end
