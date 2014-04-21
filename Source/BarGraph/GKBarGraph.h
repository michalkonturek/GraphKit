//
//  GKBarGraph.h
//  GraphKit
//
//  Created by Michal Konturek on 16/04/2014.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GKBarGraph : UIView

@property (nonatomic, assign) id dataSource;

@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) NSArray *labels;
@property (nonatomic, strong) NSArray *values;

@property (nonatomic, strong) NSArray *bars;

@property (nonatomic, assign) CGFloat barHeight;
@property (nonatomic, assign) CGFloat barWidth;
@property (nonatomic, assign) CGFloat marginBar;

@property (nonatomic, strong) UIColor *barColor;

@property (nonatomic, assign) BOOL animated;
@property (nonatomic, assign) CFTimeInterval animationDuration;

- (instancetype)redraw;
- (instancetype)construct;
- (instancetype)draw;

- (instancetype)reset;

@end

