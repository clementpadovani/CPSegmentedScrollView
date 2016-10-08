//
//  CLPScrollViewSegmentedControlConsulTests.m
//  CPSegmentedScrollView_Tests
//
//  Created by Clément Padovani on 10/7/16.
//  Copyright © 2016 Clement Padovani. All rights reserved.
//

@import XCTest;
@import OCMockito;
#import "CLPScrollViewSegmentedControlConsul.h"

static const NSUInteger kCLPScrollViewSegmentedControlConsulTestsNumberOfItems = 5;

@interface CLPScrollViewSegmentedControlConsulTests : XCTestCase

@end

@implementation CLPScrollViewSegmentedControlConsulTests

- (void) testConsulCreationGood
{    
    UISegmentedControl *segmentedControl = mock([UISegmentedControl class]);
    
    stubProperty(segmentedControl, numberOfSegments, @(kCLPScrollViewSegmentedControlConsulTestsNumberOfItems));

    stubProperty(segmentedControl, isMomentary, @(NO));

    NSObject <UIScrollViewDelegate> *scrollViewDelegate = mockObjectAndProtocol([NSObject class], @protocol(UIScrollViewDelegate));
    
    UIScrollView *scrollView = mock([UIScrollView class]);

    stubProperty(scrollView, delegate, scrollViewDelegate);
    
    stubProperty(scrollView, isPagingEnabled, @(YES));

    NSMutableArray *fakeSubviews = [NSMutableArray arrayWithCapacity: kCLPScrollViewSegmentedControlConsulTestsNumberOfItems];
    
    for (NSUInteger i = 0; i < kCLPScrollViewSegmentedControlConsulTestsNumberOfItems; i++)
    {
        [fakeSubviews addObject: @(i)];
    }
    
    stubProperty(scrollView, subviews, fakeSubviews);
    
    XCTAssertNoThrow([CLPScrollViewSegmentedControlConsul consulWithSegmentedControl: segmentedControl
                                                                      withScrollView: scrollView]);
}

- (void) testConsulCreationBadZeroSegments
{
    UISegmentedControl *segmentedControl = mock([UISegmentedControl class]);
    
    stubProperty(segmentedControl, numberOfSegments, @(0));
    
    stubProperty(segmentedControl, isMomentary, @(NO));
    
    NSObject <UIScrollViewDelegate> *scrollViewDelegate = mockObjectAndProtocol([NSObject class], @protocol(UIScrollViewDelegate));
    
    UIScrollView *scrollView = mock([UIScrollView class]);
    
    stubProperty(scrollView, delegate, scrollViewDelegate);
    
    stubProperty(scrollView, isPagingEnabled, @(YES));
    
    NSMutableArray *fakeSubviews = [NSMutableArray arrayWithCapacity: kCLPScrollViewSegmentedControlConsulTestsNumberOfItems];
    
    for (NSUInteger i = 0; i < kCLPScrollViewSegmentedControlConsulTestsNumberOfItems; i++)
    {
        [fakeSubviews addObject: @(i)];
    }
    
    stubProperty(scrollView, subviews, fakeSubviews);
    
    XCTAssertThrows([CLPScrollViewSegmentedControlConsul consulWithSegmentedControl: segmentedControl
                                                                      withScrollView: scrollView]);
}

- (void) testConsulCreationBadZeroScrollViewSubviews
{
    UISegmentedControl *segmentedControl = mock([UISegmentedControl class]);
    
    stubProperty(segmentedControl, numberOfSegments, @(kCLPScrollViewSegmentedControlConsulTestsNumberOfItems));
    
    stubProperty(segmentedControl, isMomentary, @(NO));
    
    NSObject <UIScrollViewDelegate> *scrollViewDelegate = mockObjectAndProtocol([NSObject class], @protocol(UIScrollViewDelegate));
    
    UIScrollView *scrollView = mock([UIScrollView class]);
    
    stubProperty(scrollView, delegate, scrollViewDelegate);
    
    stubProperty(scrollView, isPagingEnabled, @(YES));
    
    NSMutableArray *fakeSubviews = [NSMutableArray arrayWithCapacity: 0];
    
    stubProperty(scrollView, subviews, fakeSubviews);
    
    XCTAssertThrows([CLPScrollViewSegmentedControlConsul consulWithSegmentedControl: segmentedControl
                                                                      withScrollView: scrollView]);
}

- (void) testConsulCreationBadDifferentNumberOfItems
{
    UISegmentedControl *segmentedControl = mock([UISegmentedControl class]);
    
    stubProperty(segmentedControl, numberOfSegments, @(kCLPScrollViewSegmentedControlConsulTestsNumberOfItems + 1));
    
    stubProperty(segmentedControl, isMomentary, @(NO));
    
    NSObject <UIScrollViewDelegate> *scrollViewDelegate = mockObjectAndProtocol([NSObject class], @protocol(UIScrollViewDelegate));
    
    UIScrollView *scrollView = mock([UIScrollView class]);
    
    stubProperty(scrollView, delegate, scrollViewDelegate);
    
    stubProperty(scrollView, isPagingEnabled, @(YES));
    
    NSMutableArray *fakeSubviews = [NSMutableArray arrayWithCapacity: kCLPScrollViewSegmentedControlConsulTestsNumberOfItems - 1];
    
    for (NSUInteger i = 0; i < kCLPScrollViewSegmentedControlConsulTestsNumberOfItems - 1; i++)
    {
        [fakeSubviews addObject: @(i)];
    }
    
    stubProperty(scrollView, subviews, fakeSubviews);
    
    XCTAssertThrows([CLPScrollViewSegmentedControlConsul consulWithSegmentedControl: segmentedControl
                                                                      withScrollView: scrollView]);
}

- (void) testConsulCreationBadSegmentedControlMomentary
{
    UISegmentedControl *segmentedControl = mock([UISegmentedControl class]);
    
    stubProperty(segmentedControl, numberOfSegments, @(kCLPScrollViewSegmentedControlConsulTestsNumberOfItems));
    
    stubProperty(segmentedControl, isMomentary, @(YES));
    
    NSObject <UIScrollViewDelegate> *scrollViewDelegate = mockObjectAndProtocol([NSObject class], @protocol(UIScrollViewDelegate));
    
    UIScrollView *scrollView = mock([UIScrollView class]);
    
    stubProperty(scrollView, delegate, scrollViewDelegate);
    
    stubProperty(scrollView, isPagingEnabled, @(YES));
    
    NSMutableArray *fakeSubviews = [NSMutableArray arrayWithCapacity: kCLPScrollViewSegmentedControlConsulTestsNumberOfItems];
    
    for (NSUInteger i = 0; i < kCLPScrollViewSegmentedControlConsulTestsNumberOfItems; i++)
    {
        [fakeSubviews addObject: @(i)];
    }
    
    stubProperty(scrollView, subviews, fakeSubviews);
    
    XCTAssertThrows([CLPScrollViewSegmentedControlConsul consulWithSegmentedControl: segmentedControl
                                                                      withScrollView: scrollView]);
}

- (void) testConsulCreationBadNoScrollViewDelegate
{
    UISegmentedControl *segmentedControl = mock([UISegmentedControl class]);
    
    stubProperty(segmentedControl, numberOfSegments, @(kCLPScrollViewSegmentedControlConsulTestsNumberOfItems));
    
    stubProperty(segmentedControl, isMomentary, @(NO));
    
    NSObject <UIScrollViewDelegate> *scrollViewDelegate = nil;
    
    UIScrollView *scrollView = mock([UIScrollView class]);
    
    stubProperty(scrollView, delegate, scrollViewDelegate);
    
    stubProperty(scrollView, isPagingEnabled, @(YES));
    
    NSMutableArray *fakeSubviews = [NSMutableArray arrayWithCapacity: kCLPScrollViewSegmentedControlConsulTestsNumberOfItems];
    
    for (NSUInteger i = 0; i < kCLPScrollViewSegmentedControlConsulTestsNumberOfItems; i++)
    {
        [fakeSubviews addObject: @(i)];
    }
    
    stubProperty(scrollView, subviews, fakeSubviews);
    
    XCTAssertThrows([CLPScrollViewSegmentedControlConsul consulWithSegmentedControl: segmentedControl
                                                                     withScrollView: scrollView]);
}

- (void) testConsulCreationBadScrollViewPagingDisabled
{
    UISegmentedControl *segmentedControl = mock([UISegmentedControl class]);
    
    stubProperty(segmentedControl, numberOfSegments, @(kCLPScrollViewSegmentedControlConsulTestsNumberOfItems));
    
    stubProperty(segmentedControl, isMomentary, @(NO));
    
    NSObject <UIScrollViewDelegate> *scrollViewDelegate = mockObjectAndProtocol([NSObject class], @protocol(UIScrollViewDelegate));
    
    UIScrollView *scrollView = mock([UIScrollView class]);
    
    stubProperty(scrollView, delegate, scrollViewDelegate);
    
    stubProperty(scrollView, isPagingEnabled, @(NO));
    
    NSMutableArray *fakeSubviews = [NSMutableArray arrayWithCapacity: kCLPScrollViewSegmentedControlConsulTestsNumberOfItems];
    
    for (NSUInteger i = 0; i < kCLPScrollViewSegmentedControlConsulTestsNumberOfItems; i++)
    {
        [fakeSubviews addObject: @(i)];
    }
    
    stubProperty(scrollView, subviews, fakeSubviews);
    
    XCTAssertThrows([CLPScrollViewSegmentedControlConsul consulWithSegmentedControl: segmentedControl
                                                                     withScrollView: scrollView]);
}

- (void) testConsulCreationBadNilSegmentedControl
{
    UISegmentedControl *segmentedControl = nil;
    
    stubProperty(segmentedControl, numberOfSegments, @(kCLPScrollViewSegmentedControlConsulTestsNumberOfItems));
    
    stubProperty(segmentedControl, isMomentary, @(NO));
    
    NSObject <UIScrollViewDelegate> *scrollViewDelegate = mockObjectAndProtocol([NSObject class], @protocol(UIScrollViewDelegate));
    
    UIScrollView *scrollView = mock([UIScrollView class]);
    
    stubProperty(scrollView, delegate, scrollViewDelegate);
    
    stubProperty(scrollView, isPagingEnabled, @(YES));
    
    NSMutableArray *fakeSubviews = [NSMutableArray arrayWithCapacity: kCLPScrollViewSegmentedControlConsulTestsNumberOfItems];
    
    for (NSUInteger i = 0; i < kCLPScrollViewSegmentedControlConsulTestsNumberOfItems; i++)
    {
        [fakeSubviews addObject: @(i)];
    }
    
    stubProperty(scrollView, subviews, fakeSubviews);
    
    XCTAssertThrows([CLPScrollViewSegmentedControlConsul consulWithSegmentedControl: segmentedControl
                                                                     withScrollView: scrollView]);
}

- (void) testConsulCreationBadNilScrollView
{
    UISegmentedControl *segmentedControl = mock([UISegmentedControl class]);
    
    stubProperty(segmentedControl, numberOfSegments, @(kCLPScrollViewSegmentedControlConsulTestsNumberOfItems));
    
    stubProperty(segmentedControl, isMomentary, @(NO));
    
    NSObject <UIScrollViewDelegate> *scrollViewDelegate = mockObjectAndProtocol([NSObject class], @protocol(UIScrollViewDelegate));
    
    UIScrollView *scrollView = nil;
    
    stubProperty(scrollView, delegate, scrollViewDelegate);
    
    stubProperty(scrollView, isPagingEnabled, @(YES));
    
    NSMutableArray *fakeSubviews = [NSMutableArray arrayWithCapacity: kCLPScrollViewSegmentedControlConsulTestsNumberOfItems];
    
    for (NSUInteger i = 0; i < kCLPScrollViewSegmentedControlConsulTestsNumberOfItems; i++)
    {
        [fakeSubviews addObject: @(i)];
    }
    
    stubProperty(scrollView, subviews, fakeSubviews);
    
    XCTAssertThrows([CLPScrollViewSegmentedControlConsul consulWithSegmentedControl: segmentedControl
                                                                     withScrollView: scrollView]);
}

@end
