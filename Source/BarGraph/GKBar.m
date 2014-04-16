//
//  GKBar.m
//  GraphKit
//
//  Created by Michal Konturek on 16/04/2014.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import "GKBar.h"

#import <QuartzCore/QuartzCore.h>

//@interface GKBar ()
//
////@property (nonatomic, strong) CAShapeLayer *fillLayer;
//
//@end

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
//    [self _initLayer];
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 2.0;
    self.backgroundColor = [UIColor lightGrayColor];
    self.foregroundColor = [UIColor redColor];
    _percentage = 0;
}

//- (void)_initLayer {
//    _fillLayer = [CAShapeLayer layer];
//    _fillLayer.fillColor = [[UIColor blackColor] CGColor];
//    _fillLayer.lineCap = kCALineCapButt;
//    _fillLayer.lineWidth = self.frame.size.width;
////    _fillLayer.strokeEnd = 0.0;
//    [self.layer addSublayer:_fillLayer];
//}

- (void)setPercentage:(CGFloat)percentage {
    if (percentage > 1) percentage = 1;
    if (percentage < 0) percentage = 0;
    
    [self _drawTo:percentage];
    
    _percentage = percentage;
}

- (void)_drawTo:(CGFloat)value {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat startX = (self.frame.size.width / 2);
    CGFloat startY = (self.frame.size.height * (1 - _percentage));
    
    [path moveToPoint:CGPointMake(startX, startY)];
    
    CGFloat endY = (self.frame.size.height * (1 - value));
    
	[path addLineToPoint:CGPointMake(startX, endY)];
    NSLog(@"S: %f E: %f", startY, endY);
    
    id animation = [self _animationWithKeyPath:@"strokeEnd"];
    
    CAShapeLayer *layer = [self _layer];
    if (_percentage > value) layer.strokeColor = [self.backgroundColor CGColor];
    
    [self.layer addSublayer:layer];
    
    layer.path = path.CGPath;
    layer.strokeEnd = 1.0;
    [layer addAnimation:animation forKey:@"strokeEndAnimation"];
    
//    NSLog(@"%@", self.fillLayer.animationKeys);
}

- (CABasicAnimation *)_animationWithKeyPath:(NSString *)keyPath {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 0.8;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fromValue = @(0);
    animation.toValue = @(1);
    return animation;
}

- (CAShapeLayer *)_layer {
    CAShapeLayer *item = [CAShapeLayer layer];
    item.fillColor = [[UIColor blackColor] CGColor];
    item.strokeColor = [self.foregroundColor CGColor];
    item.lineCap = kCALineCapButt;
    item.lineWidth = self.frame.size.width;
//    _fillLayer.strokeEnd = 0.0;
//    [self.layer addSublayer:_fillLayer];
    return item;
}

- (void)setForegroundColor:(UIColor *)foregroundColor {
    _foregroundColor = foregroundColor;
    
    for (CAShapeLayer *item in self.layer.sublayers) {
        item.strokeColor = [_foregroundColor CGColor];
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
    self.percentage = 0;
}

@end
