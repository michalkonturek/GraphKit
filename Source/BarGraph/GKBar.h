//
//  GKBar.h
//  GraphKit
//
//  Created by Michal Konturek on 16/04/2014.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GKBar : UIView

@property (nonatomic, assign) CGFloat percentage;
@property (nonatomic, strong) UIColor *foregroundColor;

- (void)reset;

@end
