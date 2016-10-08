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

+ (instancetype) consulWithSegmentedControl: (UISegmentedControl *) segmentedControl withScrollView: (UIScrollView *) scrollView;

- (instancetype) init NS_UNAVAILABLE;

+ (instancetype) alloc NS_UNAVAILABLE;

+ (instancetype) new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
