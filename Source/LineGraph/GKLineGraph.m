//
//  GKLineGraph.m
//  GraphKit
//
//  Created by Michal Konturek on 21/04/2014.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import "GKLineGraph.h"

#import <FrameAccessor/FrameAccessor.h>
#import <MKFoundationKit/NSArray+MK.h>

static CGFloat kDefaultLabelWidth = 40;
static CGFloat kDefaultLabelHeight = 15;
static CGFloat kDefaultMargin = 20;

static CGFloat kAxisMargin = 40;

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
    self.lineWidth = 3.0;
    self.margin = kDefaultMargin;
    self.clipsToBounds = YES;
}

- (void)draw {
    NSAssert(self.dataSource, @"GKLineGraph : No data source is assgined.");
    
    [self _drawLines];
}

- (BOOL)_hasTitleLabels {
    return ![self.titleLabels mk_isEmpty];
}

- (void)_constructTitleLabels {
    
    NSInteger count = [self.dataSource numberOfLines];
    id items = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger idx = 0; idx < count; idx++) {
        
        CGRect frame = CGRectMake(0, 0, kDefaultLabelWidth, kDefaultLabelHeight);
        UILabel *item = [[UILabel alloc] initWithFrame:frame];
        item.textAlignment = NSTextAlignmentCenter;
        item.font = [UIFont boldSystemFontOfSize:13];
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
}

- (void)_layoutTitleLabels {
    
    __block NSInteger idx = 0;
    id values = [self.dataSource valuesForLineAtIndex:0];
    [values mk_each:^(id value) {
        
        CGFloat labelWidth = kDefaultLabelWidth;
        CGFloat labelHeight = kDefaultLabelHeight;
//        CGFloat startX = bar.x - (labelWidth / 2);
//        CGFloat startY = (self.height - labelHeight);
//        
//        UILabel *label = [self.titleLabels objectAtIndex:idx];
//        label.x = startX;
//        label.y = startY;
//        
//        [self addSubview:label];

        idx++;
    }];
}

- (CGFloat)_stepX {
    id values = [self.dataSource valuesForLineAtIndex:0];
    CGFloat step = ([self _plotWidth] / [values count]);
    return step;
}

- (CGFloat)_plotWidth {
    return (self.width - (2 * self.margin) - kAxisMargin);
}

- (void)_drawLines {
    for (NSInteger idx; idx < [self.dataSource numberOfLines]; idx++) {
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
    
//    CGFloat margin = self.margin;
//    CGFloat axisMargin = kAxisMargin;
    
    NSInteger idx = 0;
    id values = [self.dataSource valuesForLineAtIndex:index];
//    CGFloat step = ((self.width - (2 * margin) - axisMargin) / [values count]);
    CGFloat step = [self _stepX];
    for (id item in values) {
        
        CGFloat x = kAxisMargin + self.margin + (idx * step);
        CGFloat y = self.height - [item floatValue];
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

@end
