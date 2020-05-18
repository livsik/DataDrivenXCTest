//
//  TestSuite.m
//  DataDrivenTestsFramework
//
//  Created by Dmitry Protserov on 18.05.2020.
//

#import "TestSuite.h"

@implementation TestSuite

- (void)tearDown {
    [super tearDown];
    
    if ([self tests].count > 0) {
        XCTestCase *case1 = [self tests][0];
        [case1.class tearDown];
    }
}

@end
