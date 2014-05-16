//
//  GKLineGraph.m
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

#import "GKLineGraph.h"

#import <FrameAccessor/FrameAccessor.h>
#import <MKFoundationKit/NSArray+MK.h>

static CGFloat kDefaultLabelWidth = 40.0;
static CGFloat kDefaultLabelHeight = 12.0;
static NSInteger kDefaultValueLabelCount = 5;

static CGFloat kDefaultLineWidth = 3.0;
static CGFloat kDefaultMargin = 10.0;
static CGFloat kDefaultMarginBottom = 20.0;

static CGFloat kAxisMargin = 50.0;

@interface GKLineGraph ()

@property (nonatomic, strong) NSArray *titleLabels;
@property (nonatomic, strong) NSArray *valueLabels;

@end

@implementation GKLineGraph

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
    self.animated = YES;
    self.animationDuration = 1;
    self.lineWidth = kDefaultLineWidth;
    self.margin = kDefaultMargin;
    self.valueLabelCount = kDefaultValueLabelCount;
    self.clipsToBounds = YES;
}

- (void)draw {
    NSAssert(self.dataSource, @"GKLineGraph : No data source is assgined.");
    
    if ([self _hasTitleLabels]) [self _removeTitleLabels];
    [self _constructTitleLabels];
    [self _positionTitleLabels];

    if ([self _hasValueLabels]) [self _removeValueLabels];
    [self _constructValueLabels];
    
    [self _drawLines];
}

- (BOOL)_hasTitleLabels {
    return ![self.titleLabels mk_isEmpty];
}

- (BOOL)_hasValueLabels {
    return ![self.valueLabels mk_isEmpty];
}

- (void)_constructTitleLabels {
    
    NSInteger count = [[self.dataSource valuesForLineAtIndex:0] count];
    id items = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger idx = 0; idx < count; idx++) {
        
        CGRect frame = CGRectMake(0, 0, kDefaultLabelWidth, kDefaultLabelHeight);
        UILabel *item = [[UILabel alloc] initWithFrame:frame];
        item.textAlignment = NSTextAlignmentCenter;
        item.font = [UIFont boldSystemFontOfSize:12];
        item.textColor = [UIColor lightGrayColor];
        item.text = [self.dataSource titleForLineAtIndex:idx];
        
        [items addObject:item];
    }
    self.titleLabels = items;
}

- (void)_removeTitleLabels {
    [self.titleLabels mk_each:^(id item) {
        [item removeFromSuperview];
    }];
    self.titleLabels = nil;
}

- (void)_positionTitleLabels {
    
    __block NSInteger idx = 0;
    id values = [self.dataSource valuesForLineAtIndex:0];
    [values mk_each:^(id value) {
        
        CGFloat labelWidth = kDefaultLabelWidth;
        CGFloat labelHeight = kDefaultLabelHeight;
        CGFloat startX = [self _pointXForIndex:idx] - (labelWidth / 2);
        CGFloat startY = (self.height - labelHeight);
        
        UILabel *label = [self.titleLabels objectAtIndex:idx];
        label.x = startX;
        label.y = startY;
        
        [self addSubview:label];

        idx++;
    }];
}

- (CGFloat)_pointXForIndex:(NSInteger)index {
    return kAxisMargin + self.margin + (index * [self _stepX]);
}

- (CGFloat)_stepX {
    id values = [self.dataSource valuesForLineAtIndex:0];
    CGFloat result = ([self _plotWidth] / [values count]);
    return result;
}

- (void)_constructValueLabels {
    
    NSInteger count = self.valueLabelCount;
    id items = [NSMutableArray arrayWithCapacity:count];
    
    for (NSInteger idx = 0; idx < count; idx++) {
        
        CGRect frame = CGRectMake(0, 0, kDefaultLabelWidth, kDefaultLabelHeight);
        UILabel *item = [[UILabel alloc] initWithFrame:frame];
        item.textAlignment = NSTextAlignmentRight;
        item.font = [UIFont boldSystemFontOfSize:12];
        item.textColor = [UIColor lightGrayColor];
    
        CGFloat value = [self _minValue] + (idx * [self _stepValueLabelY]);
        item.centerY = [self _positionYForLineValue:value];
        
        item.text = [@(ceil(value)) stringValue];
//        item.text = [@(value) stringValue];
        
        [items addObject:item];
        [self addSubview:item];
    }
    self.valueLabels = items;
}

- (CGFloat)_stepValueLabelY {
    return (([self _maxValue] - [self _minValue]) / (self.valueLabelCount - 1));
}

- (CGFloat)_maxValue {
    id values = [self _allValues];
    return [[values mk_max] floatValue];
}

- (CGFloat)_minValue {
    if (self.startFromZero) return 0;
    id values = [self _allValues];
    return [[values mk_min] floatValue];
}

- (NSArray *)_allValues {
    NSInteger count = [self.dataSource numberOfLines];
    id values = [NSMutableArray array];
    for (NSInteger idx = 0; idx < count; idx++) {
        id item = [self.dataSource valuesForLineAtIndex:idx];
        [values addObjectsFromArray:item];
    }
    return values;
}

- (void)_removeValueLabels {
    [self.valueLabels mk_each:^(id item) {
        [item removeFromSuperview];
    }];
    self.valueLabels = nil;
}

- (CGFloat)_plotWidth {
    return (self.width - (2 * self.margin) - kAxisMargin);
}

- (CGFloat)_plotHeight {
    return (self.height - (2 * kDefaultLabelHeight + kDefaultMarginBottom));
}

- (void)_drawLines {
    for (NSInteger idx = 0; idx < [self.dataSource numberOfLines]; idx++) {
        [self _drawLineAtIndex:idx];
    }
}

- (void)_drawLineAtIndex:(NSInteger)index {
    
    // http://stackoverflow.com/questions/19599266/invalid-context-0x0-under-ios-7-0-and-system-degradation
    UIGraphicsBeginImageContext(self.frame.size);
    
    UIBezierPath *path = [self _bezierPathWith:0];
    CAShapeLayer *layer = [self _layerWithPath:path];
    
    layer.strokeColor = [[self.dataSource colorForLineAtIndex:index] CGColor];
    
    [self.layer addSublayer:layer];
    
    NSInteger idx = 0;
    id values = [self.dataSource valuesForLineAtIndex:index];
    for (id item in values) {

        CGFloat x = [self _pointXForIndex:idx];
        CGFloat y = [self _positionYForLineValue:[item floatValue]];
        CGPoint point = CGPointMake(x, y);
        
        if (idx != 0) [path addLineToPoint:point];
        [path moveToPoint:point];
        
        idx++;
    }
    
    layer.path = path.CGPath;
    
    if (self.animated) {
        CABasicAnimation *animation = [self _animationWithKeyPath:@"strokeEnd"];
        if ([self.dataSource respondsToSelector:@selector(animationDurationForLineAtIndex:)]) {
            animation.duration = [self.dataSource animationDurationForLineAtIndex:index];
        }
        [layer addAnimation:animation forKey:@"strokeEndAnimation"];
    }
    
    UIGraphicsEndImageContext();
}

- (CGFloat)_positionYForLineValue:(CGFloat)value {
    CGFloat scale = (value - [self _minValue]) / ([self _maxValue] - [self _minValue]);
    CGFloat result = [self _plotHeight] * scale;
    result = ([self _plotHeight] -  result);
    result += kDefaultLabelHeight;
    return result;
}

- (UIBezierPath *)_bezierPathWith:(CGFloat)value {
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineWidth = self.lineWidth;
    return path;
}

- (CAShapeLayer *)_layerWithPath:(UIBezierPath *)path {
    CAShapeLayer *item = [CAShapeLayer layer];
    item.fillColor = [[UIColor blackColor] CGColor];
    item.lineCap = kCALineCapRound;
    item.lineJoin  = kCALineJoinRound;
    item.lineWidth = self.lineWidth;
//    item.strokeColor = [self.foregroundColor CGColor];
    item.strokeColor = [[UIColor redColor] CGColor];
    item.strokeEnd = 1;
    return item;
}

- (CABasicAnimation *)_animationWithKeyPath:(NSString *)keyPath {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = self.animationDuration;
    animation.fromValue = @(0);
    animation.toValue = @(1);
//    animation.delegate = self;
    return animation;
}

- (void)reset {
    self.layer.sublayers = nil;
    [self _removeTitleLabels];
    [self _removeValueLabels];
}

@end
