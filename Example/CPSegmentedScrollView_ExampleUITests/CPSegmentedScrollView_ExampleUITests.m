//
//  CPSegmentedScrollView_ExampleUITests.m
//  CPSegmentedScrollView_ExampleUITests
//
//  Created by Clément Padovani on 10/8/16.
//  Copyright © 2016 Clément Padovani. All rights reserved.
//

@import XCTest;

@interface CPSegmentedScrollView_ExampleUITests : XCTestCase

@end

@implementation CPSegmentedScrollView_ExampleUITests

- (void) setUp
{
    [super setUp];
    
    [self setContinueAfterFailure: NO];
    
    XCUIApplication *application = [[XCUIApplication alloc] init];
    
    [application setLaunchArguments: @[@"-AppleLanguages (en-US)"]];
    
    [application launch];
}

- (void) testBasicUsage
{
    XCUIApplication *application = [[XCUIApplication alloc] init];
    
    XCUIElement *scrollView = [application scrollViews][@"scrollView"];
    
    XCUIElement *firstPage = [scrollView otherElements][@"One"];
    
    [firstPage swipeLeft];
    
    XCUIElement *secondPage = [scrollView otherElements][@"Two"];
    
    XCTAssertTrue([secondPage isHittable]);
    
    XCUIElement *segmentedControl = [application segmentedControls][@"segmentedControl"];
    
    XCUIElement *thirdSegment = [segmentedControl buttons][@"Three"];
    
    [thirdSegment tap];
    
    XCUIElement *thirdPage = [scrollView otherElements][@"Three"];
    
    XCTAssertTrue([thirdPage isHittable]);
    
    XCUIElement *fourthPage = [scrollView otherElements][@"Four"];
    
    XCTAssertFalse([fourthPage exists]);
}

@end
