//
//  BarGraphView.m
//  GraphKit
//
//  Created by Michal Konturek on 16/04/2014.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import "BarGraphView.h"

#import <FrameAccessor/FrameAccessor.h>
#import <MKFoundationKit/NSArray+MK.h>

#import "GKBar.h"

static CGFloat kDefaultBarHeight = 100;
static CGFloat kDefaultBarWidth = 20;

@implementation BarGraphView

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
    
    self.marginBar = 10;
    self.marginLeft = 0;
    self.marginRight = 0;
}

- (instancetype)drawAndLoad {
    return [[self draw] load];
}

- (instancetype)draw {
    [self _constructBars];
    [self _layoutBars];
    return self;
}

- (void)_constructBars {
    
    NSInteger count = [self.values count];
    id items = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger idx = 0; idx < count; idx++) {
        [items addObject:[GKBar create]];
    }
    self.bars = items;
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

- (instancetype)load {
    __block NSInteger idx = 0;
    [self.bars mk_each:^(GKBar *item) {
        item.percentage = [[self.values objectAtIndex:idx] doubleValue];
        idx++;
    }];
    return self;
}

- (CGFloat)_startX {
    CGFloat result = self.width;
    CGFloat item = [self _barSpace];
    NSInteger count = [self.values count];
    
    result = result - (item * count) + self.marginBar;
    result = result / 2;
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
