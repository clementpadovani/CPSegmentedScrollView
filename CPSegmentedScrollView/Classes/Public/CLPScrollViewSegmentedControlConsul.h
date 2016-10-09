//
//  CLPScrollViewSegmentedControlConsul.h
//  Segmented Test
//
//  Created by Clément Padovani on 10/2/16.
//  Copyright (c) 2016 Clement Padovani. All rights reserved.
//

@import Foundation;
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface CLPScrollViewSegmentedControlConsul : NSObject

/**
 Create a new consul to manage the transition between pages of `scrollView` in coordination with `segmentedControl`

 @param segmentedControl An instance of `UISegmentedControl` with the same number of segments as the number of `scrollView`’s number of pages.
 @param scrollView An instance of `UIScrollView`, with a pre-existing delegate, whose number of pages is the same as `segmentedControl`’s number of segments
 
 @exception NSInvalidArgumentException Throws if:
 - `scrollView` or `segmentedControl` is `nil`
 - `scrollView`’s `delegate` is nil
 - `scrollView` or `segmentedControl`’s number of pages/segments is less than 2
 - `scrollView` and `segmentedControl`’s number of pages/segments differ
 - `scrollView` has paging disabled
 - `segmentedControl` is a momentary segmented control (`[UISegmentedControl isMomentary]`)
 
 @return An instance of `CLPScrollViewSegmentedControlConsul` that manages the transitions
 */
+ (instancetype) consulWithSegmentedControl: (UISegmentedControl *) segmentedControl withScrollView: (UIScrollView *) scrollView;

- (instancetype) init NS_UNAVAILABLE;

+ (instancetype) alloc NS_UNAVAILABLE;

+ (instancetype) new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
