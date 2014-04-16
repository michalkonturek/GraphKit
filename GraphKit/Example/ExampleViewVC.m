//
//  ExampleViewVC.m
//  GraphKit
//
//  Created by Michal Konturek on 16/04/2014.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import "ExampleViewVC.h"

#import "GKBar.h"

@interface ExampleViewVC ()

@end

@implementation ExampleViewVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.bar.percentage = @40;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onButtonApply:(id)sender {
//    self.bar.percentage = @60;
    [self.bar reset];
}

@end
