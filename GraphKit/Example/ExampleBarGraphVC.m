//
//  BarGraphViewVC.m
//  GraphKit
//
//  Created by Michal Konturek on 17/04/2014.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import "ExampleBarGraphVC.h"

@interface ExampleBarGraphVC ()

@end

@implementation ExampleBarGraphVC

- (void)viewDidLoad {
    [super viewDidLoad];

    id values = @[@0.1, @0.3, @0.4, @0.6, @0.8, @1];
//    id values = @[@0.1, @0.2, @0.3, @0.4, @0.5, @0.6, @0.7, @0.8, @0.9, @1];
    self.graphView.values = values;
    
    self.graphView.barWidth = 22;
    self.graphView.barHeight = 140;
    self.graphView.marginBar = 20;

    [self.graphView draw];
    [self.graphView load];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onButtonFill:(id)sender {
    [[self.graphView draw] load];
}

- (IBAction)onButtonChange:(id)sender {
    [self.graphView setBarColor:[UIColor greenColor]];
}

- (IBAction)onButtonReset:(id)sender {
    [self.graphView reset];
}

@end
