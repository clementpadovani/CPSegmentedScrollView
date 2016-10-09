//
//  CLPScrollViewProxy.m
//  Segmented Test
//
//  Created by Clément Padovani on 10/2/16.
//  Copyright (c) 2016 Clement Padovani. All rights reserved.
//

#import "CLPScrollViewProxy.h"
#import "CLPScrollViewSegmentedControlConsul.h"

@interface CLPScrollViewProxy ()

@property (nonatomic, weak, readwrite) CLPScrollViewSegmentedControlConsul <UIScrollViewDelegate> *consul;

@property (nonatomic, weak, readwrite) __kindof NSObject <UIScrollViewDelegate> * scrollViewDelegate;

@end

@implementation CLPScrollViewProxy

- (instancetype) initWithConsul: (CLPScrollViewSegmentedControlConsul <UIScrollViewDelegate> *) consul withScrollViewDelegate: (__kindof NSObject <UIScrollViewDelegate> *) scrollViewDelegate
{
    NSParameterAssert(consul);
    
    NSParameterAssert(scrollViewDelegate);
    
	if (self)
    {
        _consul = consul;
        
        _scrollViewDelegate = scrollViewDelegate;
    }
	
	return self;
}

- (BOOL) respondsToSelector: (SEL) aSelector
{
    return ([[self scrollViewDelegate] respondsToSelector: aSelector] ||
            [[self consul] respondsToSelector: aSelector]);
}

 - (id) forwardingTargetForSelector: (SEL) aSelector
{
    BOOL bothRespond = ([[self scrollViewDelegate] respondsToSelector: aSelector] &&
                        [[self consul] respondsToSelector: aSelector]);
    
    if (bothRespond)
        return self;
    
    if ([[self scrollViewDelegate] respondsToSelector: aSelector])
        return [self scrollViewDelegate];
    if ([[self consul] respondsToSelector: aSelector])
        return [self consul];
    else
        return nil;
}

- (NSMethodSignature *) methodSignatureForSelector: (SEL) sel
{
    NSMethodSignature *methodSignature = [[self scrollViewDelegate] methodSignatureForSelector: sel];
    
    if (!methodSignature)
    {
        methodSignature = [[self consul] methodSignatureForSelector: sel];
    }
    
    return methodSignature;
}

- (void) forwardInvocation: (NSInvocation *) invocation
{
    NSParameterAssert([NSThread isMainThread]);
    
    [self forwardInvocation: invocation withTarget: [self scrollViewDelegate]];
    
    [self forwardInvocation: invocation withTarget: [self consul]];
}

- (void) forwardInvocation: (NSInvocation *) invocation withTarget: (id) target
{
    if ([target respondsToSelector: [invocation selector]])
        [invocation invokeWithTarget: target];
}

@end
