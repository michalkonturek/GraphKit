//
//  ExampleViewVC.m
//  GraphKit
//
//  Created by Michal Konturek on 16/04/2014.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import "ExampleBarVC.h"

#import "GKBar.h"

@interface ExampleBarVC ()

@property (nonatomic, assign) BOOL green;

@end

@implementation ExampleBarVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.bar.animationDuration = 0.4;
    self.bar.percentage = 40;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onButtonAdd:(id)sender {
    self.bar.animated = YES;
    self.bar.percentage += 20;
}

- (IBAction)onButtonMinus:(id)sender {
    self.bar.percentage -= 20;
}

- (IBAction)onButtonChange:(id)sender {
    self.green = !self.green;
    self.bar.foregroundColor = (self.green) ? [UIColor greenColor] : [UIColor redColor];;
}

- (IBAction)onButtonReset:(id)sender {
    [self.bar reset];
    self.bar.cornerRadius = 0;
}

@end
