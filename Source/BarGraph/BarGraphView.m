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
//    self.backgroundColor = [UIColor clearColor];
    self.barHeight = kDefaultBarHeight;
    self.barWidth = kDefaultBarWidth;
    
    self.marginBar = 10;
    self.marginLeft = 0;
    self.marginRight = 0;
}

- (void)draw {
    CGFloat x = [self _startX];
    CGFloat y = [self _startY];
    for (id value in self.values) {
        GKBar *bar = [GKBar createWithFrame:CGRectMake(x, y, self.barWidth, self.barHeight)];
        bar.percentage = [value doubleValue];
        [self addSubview:bar];
        x += [self _barSpace];
    }
}

//- (void)_layoutBars {
//    CGFloat margin = 30;
//
//    __block CGFloat x = 20;
//    CGFloat y = self.frame.size.height - self.barHeight;
//    [self.values mk_each:^(id item) {
//        GKBar *bar = [GKBar createWithFrame:CGRectMake(x, y, 20, self.barHeight)];
//        [self addSubview:bar];
//        x += margin;
//    }];
//}

- (CGFloat)_startX {
    CGFloat result = self.width;
    
//    CGFloat item = self.barWidth + self.marginBar;
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

- (void)_loadData {
    [self.values mk_each:^(id item) {
        
    }];
}

- (void)reset {
    for (id bar in self.subviews) {
        if ([bar isMemberOfClass:[GKBar class]]) continue;
        [bar reset];
    }
}

@end
