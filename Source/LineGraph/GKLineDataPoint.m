//
//  GKLineDataPoint.m
//  GraphKit
//
//  Created by Martin Brandt on 03.07.14.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import "GKLineDataPoint.h"

@implementation GKLineDataPoint

- (instancetype) init {
    self = [super init];
    if (self) {
        [self _init];
    }
    return self;
}

- (void)_init {
    self.lineIndex = -1;
    self.valueIndex = -1;
}

- (BOOL) isEmptyDataPoint
{
    return _lineIndex == -1 && _valueIndex == -1;
}

- (BOOL) isEqual:(GKLineDataPoint *)dataPoint
{
    return _lineIndex == dataPoint.lineIndex && _valueIndex == dataPoint.valueIndex;
}

@end
