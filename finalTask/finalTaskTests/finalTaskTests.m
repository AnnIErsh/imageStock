//
//  finalTaskTests.m
//  finalTaskTests
//
//  Created by Anna Ershova on 7/20/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface finalTaskTests : XCTestCase

@end

@implementation finalTaskTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    //7myf2SlxmCg
    //2ITPoXIOElU
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"2ITPoXIOElU"];
    
    NSLog(@"%@", savedValue);
    XCTAssertTrue([@"https://images.unsplash.com/photo-1563130678-065e2e402941?ixlib=rb-1.2.1&q=85&fm=jpg&crop=entropy&cs=srgb&ixid=eyJhcHBfaWQiOjgzODc2fQ" isEqualToString:savedValue]);
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
