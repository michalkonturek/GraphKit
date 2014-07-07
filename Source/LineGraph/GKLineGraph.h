//
//  GKLineGraph.h
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

#import <UIKit/UIKit.h>
#import "GKLineDataPoint.h"

@protocol GKLineGraphDataSource;
@protocol GKLineGraphDelegate;

@interface GKLineGraph : UIView

@property (nonatomic, assign) BOOL animated;
@property (nonatomic, assign) CFTimeInterval animationDuration;

@property (nonatomic, weak, readwrite) id <GKLineGraphDelegate> delegate;
@property (nonatomic, assign) id<GKLineGraphDataSource> dataSource;

@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat margin;

@property (nonatomic, assign) NSInteger valueLabelCount;

@property (nonatomic, assign) CGFloat *minValue;
@property (nonatomic, assign) BOOL startFromZero;
@property (nonatomic, assign) BOOL ensureXAxisVisibility;
@property (nonatomic, assign) BOOL drawCoordinateSystem;
@property (nonatomic, assign) BOOL drawVerticalGridLines;
@property (nonatomic, assign) BOOL drawHorizontalGridLines;
@property (nonatomic, assign) NSInteger touchDistanceThreshold;
@property (nonatomic, assign) BOOL drawXAxisLabelsAtAxis;

@property (nonatomic, strong) UIColor *coordinateSystemColor;
@property (nonatomic, strong) UIColor *gridLinesColor;
@property (nonatomic, strong) UIColor *labelTextColor;

- (void)draw;
- (void)reset;

@end

@protocol GKLineGraphDataSource <NSObject>

- (NSInteger) numberOfLines;
- (UIColor *) colorForLineAtIndex: (NSInteger)index;
- (NSArray *) valuesForLineAtIndex: (NSInteger)index;

@optional

- (CFTimeInterval) animationDurationForLineAtIndex:(NSInteger)index;
- (NSString *) titleForLineAtIndex:(NSInteger)index;
- (NSString *) identifierForLineAtIndex:(NSInteger)index;
- (NSArray *) dashPatternForLineAtIndex: (NSInteger)index;

@end

@protocol GKLineGraphDelegate <NSObject>

- (void)lineGraph:(GKLineGraph *)lineGraph willSelectDataPoint:(GKLineDataPoint *)dataPoint AtPoint:(CGPoint) targetPoint;
- (void)lineGraph:(GKLineGraph *)lineGraph didSelectDataPoint:(GKLineDataPoint *)dataPoint AtPoint:(CGPoint) targetPoint;
- (void)lineGraph:(GKLineGraph *)lineGraph willDeselectDataPoint:(GKLineDataPoint *)dataPoint AtPoint:(CGPoint) targetPoint;
- (void)lineGraph:(GKLineGraph *)lineGraph didDeselectDataPoint:(GKLineDataPoint *)dataPoint AtPoint:(CGPoint) targetPoint;
- (void)lineGraph:(GKLineGraph *)lineGraph didReselectDataPoint:(GKLineDataPoint *)dataPoint AtPoint:(CGPoint) targetPoint;

@end
