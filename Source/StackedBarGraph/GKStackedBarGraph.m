//
//  GKStackedBarGraph.m
//  GraphKit
//
//  Copyright (c) 2014 Michal Konturek
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "GKStackedBarGraph.h"

#import <FrameAccessor/FrameAccessor.h>
#import <MKFoundationKit/NSArray+MK.h>

#import "GKStackedBar.h"

static CGFloat kDefaultBarHeight = 140;
static CGFloat kDefaultBarWidth = 22;
static CGFloat kDefaultBarMargin = 20;
static CGFloat kDefaultLabelWidth = 40;
static CGFloat kDefaultLabelHeight = 15;

static CGFloat kDefaultAnimationDuration = 2.0;

@implementation GKStackedBarGraph

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
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)_init {
    self.animationDuration = kDefaultAnimationDuration;
    self.barHeight = kDefaultBarHeight;
    self.barWidth = kDefaultBarWidth;
    self.marginBar = kDefaultBarMargin;
}

- (void)setAnimated:(BOOL)animated {
    _animated = animated;
    [self.bars mk_each:^(GKStackedBar *item) {
        item.animated = animated;
    }];
}

- (void)setAnimationDuration:(CFTimeInterval)animationDuration {
    _animationDuration = animationDuration;
    [self.bars mk_each:^(GKStackedBar *item) {
        item.animationDuration = animationDuration;
    }];
}

- (void)setBarColors:(NSArray *)barColors {
    _barColors = barColors;
    [self.bars mk_each:^(GKStackedBar *item) {
        item.foregroundColors = barColors;
    }];
}

- (void)draw {
    [self _construct];
    [self _drawBars];
}

- (void)_construct {
    NSAssert(self.dataSource, @"GKStackedBarGraph : No data source is assigned.");

    if ([self _hasBars]) [self _removeBars];
    if ([self _hasLabels]) [self _removeLabels];

    [self _constructBars];
    [self _constructLabels];

    [self _positionBars];
    [self _positionLabels];
}

- (BOOL)_hasBars {
    return ![self.bars mk_isEmpty];
}

- (void)_constructBars {
    NSInteger barCount = [self.dataSource numberOfBars];
    id bars = [NSMutableArray arrayWithCapacity:barCount];
    for (NSInteger idx = 0; idx < barCount; idx++) {
        GKStackedBar *item = [GKStackedBar create];
        if ([self barColors]) item.foregroundColors = [self barColors];
        [bars addObject:item];
    }
    self.bars = bars;
}

- (void)_removeBars {
    [self.bars mk_each:^(GKStackedBar *item) {
        [item removeFromSuperview];
    }];
}

- (void)_positionBars {
    CGFloat y = [self _barStartY];

    __block CGFloat x = [self _barStartX];
    [self.bars mk_each:^(GKStackedBar *item) {
        item.frame = CGRectMake(x, y, _barWidth, _barHeight);
        [self addSubview:item];
        x += [self _barSpace];
    }];
}

- (CGFloat)_barStartX {
    CGFloat result = self.width;
    CGFloat item = [self _barSpace];
    NSInteger count = [self.dataSource numberOfBars];

    result = result - (item * count) + self.marginBar;
    result = (result / 2);
    return result;
}

- (CGFloat)_barSpace {
    return (self.barWidth + self.marginBar);
}

- (CGFloat)_barStartY {
    return (self.height - self.barHeight);
}

- (BOOL)_hasLabels {
    return ![self.labels mk_isEmpty];
}

- (void)_constructLabels {

    NSInteger count = [self.dataSource numberOfBars];
    id items = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger idx = 0; idx < count; idx++) {

        CGRect frame = CGRectMake(0, 0, kDefaultLabelWidth, kDefaultLabelHeight);
        UILabel *item = [[UILabel alloc] initWithFrame:frame];
        item.textAlignment = NSTextAlignmentCenter;
        item.font = [UIFont boldSystemFontOfSize:13];
        item.textColor = [UIColor lightGrayColor];
        item.text = [self.dataSource titleForBarAtIndex:idx];

        [items addObject:item];
    }
    self.labels = items;
}

- (void)_removeLabels {
    [self.labels mk_each:^(id item) {
        [item removeFromSuperview];
    }];
}

- (void)_positionLabels {

    __block NSInteger idx = 0;
    [self.bars mk_each:^(GKStackedBar *bar) {

        CGFloat labelWidth = kDefaultLabelWidth;
        CGFloat labelHeight = kDefaultLabelHeight;
        CGFloat startX = bar.x - ((labelWidth - self.barWidth) / 2);
        CGFloat startY = (self.height - labelHeight);

        UILabel *label = [self.labels objectAtIndex:idx];
        label.x = startX;
        label.y = startY;

        [self addSubview:label];

        bar.y -= labelHeight + 5;
        idx++;
    }];
}

- (void)_drawBars {
    __block NSInteger idx = 0;
    id source = self.dataSource;
    [self.bars mk_each:^(GKStackedBar *item) {

        if ([source respondsToSelector:@selector(animationDurationForBarAtIndex:)]) {
            item.animationDuration = [source animationDurationForBarAtIndex:idx];
        }

        if ([source respondsToSelector:@selector(colorForBarAtIndex:stack:)]) {
            NSMutableArray *colors = [NSMutableArray array];
            for (int i = 0; i < [self.dataSource numberOfStacks]; i++) {
                [colors addObject:[source colorForBarAtIndex:idx stack:i]];
            }
            item.foregroundColors = colors;
        }

        if ([source respondsToSelector:@selector(colorForBarBackgroundAtIndex:)]) {
            item.backgroundColor = [source colorForBarBackgroundAtIndex:idx];
        }

        NSMutableArray *percentages = [NSMutableArray array];
        for (int i = 0; i < [self.dataSource numberOfStacks]; i++) {
            [percentages addObject:[source valueForBarAtIndex:idx stack:i]];
        }
        item.percentages = percentages;
        idx++;
    }];
}

- (void)reset {
    [self.bars mk_each:^(GKStackedBar *item) {
        [item reset];
    }];
}

@end
