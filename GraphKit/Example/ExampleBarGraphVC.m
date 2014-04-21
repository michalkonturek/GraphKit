//
//  BarGraphViewVC.m
//  GraphKit
//
//  Created by Michal Konturek on 17/04/2014.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import "ExampleBarGraphVC.h"

@interface ExampleBarGraphVC ()

@property (nonatomic, assign) BOOL green;

@end

@implementation ExampleBarGraphVC

- (void)viewDidLoad {
    [super viewDidLoad];

    id values = @[@10, @25, @40, @60, @85, @100];
    self.graphView.values = values;
    
    self.graphView.barWidth = 22;
    self.graphView.barHeight = 140;
    self.graphView.marginBar = 20;

    [[self.graphView construct] draw];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onButtonFill:(id)sender {
    [self.graphView draw];
}

- (IBAction)onButtonChange:(id)sender {
    self.green = !self.green;
    self.graphView.barColor = (self.green) ? [UIColor greenColor] : [UIColor redColor];
}

- (IBAction)onButtonReset:(id)sender {
    [self.graphView reset];
}

@end
