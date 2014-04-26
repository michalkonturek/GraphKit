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

@property (nonatomic, assign) BOOL animated;
@property (nonatomic, assign) CFTimeInterval animationDuration;

@property (nonatomic, assign) id<GKBarGraphDataSource> dataSource;

@property (nonatomic, strong) NSArray *bars;
@property (nonatomic, strong) NSArray *labels;
@property (nonatomic, strong) UIColor *barColor;

@property (nonatomic, assign) CGFloat barHeight;
@property (nonatomic, assign) CGFloat barWidth;
@property (nonatomic, assign) CGFloat marginBar;

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
- (NSString *)titleForBarAtIndex:(NSInteger)index;

@end
