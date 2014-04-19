//
//  GKBar.m
//  GraphKit
//
//  Created by Michal Konturek on 16/04/2014.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import "GKBar.h"

#import <QuartzCore/QuartzCore.h>

@implementation GKBar

//@synthesize foregroundColor = _foregroundColor;

+ (instancetype)create {
    CGRect defaultRect = CGRectMake(0, 0, 25, 100);
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
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 2.0;
    self.backgroundColor = [UIColor lightGrayColor];
    self.foregroundColor = [UIColor redColor];
    _percentage = 0;
    _animated = YES;
    _animationDuration = 0.8;
}

- (void)setPercentage:(CGFloat)percentage animated:(BOOL)animated {
    self.animated = animated;
    self.percentage = percentage;
}

- (void)setPercentage:(CGFloat)percentage {
    if (percentage == _percentage) return;
    if (percentage > 1) percentage = 1;
    if (percentage < 0) percentage = 0;
    
    [self _progressBarTo:percentage];
    _percentage = percentage;
}

- (void)_progressBarTo:(CGFloat)value {
    
    UIBezierPath *path = [self _bezierPathWith:value];
//    NSLog(@"S: %f E: %f", startY, endY);
    
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
    CGFloat startY = (self.frame.size.height * (1 - _percentage));
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
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = self.animationDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fromValue = @(0);
    animation.toValue = @(1);
    return animation;
}

- (void)setForegroundColor:(UIColor *)foregroundColor {
    _foregroundColor = foregroundColor;
    
    for (CAShapeLayer *item in self.layer.sublayers) {
        item.strokeColor = [_foregroundColor CGColor];
    }
    
    
}

//- (UIColor *)foregroundColor {
//    NSLog(@"%@", _foregroundColor);
//    return _foregroundColor;
//}

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
