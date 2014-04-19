//
//  ViewFrameAccessor.h
//  ViewFrameAccessor
//
//  Created by Alex Denisov on 18.03.12.
//  Copyright (c) 2013 okolodev.org. All rights reserved.
//


#define IS_IOS_DEVICE (TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE)

#if IS_IOS_DEVICE
    #import <UIKit/UIKit.h>
    #define View UIView
#else
    #import <Foundation/Foundation.h>
    #define View NSView
#endif


@interface View (FrameAccessor)

// Frame
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;

// Frame Origin
@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;

// Frame Size
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

// Frame Borders
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat right;

// Center Point
#if !IS_IOS_DEVICE
@property (nonatomic) CGPoint center;
#endif
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

// Middle Point
@property (nonatomic, readonly) CGPoint middlePoint;
@property (nonatomic, readonly) CGFloat middleX;
@property (nonatomic, readonly) CGFloat middleY;

@end