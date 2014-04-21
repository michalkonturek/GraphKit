//
//  GKBarGraph.h
//  GraphKit
//
//  Created by Michal Konturek on 16/04/2014.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GKBarGraphDataSource;

@interface GKBarGraph : UIView

//@property (nonatomic, strong) NSArray *colors;
//@property (nonatomic, strong) NSArray *labels;
//@property (nonatomic, strong) NSArray *values;

@property (nonatomic, strong) NSArray *bars;

@property (nonatomic, assign) CGFloat barHeight;
@property (nonatomic, assign) CGFloat barWidth;
@property (nonatomic, assign) CGFloat marginBar;

@property (nonatomic, strong) UIColor *barColor;

@property (nonatomic, assign) BOOL animated;
@property (nonatomic, assign) CFTimeInterval animationDuration;

@property (nonatomic, assign) id<GKBarGraphDataSource> dataSource;

- (instancetype)redraw;
- (instancetype)construct;
- (instancetype)draw;

- (instancetype)reset;

@end

@protocol GKBarGraphDataSource <NSObject>

- (NSInteger)numberOfBars;
- (NSNumber *)valueForBarAtIndex:(NSInteger)index;

@optional
- (UIColor *)colorForBarAtIndex:(NSInteger)index;
- (CFTimeInterval)animationDurationForBarAtIndex:(NSInteger)index;

@end
