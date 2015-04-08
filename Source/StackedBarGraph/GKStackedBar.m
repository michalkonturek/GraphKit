//
//  GKStackedBar.m
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

#import "GKStackedBar.h"

#import <QuartzCore/QuartzCore.h>

#import "UIColor+GraphKit.h"

static CFTimeInterval kDefaultAnimationDuration = 1.0;

@interface GKStackedBar ()

@property (atomic, assign) BOOL animationInProgress;

@end

@implementation GKStackedBar

+ (instancetype)create {
    CGRect defaultRect = CGRectMake(0, 0, 30, 200);
    return [self createWithFrame:defaultRect];
}

+ (instancetype)createWithFrame:(CGRect)frame {
    return [[self alloc] initWithFrame:frame];
}

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
    self.animationDuration = kDefaultAnimationDuration;
    self.clipsToBounds = YES;
    self.cornerRadius = 2.0;
    self.foregroundColors = [NSArray array];
    self.backgroundColor = [UIColor gk_silverColor];
    _percentages = [NSMutableArray array];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
}

- (void)setPercentages:(NSArray *)percentages animated:(BOOL)animated {
    self.animated = animated;
    self.percentages = [percentages mutableCopy];
    self.animated = YES;
}

- (void)setPercentage:(CGFloat)percentage atIndex:(NSInteger)index animated:(BOOL)animated {
    self.animated = animated;
    self.percentages[index] = @(percentage);
    self.animated = YES;
}

- (void)setPercentages:(NSArray *)percentages {
    if (_percentages.count < percentages.count) {
        for (int i = 0; i < percentages.count; i++) {
            [_percentages addObject:@0];
        }
    }

    __block CGFloat sum = 0;
    [percentages enumerateObjectsUsingBlock:^(NSNumber *item, NSUInteger idx, BOOL *stop) {
        CGFloat percentage = [item floatValue];
        if (percentage == [_percentages[idx] floatValue]) return;
        if (percentage > 100) percentage = 100;
        if (percentage < 0) percentage = 0;
        if (self.animationInProgress) return;

        [self _progressBarFrom:sum value:percentage atIndex:idx];
        sum += percentage;
    }];

    _percentages = [percentages mutableCopy];
}

- (void)_progressBarFrom:(CGFloat)from value:(CGFloat)value atIndex:(NSInteger)index {
    CGFloat fromConverted = (from / 100);
    CGFloat converted = (value / 100);
    UIBezierPath *path = [self _bezierPathWithStart:fromConverted value:converted atIndex:index];

    CAShapeLayer *layer = [self _layerWithPath:path atIndex:index];
    if ([_percentages[index] floatValue] > value) layer.strokeColor = [self.backgroundColor CGColor];

    [self.layer addSublayer:layer];

    if (self.animated) {
        id animation = [self _animationWithKeyPath:@"strokeEnd"];
        [layer addAnimation:animation forKey:@"strokeEndAnimation"];
    }
}

- (UIBezierPath *)_bezierPathWithStart:(CGFloat)start value:(CGFloat)value atIndex:(NSInteger)index {
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat startX = (self.frame.size.width / 2);
    CGFloat previousStackEndY = self.frame.size.height * start;
    CGFloat startY = (self.frame.size.height * (1 - ([_percentages[index] floatValue] / 100)) - previousStackEndY);
    CGFloat endY = (self.frame.size.height * (1 - value) - previousStackEndY);
    [path moveToPoint:CGPointMake(startX, startY)];
    [path addLineToPoint:CGPointMake(startX, endY)];
    return path;
}

- (CAShapeLayer *)_layerWithPath:(UIBezierPath *)path atIndex:(NSInteger)index {
    CAShapeLayer *item = [CAShapeLayer layer];
    item.fillColor = [[UIColor blackColor] CGColor];
    item.lineCap = kCALineCapButt;
    item.lineWidth = self.frame.size.width;
    item.path = path.CGPath;
    item.strokeColor = [self.foregroundColors[index] CGColor];
    item.strokeEnd = 1.0;
    return item;
}

- (CABasicAnimation *)_animationWithKeyPath:(NSString *)keyPath {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = self.animationDuration;
    animation.fromValue = @(0);
    animation.toValue = @(1);
    animation.delegate = self;
    return animation;
}

- (void)animationDidStart:(CAAnimation *)anim {
    self.animationInProgress = YES;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.animationInProgress = NO;
}

- (void)setForegroundColors:(NSArray *)foregroundColors {
    _foregroundColors = foregroundColors;

    self.layer.sublayers = nil;
    for (int i = 0; i < self.percentages.count; i++) {
        CGFloat temp = [_percentages[i] floatValue];
        [self setPercentage:0 atIndex:i animated:NO];
        [self setPercentage:temp atIndex:i animated:NO];
    }
}

- (void)reset {
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         for (CAShapeLayer *item in self.layer.sublayers) {
                             item.strokeColor = [[UIColor clearColor] CGColor];
                         }
                     } completion:^(BOOL finished) {
                         self.layer.sublayers = nil;
                     }];
    for (int i = 0; i < self.percentages.count; i++) {
        self.percentages[i] = @0;
    }
}

@end
