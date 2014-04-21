//
//  UIViewController+BButton.m
//  GraphKit
//
//  Created by Michal Konturek on 21/04/2014.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import "UIViewController+BButton.h"

#import <MKFoundationKit/NSArray+MK.h>
#import <BButton/BButton.h>

@implementation UIViewController (BButton)

- (void)setupButtons {
    [[self.view.subviews mk_select:^BOOL(id item) {
        return [item isMemberOfClass:[BButton class]];
    }] mk_each:^(BButton *item) {
        [item setType:BButtonTypePrimary];
    }];
}

@end
