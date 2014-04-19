//
//  BarGraphView.m
//  GraphKit
//
//  Created by Michal Konturek on 16/04/2014.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import "BarGraphView.h"

#import <FrameAccessor/FrameAccessor.h>

#import "GKBar.h"

//#define CGRectSetX(frame, w)    CGRectMake(w, frame.origin.y, frame.size.width, frame.size.height)
//#define ViewSetX(view, w)       view.frame = CGRectSetX(view.frame, w)

@implementation BarGraphView

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
//    self.backgroundColor = [UIColor clearColor];
}

- (void)draw {
//    CGFloat height = self.frame.size.height;
    
    static CGFloat barHeight = 100;
    CGFloat x = 20;
    CGFloat y = self.frame.size.height - barHeight;
    for (id value in self.values) {
        GKBar *bar = [GKBar createWithFrame:CGRectMake(x, y, 20, barHeight)];
        bar.percentage = [value doubleValue];
        [self addSubview:bar];
        x += 30;
    }
}

//- (void)_layoutBars {
//    CGFloat margin = 30;
//    
//    
//}

- (void)reset {
    for (id bar in self.subviews) {
        if ([bar isMemberOfClass:[GKBar class]]) continue;
        [bar reset];
    }
}

@end
