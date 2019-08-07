//
//  TestCaseLauncher.m
//  DataDrivenTestsFramework
//
//  Created by Dmitry Protserov on 8/7/19.
//

#import "TestCaseLauncher.h"
#include <objc/runtime.h>
#import "TestCaseWithData.h"

@implementation TestCaseLauncher

- (instancetype)init {
    self = [super init];
      [XCTestObservationCenter.sharedTestObservationCenter addTestObserver:self];
    return self;
}

- (NSArray<NSString *> *)getTestClasses {
    NSMutableArray <NSString *> *resultClases = [NSMutableArray new];
    int numClasses;
    Class *classes = NULL;
    
    classes = NULL;
    numClasses = objc_getClassList(NULL, 0);
    NSLog(@"Number of classes: %d", numClasses);
    
    if (numClasses == 0 ) {
        return @[];
    }
    
    classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
    numClasses = objc_getClassList(classes, numClasses);
    for (int i = 0; i < numClasses; i++) {
        Class oneClass = classes[i];
        if (class_getClassMethod(oneClass, @selector(isSubclassOfClass:)) == NULL) {
            continue;
        }
        
        NSString *className = [NSString stringWithFormat:@"%s", class_getName(oneClass)];
        
        if ([oneClass isSubclassOfClass:[TestCaseWithData class]] && oneClass != [TestCaseWithData class]) {
            [resultClases addObject:className];
        }
        
    }
    free(classes);
    
    return resultClases;
}

- (void)testBundleWillStart:(NSBundle *)testBundle {
    NSArray <NSString *> *testClassNames = [self getTestClasses];
    for (NSString *cName in testClassNames) {
        Class c = NSClassFromString(cName);
        NSInteger threads = [c maxParallelThreads];
        if (threads > 1) {
            [self registerMultipleClasses:c threads:threads];
        }
    }
}

- (void)registerMultipleClasses:(Class)classToCreate threads:(NSInteger)threads {
    for (int i = 0; i < threads; i++) {
        NSString *name = [NSString stringWithFormat:@"%@_instance%d", NSStringFromClass(classToCreate), i+1];
        Class mySubclass = objc_allocateClassPair(classToCreate, [name cStringUsingEncoding:NSUTF8StringEncoding], 0);
        objc_registerClassPair(mySubclass);
    }
}

- (void)testCaseWillStart:(XCTestCase *)testCase {
    NSLog(@"%@", testCase.description);
}

@end
