//
//  GKBarGraph.m
//  GraphKit
//
//  Created by Michal Konturek on 16/04/2014.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import "GKBarGraph.h"

#import <FrameAccessor/FrameAccessor.h>
#import <MKFoundationKit/NSArray+MK.h>

#import "GKBar.h"

static CGFloat kDefaultBarHeight = 140;
static CGFloat kDefaultBarWidth = 22;
static CGFloat kDefaultBarMargin = 10;

@implementation GKBarGraph

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _init];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _init];
    }
    return self;
}

- (void)_init {
    self.backgroundColor = [UIColor clearColor];
    self.barHeight = kDefaultBarHeight;
    self.barWidth = kDefaultBarWidth;
    self.marginBar = kDefaultBarMargin;
}

- (void)setBarColor:(UIColor *)color {
    _barColor = color;
    [self.bars mk_each:^(GKBar *item) {
        item.foregroundColor = color;
    }];
}

- (void)setAnimated:(BOOL)animated {
    _animated = animated;
    [self.bars mk_each:^(GKBar *item) {
        item.animated = animated;
    }];
}

- (void)setAnimationDuration:(CFTimeInterval)animationDuration {
    _animationDuration = animationDuration;
    [self.bars mk_each:^(GKBar *item) {
        item.animationDuration = animationDuration;
    }];
}

- (instancetype)redraw {
    return [[self construct] draw];
}

- (instancetype)construct {
    [self _construct];
    [self _layoutBars];
    return self;
}

- (void)_construct {
    if (![self.bars mk_isEmpty]) [self _deconstructBars];
    [self _constructBars];
}

- (void)_constructBars {
//    NSInteger count = [self.values count];
    NSInteger count = [self.dataSource numberOfBars];
    id items = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger idx = 0; idx < count; idx++) {
        GKBar *item = [GKBar create];
        if ([self barColor]) item.foregroundColor = [self barColor];
        [items addObject:item];
//        [self addSubview:item];
    }
    self.bars = items;
}

- (void)_deconstructBars {
    [self.bars mk_each:^(id item) {
        [item removeFromSuperview];
    }];
}

- (void)_layoutBars {
    CGFloat y = [self _startY];
    
    __block CGFloat x = [self _startX];
    [self.bars mk_each:^(GKBar *item) {
        item.frame = CGRectMake(x, y, _barWidth, _barHeight);
        [self addSubview:item];
        x += [self _barSpace];
    }];
}

- (instancetype)draw {
    __block NSInteger idx = 0;
    id source = self.dataSource;
    [self.bars mk_each:^(GKBar *item) {
//        item.percentage = [[self.values objectAtIndex:idx] doubleValue];
        
        if ([source respondsToSelector:@selector(animationDurationForBarAtIndex:)]) {
            item.animationDuration = [source animationDurationForBarAtIndex:idx];
        }
        
        item.foregroundColor = [source colorForBarAtIndex:idx];
        
        item.percentage = [[source valueForBarAtIndex:idx] doubleValue];
        idx++;
    }];
    return self;
}

- (CGFloat)_startX {
    CGFloat result = self.width;
    CGFloat item = [self _barSpace];
//    NSInteger count = [self.values count];
    NSInteger count = [self.dataSource numberOfBars];
    
    result = result - (item * count) + self.marginBar;
    result = (result / 2);
    return result;
}

- (CGFloat)_barSpace {
    return (self.barWidth + self.marginBar);
}

- (CGFloat)_startY {
    return (self.height - self.barHeight);
}

- (instancetype)reset {
    [self.bars mk_each:^(GKBar *item) {
        [item reset];
    }];
    return self;
}

@end
