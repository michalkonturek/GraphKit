//
//  BarGraphViewVC.m
//  GraphKit
//
//  Created by Michal Konturek on 17/04/2014.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import "ExampleBarGraphVC.h"

#import "UIViewController+BButton.h"

@interface ExampleBarGraphVC ()

@property (nonatomic, assign) BOOL green;

@end

@implementation ExampleBarGraphVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupButtons];
    
    self.view.backgroundColor = [UIColor gk_cloudsColor];

//    id values = @[@10, @25, @40, @60, @85, @100];
//    id values = @[@30, @10, @40, @60, @50, @75];
//    self.graphView.values = values;
    
//    self.graphView.barWidth = 22;
//    self.graphView.barHeight = 140;
    
    self.data = @[@30, @10, @40, @60, @50, @75];
    
    self.graphView.dataSource = self;
    self.graphView.marginBar = 20;
    
    [self.graphView construct];
    self.graphView.animationDuration = 1.0;
    [self.graphView draw];
    
    self.green = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onButtonFill:(id)sender {
    [self.graphView draw];
}

- (IBAction)onButtonChange:(id)sender {
    self.green = !self.green;
    self.graphView.barColor = (self.green) ? [UIColor gk_turquoiseColor] : [UIColor gk_amethystColor];
}

- (IBAction)onButtonReset:(id)sender {
    [self.graphView reset];
}

#pragma mark - GKBarGraphDataSource

- (NSInteger)numberOfBars {
    return [self.data count];
}

- (UIColor *)colorForBarAtIndex:(NSInteger)index {
    id colors = @[[UIColor gk_turquoiseColor],
                  [UIColor gk_peterRiverColor],
                  [UIColor gk_alizarinColor],
                  [UIColor gk_amethystColor],
                  [UIColor gk_emerlandColor],
                  [UIColor gk_carrotColor]
                  ];
    return [colors objectAtIndex:index];
}

- (NSNumber *)valueForBarAtIndex:(NSInteger)index {
    return [self.data objectAtIndex:index];
}

- (CFTimeInterval)animationDurationForBarAtIndex:(NSInteger)index {
    CGFloat percentage = [[self valueForBarAtIndex:index] doubleValue];
    percentage = (percentage / 100);
    return (self.graphView.animationDuration * percentage);
//    return [[@[@1, @1.4, @1.8] objectAtIndex:index] doubleValue];
}





//id values = @[@30, @10, @40, @60, @50, @75];
//self.graphView.values = values;



@end
