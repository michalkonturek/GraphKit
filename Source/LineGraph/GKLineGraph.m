//
//  GKLineGraph.m
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

#import "GKLineGraph.h"

#import <FrameAccessor/FrameAccessor.h>
#import <MKFoundationKit/NSArray+MK.h>

static CGFloat kDefaultLabelWidth = 40.0;
static CGFloat kDefaultLabelHeight = 12.0;
static NSInteger kDefaultValueLabelCount = 5;

static NSInteger kCoordinateLayerIndexTag = -1;
static CGFloat kDefaultTouchDistanceThreshold = 5.0;

static CGFloat kDefaultLineWidth = 3.0;
static CGFloat kDefaultMargin = 10.0;
static CGFloat kDefaultMarginBottom = 20.0;

static CGFloat kAxisMargin = 50.0;

@interface GKLineGraph ()

@property (nonatomic, strong) NSArray *titleLabels;
@property (nonatomic, strong) NSArray *valueLabels;

@property (nonatomic, strong) GKLineDataPoint *selectedDataPoint;

@end

@implementation GKLineGraph

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
    self.animated = YES;
    self.animationDuration = 1;
    self.lineWidth = kDefaultLineWidth;
    self.margin = kDefaultMargin;
    self.valueLabelCount = kDefaultValueLabelCount;
    self.clipsToBounds = YES;
    self.selectedDataPoint = [GKLineDataPoint new];
    self.touchDistanceThreshold = kDefaultTouchDistanceThreshold;
    self.coordinateSystemColor = [UIColor darkGrayColor];
    self.gridLinesColor = [UIColor lightGrayColor];
    self.labelTextColor = [UIColor darkGrayColor];
}

- (void)draw {
    NSAssert(self.dataSource, @"GKLineGraph : No data source is assgined.");
    
    if ([self _hasTitleLabels]) [self _removeTitleLabels];
    [self _constructTitleLabels];
    [self _positionTitleLabels];

    if ([self _hasValueLabels]) [self _removeValueLabels];
    [self _constructValueLabels];
    
    [self _drawLines];
}

- (void) setTouchDistanceThreshold:(NSInteger)touchDistanceThreshold
{
    _touchDistanceThreshold = touchDistanceThreshold * [[UIScreen mainScreen] scale];
}

- (BOOL)_hasTitleLabels {
    return ![self.titleLabels mk_isEmpty];
}

- (BOOL)_hasValueLabels {
    return ![self.valueLabels mk_isEmpty];
}

- (void)_constructTitleLabels {
    
    NSInteger count = [[self.dataSource valuesForLineAtIndex:0] count];
    id items = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger idx = 0; idx < count; idx++) {
        
        CGRect frame = CGRectMake(0, 0, kDefaultLabelWidth, kDefaultLabelHeight);
        UILabel *item = [[UILabel alloc] initWithFrame:frame];
        item.textAlignment = NSTextAlignmentCenter;
        item.font = [UIFont boldSystemFontOfSize:12];
        item.textColor = _labelTextColor;
        item.text = [self.dataSource titleForLineAtIndex:idx];
        
        [items addObject:item];
    }
    self.titleLabels = items;
}

- (void)_removeTitleLabels {
    [self.titleLabels mk_each:^(id item) {
        [item removeFromSuperview];
    }];
    self.titleLabels = nil;
}

- (void)_positionTitleLabels {
    
    __block NSInteger idx = 0;
    id values = [self.dataSource valuesForLineAtIndex:0];
    [values mk_each:^(id value) {
        
        CGFloat labelWidth = kDefaultLabelWidth;
        CGFloat labelHeight = kDefaultLabelHeight;
        CGFloat startX = [self _pointXForIndex:idx] - (labelWidth / 2);
        CGFloat startY = (self.height - labelHeight);
        
        UILabel *label = [self.titleLabels objectAtIndex:idx];
        label.x = startX;
        label.y = startY;
        
        [self addSubview:label];

        idx++;
    }];
}

- (CGFloat)_pointXForIndex:(float)index {
    return kAxisMargin + self.margin + (index * [self _stepX]);
}

- (CGFloat)_indexForPointX:(float)pointX {
    CGFloat index = (pointX - kAxisMargin - self.margin) / [self _stepX];
    return roundf(index);
}

- (CGFloat)_stepX {
    id values = [self.dataSource valuesForLineAtIndex:0];
    CGFloat result = ([self _plotWidth] / [values count]);
    return result;
}

- (void)_constructValueLabels {
    
    NSInteger count = self.valueLabelCount;
    id items = [NSMutableArray arrayWithCapacity:count];
    
    for (NSInteger idx = 0; idx < count; idx++) {
        
        CGRect frame = CGRectMake(0, 0, kDefaultLabelWidth, kDefaultLabelHeight);
        UILabel *item = [[UILabel alloc] initWithFrame:frame];
        item.textAlignment = NSTextAlignmentRight;
        item.font = [UIFont boldSystemFontOfSize:12];
        item.textColor = [UIColor lightGrayColor];
    
        CGFloat value = [self _minValue] + (idx * [self _stepValueLabelY]);
        item.centerY = [self _positionYForLineValue:value];
        
        item.text = [@(ceil(value)) stringValue];
//        item.text = [@(value) stringValue];
        
        [items addObject:item];
        [self addSubview:item];
    }
    self.valueLabels = items;
}

- (CGFloat)_stepValueLabelY {
    return (([self _maxValue] - [self _minValue]) / (self.valueLabelCount - 1));
}

- (CGFloat)_maxValue {
    id values = [self _allValues];
    float realMaxValue = [[values mk_max] floatValue];
    
    return (_ensureXAxisVisibility ? MAX (0, realMaxValue) : realMaxValue);
}

- (CGFloat)_minValue {
    if (self.startFromZero) return 0;
    id values = [self _allValues];
    
    float realMinValue = [[values mk_min] floatValue];
    return (_ensureXAxisVisibility ? MIN (0, realMinValue) : realMinValue);
}

- (NSArray *)_allValues {
    NSInteger count = [self.dataSource numberOfLines];
    id values = [NSMutableArray array];
    for (NSInteger idx = 0; idx < count; idx++) {
        id item = [self.dataSource valuesForLineAtIndex:idx];
        [values addObjectsFromArray:item];
    }
    return values;
}

- (void)_removeValueLabels {
    [self.valueLabels mk_each:^(id item) {
        [item removeFromSuperview];
    }];
    self.valueLabels = nil;
}

- (CGFloat)_plotWidth {
    return (self.width - (2 * self.margin) - kAxisMargin);
}

- (CGFloat)_plotHeight {
    return (self.height - (2 * kDefaultLabelHeight + kDefaultMarginBottom));
}

- (void)_drawLines {
    NSInteger numValues = 0;
    for (NSInteger idx = 0; idx < [self.dataSource numberOfLines]; idx++) {
        numValues = MAX(numValues, [[self.dataSource valuesForLineAtIndex:idx] count]);

        [self _drawLineAtIndex:idx];
    }
    
    if (self.drawVerticalGridLines)
    {
        [self _drawVerticalGridLines:numValues];
    }
    if (self.drawHorizontalGridLines)
    {
        [self _drawHorizontalGridLines:numValues];
    }
    if (self.drawCoordinateSystem)
    {
        [self _drawCoordinateSystem:numValues];
    }
}

- (void)_drawHorizontalGridLines:(NSInteger) indexCount {
    UIGraphicsBeginImageContext(self.frame.size);
    
    UIBezierPath *path = [self _bezierPathWith:0];
    CAShapeLayer *layer = [self _layerWithPath:path];
    [layer setValue:[NSNumber numberWithInteger:kCoordinateLayerIndexTag] forKey:@"indexTag"];
    layer.strokeColor = [_gridLinesColor CGColor];
    layer.lineWidth = MAX (1,self.lineWidth/2);
    NSArray *dashPattern = [NSArray arrayWithObjects:[NSDecimalNumber numberWithInt:2],[NSDecimalNumber numberWithInt:2],nil];
    [layer setLineDashPattern:dashPattern];
    
    [self.layer addSublayer:layer];
    
    NSInteger count = self.valueLabelCount;
    for (NSInteger idx = 0; idx < count; idx++)
    {
        UILabel *label = [self.valueLabels objectAtIndex:idx];
        CGFloat yCoordinate = label.frame.origin.y + (label.frame.size.height / 2);
        // NSLog(@"yValue: %f", yValue);

        [path moveToPoint:CGPointMake([self _pointXForIndex:0], yCoordinate)];
        [path addLineToPoint:CGPointMake([self _pointXForIndex:0], yCoordinate)];
        [path addLineToPoint:CGPointMake([self _pointXForIndex:indexCount], yCoordinate)];
    }
    
    layer.path = path.CGPath;
    
    if (self.animated) {
        CABasicAnimation *animation = [self _animationWithKeyPath:@"strokeEnd"];
        if ([self.dataSource respondsToSelector:@selector(animationDurationForLineAtIndex:)]) {
            animation.duration = [self.dataSource animationDurationForLineAtIndex:0];
        }
        [layer addAnimation:animation forKey:@"strokeEndAnimation"];
    }
    
    UIGraphicsEndImageContext();
}

- (void)_drawVerticalGridLines:(NSInteger) indexCount {
    UIGraphicsBeginImageContext(self.frame.size);
    
    UIBezierPath *path = [self _bezierPathWith:0];
    CAShapeLayer *layer = [self _layerWithPath:path];
    [layer setValue:[NSNumber numberWithInteger:kCoordinateLayerIndexTag] forKey:@"indexTag"];
    layer.strokeColor = [_gridLinesColor CGColor];
    layer.lineWidth = MAX (1,self.lineWidth/2);
    NSArray *dashPattern = [NSArray arrayWithObjects:[NSDecimalNumber numberWithInt:2],[NSDecimalNumber numberWithInt:2],nil];
    [layer setLineDashPattern:dashPattern];
    
    [self.layer addSublayer:layer];
    
    for (int step = 1; step < indexCount; step++)
    {
        [path moveToPoint:CGPointMake([self _pointXForIndex:step], [self _positionYForLineValue:[self _maxValue]])];
        [path addLineToPoint:CGPointMake([self _pointXForIndex:step], [self _positionYForLineValue:[self _maxValue]])];
        [path addLineToPoint:CGPointMake([self _pointXForIndex:step], [self _positionYForLineValue:[self _minValue]])];
        // bezierPath.lineJoinStyle = kCGLineJoinRound;
    }
    
    layer.path = path.CGPath;
    
    if (self.animated) {
        CABasicAnimation *animation = [self _animationWithKeyPath:@"strokeEnd"];
        if ([self.dataSource respondsToSelector:@selector(animationDurationForLineAtIndex:)]) {
            animation.duration = [self.dataSource animationDurationForLineAtIndex:0];
        }
        [layer addAnimation:animation forKey:@"strokeEndAnimation"];
    }
    
    UIGraphicsEndImageContext();
}

- (void)_drawCoordinateSystem:(NSInteger) indexCount {
    // http://stackoverflow.com/questions/19599266/invalid-context-0x0-under-ios-7-0-and-system-degradation
    UIGraphicsBeginImageContext(self.frame.size);
    
    UIBezierPath *path = [self _bezierPathWith:0];
    CAShapeLayer *layer = [self _layerWithPath:path];
    [layer setValue:[NSNumber numberWithInteger:kCoordinateLayerIndexTag] forKey:@"indexTag"];
    
    layer.strokeColor = [_coordinateSystemColor CGColor];
    
    [self.layer addSublayer:layer];
    
    // Draw y Coordinate Line
    CGFloat x = [self _pointXForIndex:0];
    CGFloat y = [self _positionYForLineValue:[self _minValue]];
    CGPoint point = CGPointMake(x, y);

    [path moveToPoint:point];
    [path addLineToPoint:point];
    
    x = [self _pointXForIndex:0];
    y = [self _positionYForLineValue:[self _maxValue]];
    point = CGPointMake(x, y);
    
    [path addLineToPoint:point];
    
    // Draw x Coordinate Line
    x = [self _pointXForIndex:0];
    y = [self _positionYForLineValue:0.0];
    point = CGPointMake(x, y);
    
    [path moveToPoint:point];
    [path addLineToPoint:point];

    x = [self _pointXForIndex:indexCount];
    point = CGPointMake(x, y);
    
    [path addLineToPoint:point];

    // Draw x Copordinate Caps
    float maxCapValue = 0.03125 * MAX([self _maxValue], fabs([self _minValue]));
    float minCapValue = -1 * maxCapValue;

    for (int step = 1; step < indexCount; step++)
    {
        [path moveToPoint:CGPointMake([self _pointXForIndex:step], [self _positionYForLineValue:maxCapValue])];
        [path addLineToPoint:CGPointMake([self _pointXForIndex:step], [self _positionYForLineValue:maxCapValue])];
        [path addLineToPoint:CGPointMake([self _pointXForIndex:step], [self _positionYForLineValue:minCapValue])];
        // bezierPath.lineJoinStyle = kCGLineJoinRound;
    }
    
    layer.path = path.CGPath;
    
    if (self.animated) {
        CABasicAnimation *animation = [self _animationWithKeyPath:@"strokeEnd"];
        if ([self.dataSource respondsToSelector:@selector(animationDurationForLineAtIndex:)]) {
            animation.duration = [self.dataSource animationDurationForLineAtIndex:0];
        }
        [layer addAnimation:animation forKey:@"strokeEndAnimation"];
    }
    
    UIGraphicsEndImageContext();
}

- (void)_drawLineAtIndex:(NSInteger)index {
    
    // http://stackoverflow.com/questions/19599266/invalid-context-0x0-under-ios-7-0-and-system-degradation
    UIGraphicsBeginImageContext(self.frame.size);
    
    UIBezierPath *path = [self _bezierPathWith:0];
    CAShapeLayer *layer = [self _layerWithPath:path];
    
    if ([_dataSource respondsToSelector:@selector(dashPatternForLineAtIndex:)])
    {
        NSArray *dashPattern = [self.dataSource dashPatternForLineAtIndex:index];
        [layer setLineDashPattern:dashPattern];
    }
    
    [layer setValue:[NSNumber numberWithInteger:index] forKey:@"indexTag"];
    
    layer.strokeColor = [[self.dataSource colorForLineAtIndex:index] CGColor];
    
    [self.layer addSublayer:layer];
    
    NSInteger idx = 0;
    id values = [self.dataSource valuesForLineAtIndex:index];
    for (id item in values) {

        CGFloat x = [self _pointXForIndex:idx];
        CGFloat y = [self _positionYForLineValue:[item floatValue]];
        CGPoint point = CGPointMake(x, y);
        
        // NSLog (@"Value %f at Point for Layer %i at Index %i: - %f/%f", [item floatValue], index, idx, point.x, point.y);
        
        if (idx != 0) [path addLineToPoint:point];
        [path moveToPoint:point];
        
        idx++;
    }
    
    layer.path = path.CGPath;
    
    if (self.animated) {
        CABasicAnimation *animation = [self _animationWithKeyPath:@"strokeEnd"];
        if ([self.dataSource respondsToSelector:@selector(animationDurationForLineAtIndex:)]) {
            animation.duration = [self.dataSource animationDurationForLineAtIndex:index];
        }
        [layer addAnimation:animation forKey:@"strokeEndAnimation"];
    }
    
    UIGraphicsEndImageContext();
}

- (CGFloat)_positionYForLineValue:(CGFloat)value {
    CGFloat scale = (value - [self _minValue]) / ([self _maxValue] - [self _minValue]);
    CGFloat result = [self _plotHeight] * scale;
    result = ([self _plotHeight] - result);
    result += kDefaultLabelHeight;
    return result;
}

- (UIBezierPath *)_bezierPathWith:(CGFloat)value {
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineWidth = self.lineWidth;
    return path;
}

- (CAShapeLayer *)_layerWithPath:(UIBezierPath *)path {
    CAShapeLayer *item = [CAShapeLayer layer];
    item.fillColor = [[UIColor blackColor] CGColor];
    item.lineCap = kCALineCapRound;
    item.lineJoin  = kCALineJoinRound;
    item.lineWidth = self.lineWidth;
//    item.strokeColor = [self.foregroundColor CGColor];
    item.strokeColor = [[UIColor redColor] CGColor];
    item.strokeEnd = 1;
    return item;
}

- (CABasicAnimation *)_animationWithKeyPath:(NSString *)keyPath {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = self.animationDuration;
    animation.fromValue = @(0);
    animation.toValue = @(1);
//    animation.delegate = self;
    return animation;
}

- (void)reset {
    self.layer.sublayers = nil;
    [self _removeTitleLabels];
    [self _removeValueLabels];
    self.selectedDataPoint = [GKLineDataPoint new];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesMoved:touches withEvent:event];
}

void processPathElement(void* info, const CGPathElement* element)
{
    CGPoint pointArg = element->points[0];
    CGFloat distance = 0;
    
    if (element->type == kCGPathElementMoveToPoint)
    {
        NSMutableDictionary *theDict = (__bridge NSMutableDictionary *) info;
    
        NSValue *pointValue = theDict[@"thePoint"];
        CGPoint touchedPoint = [pointValue CGPointValue];

        CGFloat xDist = (touchedPoint.x - pointArg.x);
        CGFloat yDist = (touchedPoint.y - pointArg.y);
        distance = sqrt((xDist * xDist) + (yDist * yDist));
        
        NSNumber *thresholdNumber = (NSNumber*)theDict[@"touchThreshold"];
        NSInteger touchDistanceThreshold = [thresholdNumber integerValue];

        if (distance <= touchDistanceThreshold)
        {
            theDict[@"pointOnPath"] = [NSNumber numberWithBool:YES];
        }
        
        // NSLog(@"Type: %u || Point: %@ || Distance: %f", element->type, NSStringFromCGPoint(pointArg), distance);
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    NSArray *subLayers = self.layer.sublayers;
    
    // NSLog (@"Point: %f/%f", point.x, point.y);
    
    NSMutableDictionary *dict = [@{ @"thePoint" : [NSValue valueWithCGPoint:point] } mutableCopy];
    dict[@"pointOnPath"] = [NSNumber numberWithBool:NO];
    dict[@"touchThreshold"] = [NSNumber numberWithInteger:_touchDistanceThreshold];
    
    GKLineDataPoint *selectedDataPoint = [GKLineDataPoint new];
    
    [subLayers enumerateObjectsUsingBlock:^(id obj, NSUInteger index, BOOL *stop)
    {
        // CALayer *layer = (CALayer *) obj;
        // NSLog (@"Layer: %@", NSStringFromClass([layer class]));
        
        if ([obj isKindOfClass:[CAShapeLayer class]])
        {
            CAShapeLayer *shapeLayer = (CAShapeLayer *) obj;
            NSNumber *lineIndexNumber = [shapeLayer valueForKey:@"indexTag"];
            NSInteger lineIndex = [lineIndexNumber integerValue];
            
            if ((lineIndexNumber != nil) && (lineIndex > -1))
            {
                CGPathRef path = [shapeLayer path];

                CGPathApply(path, (__bridge void *)(dict), processPathElement);

                // if (CGPathContainsPoint(path, nil, point, YES)) {
                NSNumber *didTouchNumber = dict[@"pointOnPath"];
                BOOL didTouchPoint = [didTouchNumber boolValue];

                if (didTouchPoint)
                {
                    // NSLog (@"Touch detected on Point at Shape Index: %i", indexTag);
                    NSInteger valueIndex =  [self _indexForPointX:point.x]; // [valueIndexNumber integerValue];
                    // NSLog (@"Touch detected on Point at Shape Index: %i", valueIndex);
                    
                    selectedDataPoint.lineIndex = lineIndex;
                    selectedDataPoint.valueIndex = valueIndex;
                    *stop = YES;
                }
            }
        }
    }];
    
    [self maybeNotifyDelegateOfSelectionChangeFrom:_selectedDataPoint to:selectedDataPoint AtPoint:point];
}

- (void)maybeNotifyDelegateOfSelectionChangeFrom:(GKLineDataPoint *)previousSelection to:(GKLineDataPoint *)newSelection AtPoint:(CGPoint) targetPoint
{
    if (![previousSelection isEqual:newSelection])
    {
        if (![previousSelection isEmptyDataPoint])
        {
            [_delegate lineGraph:self willDeselectDataPoint:previousSelection AtPoint:targetPoint];
        }

        _selectedDataPoint = newSelection;

        if (![newSelection isEmptyDataPoint])
        {
            [_delegate lineGraph:self willSelectDataPoint:newSelection AtPoint:targetPoint];

            if (![previousSelection isEmptyDataPoint])
            {
                [_delegate lineGraph:self didDeselectDataPoint:previousSelection AtPoint:targetPoint];
            }
            
            [_delegate lineGraph:self didSelectDataPoint:newSelection AtPoint:targetPoint];
        } else {
            if (![previousSelection isEmptyDataPoint])
            {
                [_delegate lineGraph:self didDeselectDataPoint:previousSelection AtPoint:targetPoint];
            }
        }
    } else
    {
        [_delegate lineGraph:self didReselectDataPoint:previousSelection AtPoint:targetPoint];
    }
}

@end
