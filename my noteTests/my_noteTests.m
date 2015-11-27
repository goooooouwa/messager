//
//  my_noteTests.m
//  my noteTests
//
//  Created by Greg Xu on 2/24/14.
//  Copyright (c) 2014 Greg Xu. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface my_noteTests : XCTestCase

@end

@implementation my_noteTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    // implement your test here
    XCTAssert(true);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        NSNumber *a = @0;
        for (int i=0; i<10000000; i++) {
            a = @(a.intValue + 1);
        }
    }];
}

@end
