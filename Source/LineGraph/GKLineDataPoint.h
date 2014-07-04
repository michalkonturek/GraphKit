//
//  GKLineDataPoint.h
//  GraphKit
//
//  Created by Martin Brandt on 03.07.14.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GKLineDataPoint : NSObject

@property (nonatomic, assign) NSInteger lineIndex;
@property (nonatomic, assign) NSInteger valueIndex;

- (BOOL) isEmptyDataPoint;
- (BOOL) isEqual:(GKLineDataPoint *)dataPoint;

@end
