//
//  CLPScrollViewProxyTests.m
//  CPSegmentedScrollView_Tests
//
//  Created by Clément Padovani on 10/7/16.
//  Copyright © 2016 Clement Padovani. All rights reserved.
//

@import XCTest;
@import CPSegmentedScrollView;

@interface CLPScrollViewProxyTests : XCTestCase

@end

@implementation CLPScrollViewProxyTests

- (void) testProxyCreationGood
{
    CLPScrollViewSegmentedControlConsul <UIScrollViewDelegate> *existingConsul = (CLPScrollViewSegmentedControlConsul <UIScrollViewDelegate> *) [[NSObject alloc] init];
    
    NSObject <UIScrollViewDelegate> *anObject = (NSObject <UIScrollViewDelegate> *) [[NSObject alloc] init];
    
    XCTAssertNoThrow([[CLPScrollViewProxy alloc] initWithConsul: existingConsul
                                        withScrollViewDelegate: anObject]);
}

- (void) testProxyCreationNilConsul
{
    CLPScrollViewSegmentedControlConsul <UIScrollViewDelegate> *nonExistingConsul = (CLPScrollViewSegmentedControlConsul <UIScrollViewDelegate> *) nil;

    NSObject <UIScrollViewDelegate> *anObject = (NSObject <UIScrollViewDelegate> *) [[NSObject alloc] init];
    
    XCTAssertThrows([[CLPScrollViewProxy alloc] initWithConsul: nonExistingConsul
                                        withScrollViewDelegate: anObject]);
}

- (void) testProxyCreationNilDelegate
{
    CLPScrollViewSegmentedControlConsul <UIScrollViewDelegate> *existingConsul = (CLPScrollViewSegmentedControlConsul <UIScrollViewDelegate> *) [[NSObject alloc] init];
    
    NSObject <UIScrollViewDelegate> *anObject = (NSObject <UIScrollViewDelegate> *) nil;
    
    XCTAssertThrows([[CLPScrollViewProxy alloc] initWithConsul: existingConsul
                                        withScrollViewDelegate: anObject]);
}

- (void) testProxyCreationNilConsulAndDelegate
{
    CLPScrollViewSegmentedControlConsul <UIScrollViewDelegate> *nonExistingConsul = (CLPScrollViewSegmentedControlConsul <UIScrollViewDelegate> *) nil;
    
    NSObject <UIScrollViewDelegate> *anObject = (NSObject <UIScrollViewDelegate> *) nil;
    
    XCTAssertThrows([[CLPScrollViewProxy alloc] initWithConsul: nonExistingConsul
                                        withScrollViewDelegate: anObject]);
}

@end
