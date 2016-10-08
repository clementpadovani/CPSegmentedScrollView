//
//  CPViewController.m
//  CPSegmentedScrollView
//
//  Created by Clément Padovani on 10/08/2016.
//  Copyright (c) 2016 Clément Padovani. All rights reserved.
//

#import "CPViewController.h"
@import CPSegmentedScrollView;

@interface CPViewController () <UIScrollViewDelegate>

@property (nonatomic, weak) UISegmentedControl *segmentedControl;

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, strong) CLPScrollViewSegmentedControlConsul *consul;

@end

@implementation CPViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setNumberStyle: NSNumberFormatterSpellOutStyle];
    
    [numberFormatter setFormattingContext: NSFormattingContextListItem];
    
    NSUInteger numberOfPages = 2;
    
    NSMutableArray <NSString *> *items = [NSMutableArray arrayWithCapacity: numberOfPages];
    
    for (NSUInteger i = 0; i < numberOfPages; i++)
    {
        NSNumber *currentNumber = @(i + 1);
        
        [items addObject: [numberFormatter stringFromNumber: currentNumber]];
    }
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems: items];
    
    [segmentedControl setAccessibilityIdentifier: @"segmentedControl"];
    
    [segmentedControl setSelectedSegmentIndex: 0];
    
    [segmentedControl setTranslatesAutoresizingMaskIntoConstraints: NO];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    
    [scrollView setAccessibilityIdentifier: @"scrollView"];
    
    [scrollView setBackgroundColor: [UIColor blackColor]];
    
    [scrollView setPagingEnabled: YES];
    
    [scrollView setTranslatesAutoresizingMaskIntoConstraints: NO];
    
    [scrollView setDelegate: self];
    
    UIView *previousView = nil;
    
    for (NSUInteger i = 0; i < numberOfPages; i++)
    {
        UIView *currentView = [[UIView alloc] init];
        
        NSString *title = [segmentedControl titleForSegmentAtIndex: i];
        
        [currentView setAccessibilityIdentifier: title];
        
        srand48((long) ((time(NULL) + random()) % time(NULL)));
        
        CGFloat red = (CGFloat) drand48();
        
        srand48((long) ((time(NULL) + random()) % time(NULL)));
        
        CGFloat green = (CGFloat) drand48();
        
        srand48((long) ((time(NULL) + random()) % time(NULL)));
        
        CGFloat blue = (CGFloat) drand48();
        
        UIColor *randomColor = [UIColor colorWithRed: red
                                               green: green
                                                blue: blue
                                               alpha: 1.f];
        
        [currentView setBackgroundColor: randomColor];
        
        [currentView setOpaque: YES];
        
        [currentView setTranslatesAutoresizingMaskIntoConstraints: NO];
        
        [scrollView addSubview: currentView];
        
        if (i == 0)
        {
            [scrollView addConstraint: [NSLayoutConstraint constraintWithItem: currentView
                                                                    attribute: NSLayoutAttributeLeading
                                                                    relatedBy: NSLayoutRelationEqual
                                                                       toItem: scrollView
                                                                    attribute: NSLayoutAttributeLeading
                                                                   multiplier: 1
                                                                     constant: 0]];
        }
        else
        {
            [scrollView addConstraint: [NSLayoutConstraint constraintWithItem: currentView
                                                                    attribute: NSLayoutAttributeLeading
                                                                    relatedBy: NSLayoutRelationEqual
                                                                       toItem: previousView
                                                                    attribute: NSLayoutAttributeTrailing
                                                                   multiplier: 1
                                                                     constant: 0]];
        }
        
        if (i == (numberOfPages - 1))
        {
            [scrollView addConstraint: [NSLayoutConstraint constraintWithItem: currentView
                                                                    attribute: NSLayoutAttributeTrailing
                                                                    relatedBy: NSLayoutRelationEqual
                                                                       toItem: scrollView
                                                                    attribute: NSLayoutAttributeTrailing
                                                                   multiplier: 1
                                                                     constant: 0]];
        }
        
        [scrollView addConstraint: [NSLayoutConstraint constraintWithItem: currentView
                                                                attribute: NSLayoutAttributeWidth
                                                                relatedBy: NSLayoutRelationEqual
                                                                   toItem: scrollView
                                                                attribute: NSLayoutAttributeWidth
                                                               multiplier: 1
                                                                 constant: 0]];
        
        [scrollView addConstraint: [NSLayoutConstraint constraintWithItem: currentView
                                                                attribute: NSLayoutAttributeTop
                                                                relatedBy: NSLayoutRelationEqual
                                                                   toItem: scrollView
                                                                attribute: NSLayoutAttributeTop
                                                               multiplier: 1
                                                                 constant: 0]];
        
        [scrollView addConstraint: [NSLayoutConstraint constraintWithItem: currentView
                                                                attribute: NSLayoutAttributeBottom
                                                                relatedBy: NSLayoutRelationEqual
                                                                   toItem: scrollView
                                                                attribute: NSLayoutAttributeBottom
                                                               multiplier: 1
                                                                 constant: 0]];
        
        [scrollView addConstraint: [NSLayoutConstraint constraintWithItem: currentView
                                                                attribute: NSLayoutAttributeHeight
                                                                relatedBy: NSLayoutRelationEqual
                                                                   toItem: scrollView
                                                                attribute: NSLayoutAttributeHeight
                                                               multiplier: 1
                                                                 constant: 0]];
        
        previousView = currentView;
    }
    
    [[self view] addSubview: segmentedControl];
    
    [[self view] addSubview: scrollView];
    
    [self setSegmentedControl: segmentedControl];
    
    [self setScrollView: scrollView];
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_segmentedControl,
                                                                   _scrollView);
    
    NSDictionary *metricsDictionary = nil;
    
    [[self view] addConstraints: [NSLayoutConstraint constraintsWithVisualFormat: @"H:|-20-[_segmentedControl]-20-|"
                                                                         options: 0
                                                                         metrics: metricsDictionary
                                                                           views: viewsDictionary]];
    
    [[self view] addConstraints: [NSLayoutConstraint constraintsWithVisualFormat: @"H:|-50-[_scrollView]-50-|"
                                                                         options: 0
                                                                         metrics: metricsDictionary
                                                                           views: viewsDictionary]];
    
    [[self view] addConstraint: [NSLayoutConstraint constraintWithItem: [self scrollView]
                                                             attribute: NSLayoutAttributeWidth
                                                             relatedBy: NSLayoutRelationEqual
                                                                toItem: [self view]
                                                             attribute: NSLayoutAttributeWidth
                                                            multiplier: 1
                                                              constant: -100]];
    
    [[self view] addConstraint: [NSLayoutConstraint constraintWithItem: [self scrollView]
                                                             attribute: NSLayoutAttributeHeight
                                                             relatedBy: NSLayoutRelationEqual
                                                                toItem: nil
                                                             attribute: NSLayoutAttributeNotAnAttribute
                                                            multiplier: 1
                                                              constant: 100]];
    
    [[self view] addConstraints: [NSLayoutConstraint constraintsWithVisualFormat: @"V:|-50-[_segmentedControl]-100-[_scrollView]-(>=0)-|"
                                                                         options: 0
                                                                         metrics: metricsDictionary
                                                                           views: viewsDictionary]];
    
    CLPScrollViewSegmentedControlConsul *consul = [CLPScrollViewSegmentedControlConsul consulWithSegmentedControl: segmentedControl
                                                                                                   withScrollView: scrollView];
    
    [self setConsul: consul];

}

@end
