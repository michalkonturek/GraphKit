//
//  ExampleStackedBarGraphVC.m
//  GraphKit
//
//  Created by Erich Grunewald on 27/04/15.
//  Copyright (c) 2015 Michal Konturek. All rights reserved.
//

#import "ExampleStackedBarGraphVC.h"

#import "UIViewController+BButton.h"

@interface ExampleStackedBarGraphVC ()

@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, assign) BOOL warmColors;

@end

@implementation ExampleStackedBarGraphVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self setupButtons];
    
    self.view.backgroundColor = [UIColor gk_cloudsColor];
    
    self.data = @[@[@11, @14, @49, @12],
                  @[@25, @4, @8, @8],
                  @[@7, @38, @17, @28],
                  @[@28, @5, @8, @59]];
    self.labels = @[@"DE", @"PL", @"CN", @"JP"];
    
    self.colors = @[@[[UIColor gk_midnightBlueColor],
                      [UIColor gk_wisteriaColor],
                      [UIColor gk_peterRiverColor],
                      [UIColor gk_emerlandColor]
                      ],
                    @[[UIColor gk_pomegranateColor],
                      [UIColor gk_alizarinColor],
                      [UIColor gk_sunflowerColor],
                      [UIColor gk_amethystColor]
                      ]];
    
    self.graphView.dataSource = self;
    
    [self.graphView draw];
    
    self.warmColors = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onButtonFill:(id)sender {
    [self.graphView draw];
}

- (IBAction)onButtonChange:(id)sender {
    self.warmColors = !self.warmColors;
    self.graphView.barColors = self.colors[self.warmColors];
}

- (IBAction)onButtonReset:(id)sender {
    [self.graphView reset];
}


#pragma mark - GKStackedBarGraphDataSource

- (NSInteger)numberOfBars {
    return [self.data count];
}

- (NSInteger)numberOfStacks {
    return [[self.data firstObject] count];
}

- (NSNumber *)valueForBarAtIndex:(NSInteger)index stack:(NSInteger)stack {
    return self.data[index][stack];
}

- (UIColor *)colorForBarAtIndex:(NSInteger)index stack:(NSInteger)stack {
    return self.colors[0][stack];
}

- (NSString *)titleForBarAtIndex:(NSInteger)index {
    return self.labels[index];
}

- (CFTimeInterval)animationDurationForBarAtIndex:(NSInteger)index {
    id barValues = self.data[index];
    CGFloat percentage = [[barValues valueForKeyPath:@"@sum.self"] doubleValue];
    percentage = (percentage / 100);
    return (self.graphView.animationDuration * percentage);
}

@end
