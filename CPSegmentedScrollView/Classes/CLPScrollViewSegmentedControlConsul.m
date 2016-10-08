//
//  CLPScrollViewSegmentedControlConsul.m
//  Segmented Test
//
//  Created by Clément Padovani on 10/2/16.
//  Copyright (c) 2016 Clement Padovani. All rights reserved.
//

#import "CLPScrollViewSegmentedControlConsul.h"
#import "CLPScrollViewProxy.h"

@interface CLPScrollViewSegmentedControlConsul () <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, weak) UISegmentedControl *segmentedControl;

@property (nonatomic, strong) CLPScrollViewProxy *proxy;

@property (nonatomic, assign) BOOL hasStarted;

@property (nonatomic, assign) BOOL hasEnded;

@property (nonatomic, assign, getter = isAwaitingFinalAnimation) BOOL awaitingFinalAnimation;

@property (nonatomic, assign) CGFloat currentProgress;

@property (nonatomic, assign) NSUInteger currentIndex;

@property (nonatomic, assign) NSUInteger destinationIndex;

@property (nonatomic, assign) NSUInteger numberOfPages;


@end

@implementation CLPScrollViewSegmentedControlConsul

+ (instancetype) consulWithSegmentedControl: (UISegmentedControl *) segmentedControl withScrollView: (UIScrollView *) scrollView
{
    NSParameterAssert(segmentedControl);
    
    NSParameterAssert(scrollView);
    
    NSAssert([scrollView delegate], @"Please set your delegate prior calling %@", NSStringFromSelector(_cmd));
    
    #if !defined(NS_BLOCK_ASSERTIONS)
    
        NSUInteger numberOfScrollViewSubviews = [[scrollView subviews] count];

        NSAssert(numberOfScrollViewSubviews > 1, @"We need atleast two views in the scroll view.");
        
        NSUInteger numberOfSegments = [segmentedControl numberOfSegments];

        NSAssert(numberOfSegments > 1, @"We need atleast two items in the segmented control.");

        NSParameterAssert(numberOfScrollViewSubviews == numberOfSegments);

    #endif
    
    NSParameterAssert([scrollView isPagingEnabled]);
    
    NSAssert([segmentedControl isMomentary] == NO, @"We don't support momentary segmented controls, since it'll be useless here.");
    
    CLPScrollViewSegmentedControlConsul *consul = [[super alloc] initWithSegmentedControl: segmentedControl withScrollView: scrollView];
    
    return consul;
}

- (instancetype) initWithSegmentedControl: (UISegmentedControl *) segmentedControl withScrollView: (UIScrollView *) scrollView
{
    self = [super init];
    
    if (self)
    {
        CLPScrollViewProxy *proxy = [[CLPScrollViewProxy alloc] initWithConsul: self
                                                        withScrollViewDelegate: [scrollView delegate]];
        
        [scrollView setDelegate: (id <UIScrollViewDelegate>) proxy];
        
        _proxy = proxy;
        
        _scrollView = scrollView;
        
        _segmentedControl = segmentedControl;
        
        _numberOfPages = [segmentedControl numberOfSegments];
        
        [segmentedControl addTarget: self action: @selector(segmentedControlDidChangeSelection) forControlEvents: UIControlEventValueChanged];
    }
    
    return self;
}

- (void) segmentedControlDidChangeSelection
{
    NSUInteger selectedIndex = [[self segmentedControl] selectedSegmentIndex];

    [self setCurrentIndex: selectedIndex];
    
    CGFloat pageWidth = CGRectGetWidth([[self scrollView] bounds]);
    
    CGFloat correspondingPage = pageWidth * (CGFloat) selectedIndex;
    
    [UIView animateWithDuration: 1.
                          delay: .0
                        options: UIViewAnimationOptionAllowAnimatedContent | UIViewAnimationOptionOverrideInheritedDuration
                     animations: ^{
                         [[self scrollView] setContentOffset: CGPointMake(correspondingPage, 0) animated: YES];
                     }
                     completion: NULL];
}

- (void) scrollViewWillBeginDragging: (UIScrollView *) scrollView
{
    CGFloat currentOffset = [scrollView contentOffset].x;
    
    CGFloat relativeOffset = currentOffset / CGRectGetWidth([scrollView bounds]);
    
    [self setCurrentIndex: (NSUInteger) relativeOffset];
}

- (void) scrollViewDidScroll: (UIScrollView *) scrollView
{
    if ([self isAwaitingFinalAnimation])
        return;
    
    if ([self hasEnded])
    {
        [self setHasEnded: NO];
        
        [self setAwaitingFinalAnimation: YES];
        
        CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget: self selector: @selector(startAnimations:)];
        
        [displayLink addToRunLoop: [NSRunLoop mainRunLoop] forMode: NSRunLoopCommonModes];
        
        return;
    }
    
    CGFloat currentOffset = [scrollView contentOffset].x;
    
    CGFloat pageWidth = CGRectGetWidth([scrollView bounds]);
    
    if (![self hasStarted])
    {
        if (![scrollView isDragging] ||
            [scrollView isDecelerating])
        {
            return;
        }
        
        CGFloat relativeOffset = currentOffset / pageWidth;
        
        NSInteger newIndex = (NSInteger) ((((CGFloat) [self currentIndex]) < relativeOffset) ? ceil(relativeOffset) : floor(relativeOffset));
        
        if (newIndex > (NSInteger) ([self numberOfPages] - 1))
            newIndex -= 1;
        else if (newIndex < 0)
            newIndex = 0;
        
        [self setDestinationIndex: (NSUInteger) newIndex];
        
        [[[self segmentedControl] layer] setSpeed: .0f];
        
        [[[self segmentedControl] layer] setTimeOffset: .0];
        
        [self setHasStarted: YES];
        
        CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget: self selector: @selector(startAnimations:)];
        
        [displayLink addToRunLoop: [NSRunLoop mainRunLoop] forMode: NSRunLoopCommonModes];
        
        return;
    }
    
    double progress = fmod(currentOffset, pageWidth) / pageWidth;
    
    if ([self currentIndex] > [self destinationIndex])
        progress = 1. - progress;
    
    progress = MIN(MAX(.0, progress), 1.);
    
    [[[self segmentedControl] layer] setTimeOffset: progress];
    
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget: self selector: @selector(startAnimations:)];
    
    [displayLink addToRunLoop: [NSRunLoop mainRunLoop] forMode: NSRunLoopCommonModes];
}

- (void) finishTransition
{
    [self finishTransitionWithIndex: NO];
}

- (void) finishTransitionWithIndex: (BOOL) hasIndex
{
    if (![self hasStarted])
        return;
    
    [self setHasStarted: NO];
    
    if (!hasIndex)
    {
        CGFloat currentOffset = [[self scrollView] contentOffset].x;
        
        [self setCurrentIndex: (NSUInteger) (currentOffset / CGRectGetWidth([[self scrollView] bounds]))];
    }
    
    [self restoreLayerAnimations];
    
    [[self segmentedControl] setSelectedSegmentIndex: [self currentIndex]];
}

- (void) restoreLayerAnimations
{
    NSMutableArray <CALayer *> *layers = [NSMutableArray arrayWithObject: [[self segmentedControl] layer]];
    
    [[[self segmentedControl] layer] setSpeed: 1.f];
    
    [[[self segmentedControl] layer] setTimeOffset: .0];
    
    while ([layers count] > 0)
    {
        CALayer *theLayer = [layers lastObject];
        
        [theLayer removeAllAnimations];
        
        [layers removeLastObject];
        
        if ([theLayer sublayers] &&
            [[theLayer sublayers] count] > 0)
            [layers addObjectsFromArray: [theLayer sublayers]];
    }
}

- (void) scrollViewDidEndDragging: (UIScrollView * __unused) scrollView willDecelerate: (BOOL) decelerate
{
    if (!decelerate)
        [self finishTransition];
}

- (void) scrollViewDidEndScrollingAnimation: (UIScrollView * __unused) scrollView
{
    [self finishTransition];
}

- (void) scrollViewDidEndDecelerating: (UIScrollView * __unused) scrollView
{
    [self finishTransition];
}

- (void) scrollViewWillEndDragging: (UIScrollView *) scrollView withVelocity: (CGPoint __unused) velocity targetContentOffset: (inout CGPoint *) targetContentOffset
{
    [self setHasEnded: YES];
    
    [self setHasStarted: NO];
    
    NSUInteger newCurrentIndex = (NSUInteger) (targetContentOffset->x / CGRectGetWidth([scrollView bounds]));
    
    [self setCurrentIndex: newCurrentIndex];
    
    [self finishTransitionWithIndex: YES];
}

- (void) startAnimations: (CADisplayLink *) displayLink
{
    [displayLink invalidate];
    
    void (^animationBlock)() = ^{
        [[self segmentedControl] setSelectedSegmentIndex: [self destinationIndex]];
    };
    
    
    if ([self isAwaitingFinalAnimation])
    {
        [[[self segmentedControl] layer] setSpeed: 1.f];
        
        [[[self segmentedControl] layer] setTimeOffset: .0];
        
        [self setAwaitingFinalAnimation: NO];
        
        NSUInteger destinationIndex = [self destinationIndex];
        
        [self setDestinationIndex: [self currentIndex]];
        
        [UIView performWithoutAnimation: animationBlock];
        
        animationBlock();
        
        [self setCurrentIndex: destinationIndex];
        
        return ;
    }
    
    [UIView animateWithDuration: 1.
                          delay: .0
                        options: UIViewAnimationOptionAllowAnimatedContent | UIViewAnimationOptionOverrideInheritedDuration
                     animations: animationBlock
                     completion: NULL];
}


@end
