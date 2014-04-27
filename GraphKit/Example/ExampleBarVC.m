//
//  ExampleViewVC.m
//  GraphKit
//
//  Created by Michal Konturek on 16/04/2014.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import "ExampleBarVC.h"

#import "GraphKit.h"

#import "UIViewController+BButton.h"

@interface ExampleBarVC ()

@property (nonatomic, assign) BOOL green;

@end

@implementation ExampleBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self setupButtons];
    
    self.view.backgroundColor = [UIColor gk_cloudsColor];

    self.bar.animationDuration = 0.4;
    self.bar.percentage = 40;
    
    self.green = YES;
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
    self.bar.foregroundColor = (self.green) ? [UIColor gk_turquoiseColor] : [UIColor gk_amethystColor];;
}

- (IBAction)onButtonReset:(id)sender {
    [self.bar reset];
}

@end
