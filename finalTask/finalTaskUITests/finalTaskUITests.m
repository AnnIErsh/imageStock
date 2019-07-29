//
//  finalTaskUITests.m
//  finalTaskUITests
//
//  Created by Anna Ershova on 7/20/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface finalTaskUITests : XCTestCase

@end

@implementation finalTaskUITests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;

    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    [XCUIDevice sharedDevice].orientation = UIDeviceOrientationLandscapeRight;
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *collectionViewsQuery = app.collectionViews;
    XCUIElement *element = [[[collectionViewsQuery childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:3] childrenMatchingType:XCUIElementTypeOther].element;
    [element tap];
    [element tap];
    [XCUIDevice sharedDevice].orientation = UIDeviceOrientationPortraitUpsideDown;
    [XCUIDevice sharedDevice].orientation = UIDeviceOrientationLandscapeLeft;
    [XCUIDevice sharedDevice].orientation = UIDeviceOrientationPortrait;
    
    XCUIElement *element2 = [[[collectionViewsQuery childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther].element;
    [element2 tap];
    [element2 tap];
    [app.navigationBars[@"View"].buttons[@"SAVE"] tap];
    
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

@end
