//
//  GKBar.m
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

#import "GKBar.h"

#import <QuartzCore/QuartzCore.h>

#import "UIColor+GraphKit.h"

static CFTimeInterval kDefaultAnimationDuration = 1.0;

@interface GKBar ()

@property (atomic, assign) BOOL animationInProgress;

@end

@implementation GKBar

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
    self.foregroundColor = [UIColor gk_turquoiseColor];
    self.backgroundColor = [UIColor gk_silverColor];
    _percentage = 0;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
}

- (void)setPercentage:(CGFloat)percentage animated:(BOOL)animated {
    self.animated = animated;
    self.percentage = percentage;
    self.animated = YES;
}

- (void)setPercentage:(CGFloat)percentage {
    if (percentage == _percentage) return;
    if (percentage > 100) percentage = 100;
    if (percentage < 0) percentage = 0;
    if (self.animationInProgress) return;
    
    [self _progressBarTo:percentage];
    _percentage = percentage;
}

- (void)_progressBarTo:(CGFloat)value {
    
    CGFloat converted = (value / 100);
    UIBezierPath *path = [self _bezierPathWith:converted];
    
    CAShapeLayer *layer = [self _layerWithPath:path];
    if (_percentage > value) layer.strokeColor = [self.backgroundColor CGColor];
    
    [self.layer addSublayer:layer];
    
    if (self.animated) {
        id animation = [self _animationWithKeyPath:@"strokeEnd"];
        [layer addAnimation:animation forKey:@"strokeEndAnimation"];
    }
}

- (UIBezierPath *)_bezierPathWith:(CGFloat)value {
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat startX = (self.frame.size.width / 2);
    CGFloat startY = (self.frame.size.height * (1 - (_percentage / 100)));
    CGFloat endY = (self.frame.size.height * (1 - value));
    [path moveToPoint:CGPointMake(startX, startY)];
	[path addLineToPoint:CGPointMake(startX, endY)];
    return path;
}

- (CAShapeLayer *)_layerWithPath:(UIBezierPath *)path {
    CAShapeLayer *item = [CAShapeLayer layer];
    item.fillColor = [[UIColor blackColor] CGColor];
    item.lineCap = kCALineCapButt;
    item.lineWidth = self.frame.size.width;
    item.path = path.CGPath;
    item.strokeColor = [self.foregroundColor CGColor];
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

- (void)setForegroundColor:(UIColor *)foregroundColor {
    _foregroundColor = foregroundColor;

    self.layer.sublayers = nil;
    CGFloat temp = _percentage;
    [self setPercentage:0 animated:NO];
    [self setPercentage:temp animated:NO];
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
    self.percentage = 0;
}

@end
