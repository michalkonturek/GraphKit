//
//  BarGraphView.h
//  GraphKit
//
//  Created by Michal Konturek on 16/04/2014.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BarGraphView : UIView

@property (nonatomic, assign) id dataSource;

@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) NSArray *labels;
@property (nonatomic, strong) NSArray *values;

@property (nonatomic, strong) NSArray *bars;


@property (nonatomic, assign) CGFloat marginLeft;
@property (nonatomic, assign) CGFloat marginRight;
@property (nonatomic, assign) CGFloat marginBar;

@property (nonatomic, assign) CGFloat barHeight;
@property (nonatomic, assign) CGFloat barWidth;


@property (nonatomic, strong) UIColor *defaultBarColor;

//+ (instancetype)createWithValue

- (void)draw;
- (void)reset;

@end
