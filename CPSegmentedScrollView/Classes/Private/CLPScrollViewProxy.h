//
//  CLPScrollViewProxy.h
//  Segmented Test
//
//  Created by Clément Padovani on 10/2/16.
//  Copyright (c) 2016 Clement Padovani. All rights reserved.
//

@import Foundation;
@import UIKit;

@class CLPScrollViewSegmentedControlConsul;

NS_ASSUME_NONNULL_BEGIN

@interface CLPScrollViewProxy : NSProxy

/**
 Creates a new proxy to send messages to `consul` and `scrollViewDelegate`.

 @param consul The consul
 @param scrollViewDelegate The scroll view’s original delegate
 
 @throws NSInvalidArgumentException Throws if:
 - `consul` is `nil`
 - `scrollViewDelegate` is nil
 
 @return The newly created proxy
 */
- (instancetype) initWithConsul: (CLPScrollViewSegmentedControlConsul <UIScrollViewDelegate> *) consul withScrollViewDelegate: (__kindof NSObject <UIScrollViewDelegate> *) scrollViewDelegate;

/**
 An instance of `CLPScrollViewSegmentedControlConsul` that acts as the consul between an instance of `UIScrollView` and another instance of `UISegmentedControl`
 */
@property (nonatomic, weak, readonly) CLPScrollViewSegmentedControlConsul <UIScrollViewDelegate> *consul;

/**
 The scroll view’s original delegate, an object who conforms to the `UIScrollViewDelegate` protocol
 */
@property (nonatomic, weak, readonly) __kindof NSObject <UIScrollViewDelegate> * scrollViewDelegate;

@end

NS_ASSUME_NONNULL_END
