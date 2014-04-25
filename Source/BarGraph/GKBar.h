//
//  GKBar.h
//  GraphKit
//
//  Created by Michal Konturek on 16/04/2014.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GKBar : UIView

+ (instancetype)create;
+ (instancetype)createWithFrame:(CGRect)frame;

@property (nonatomic, assign) BOOL animated;
@property (nonatomic, assign) CFTimeInterval animationDuration;

@property (nonatomic, assign) CGFloat percentage;

@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, strong) UIColor *foregroundColor;

- (void)setPercentage:(CGFloat)percentage animated:(BOOL)animated;

- (void)reset;

@end
