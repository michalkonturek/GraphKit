//
//  GKBar.m
//  GraphKit
//
//  Created by Michal Konturek on 16/04/2014.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import "GKBar.h"

#import <QuartzCore/QuartzCore.h>

@interface GKBar ()

@property (nonatomic, strong) CAShapeLayer *fillLayer;

@end

@implementation GKBar

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
    [self _initLayer];
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 2.0;
    self.backgroundColor = [UIColor lightGrayColor];
    self.foregroundColor = [UIColor redColor];
    _percentage = 0;
}

- (void)_initLayer {
    _fillLayer = [CAShapeLayer layer];
    _fillLayer.fillColor = [[UIColor blackColor] CGColor];
    _fillLayer.lineCap = kCALineCapButt;
    _fillLayer.lineWidth = self.frame.size.width;
//    _fillLayer.strokeEnd = 0.0;
    [self.layer addSublayer:_fillLayer];
}

- (void)setPercentage:(CGFloat)percentage {
    
    [self _drawTo:percentage];
    
    _percentage = percentage;
}

- (void)_drawTo:(CGFloat)value {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat startX = (self.frame.size.width / 2);
    CGFloat startY = self.frame.size.height;
    
    [path moveToPoint:CGPointMake(startX, startY)];
    
    CGFloat endY = startY * (1 - value);
	[path addLineToPoint:CGPointMake(startX, endY)];
    
    id animation = [self _animationWithKeyPath:@"strokeEnd"];
    
    self.fillLayer.path = path.CGPath;
    self.fillLayer.strokeEnd = 1.0;
    [self.fillLayer addAnimation:animation forKey:@"strokeEndAnimation"];
    
//    NSLog(@"%@", self.fillLayer.animationKeys);
}

- (CABasicAnimation *)_animationWithKeyPath:(NSString *)keyPath {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fromValue = @(0);
    animation.toValue = @(1);
    return animation;
}

- (void)setForegroundColor:(UIColor *)foregroundColor {
    _foregroundColor = foregroundColor;
    self.fillLayer.strokeColor = [_foregroundColor CGColor];
}

- (void)reset {
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _fillLayer.strokeColor = [UIColor clearColor].CGColor;
                     } completion:^(BOOL finished) {
                         self.layer.sublayers = nil;
                     }];
}

@end
