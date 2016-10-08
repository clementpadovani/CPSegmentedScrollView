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

- (instancetype) initWithConsul: (CLPScrollViewSegmentedControlConsul <UIScrollViewDelegate> *) consul withScrollViewDelegate: (__kindof NSObject <UIScrollViewDelegate> *) scrollViewDelegate;

@property (nonatomic, weak, readonly) CLPScrollViewSegmentedControlConsul <UIScrollViewDelegate> *consul;

@property (nonatomic, weak, readonly) __kindof NSObject <UIScrollViewDelegate> * scrollViewDelegate;

@end

NS_ASSUME_NONNULL_END
