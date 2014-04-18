//
//  BarGraphViewVC.m
//  GraphKit
//
//  Created by Michal Konturek on 17/04/2014.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import "BarGraphViewVC.h"

@interface BarGraphViewVC ()

@end

@implementation BarGraphViewVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.graphView.values = @[@0.1, @0.2, @0.3, @0.4, @0.5, @0.6, @0.7, @0.8, @0.9, @1];
    [self.graphView draw];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
