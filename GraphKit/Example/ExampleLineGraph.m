//
//  ExampleLineGraph.m
//  GraphKit
//
//  Created by Michal Konturek on 21/04/2014.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import "ExampleLineGraph.h"

#import "UIViewController+BButton.h"

@interface ExampleLineGraph ()

@end

@implementation ExampleLineGraph

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self setupButtons];
    
    self.view.backgroundColor = [UIColor gk_cloudsColor];

    [self _setupExampleGraph];
//    [self _setupTestingGraphLow];
//    [self _setupTestingGraphHigh];
}

- (void)_setupExampleGraph {

    self.data = @[
                  @[@20, @40, @20, @60, @40, @140, @80],
                  @[@40, @20, @60, @100, @60, @20, @60],
                  @[@80, @60, @40, @160, @100, @40, @110],
                  @[@120, @150, @80, @120, @140, @100, @0],
//                  @[@620, @650, @580, @620, @540, @400, @0]
                  ];
    
    self.labels = @[@"2001", @"2002", @"2003", @"2004", @"2005", @"2006", @"2007"];
    
    self.graph.dataSource = self;
    self.graph.lineWidth = 3.0;
    
    self.graph.valueLabelCount = 6;
    
    [self.graph draw];
}

- (void)_setupTestingGraphLow {
    
    /*
     A custom max and min values can be achieved by adding 
     values for another line and setting its color to clear.
     */
    
    self.data = @[
                  @[@10, @4, @8, @2, @9, @3, @6],
                  @[@1, @2, @3, @4, @5, @6, @10]
                  ];
//    self.data = @[
//                  @[@2, @2, @2, @2, @2, @2, @6],
//                  @[@1, @1, @1, @1, @1, @1, @1]
//                  ];
    
    self.labels = @[@"2001", @"2002", @"2003", @"2004", @"2005", @"2006", @"2007"];
    
    self.graph.dataSource = self;
    self.graph.lineWidth = 3.0;
    
//    self.graph.startFromZero = YES;
    self.graph.valueLabelCount = 10;
    
    [self.graph draw];
}

- (void)_setupTestingGraphHigh {
    
    self.data = @[
                  @[@1000, @2000, @3000, @4000, @5000, @6000, @10000]
                  ];
    
    self.labels = @[@"2001", @"2002", @"2003", @"2004", @"2005", @"2006", @"2007"];
    
    self.graph.dataSource = self;
    self.graph.lineWidth = 3.0;
    
    //    self.graph.startFromZero = YES;
    self.graph.valueLabelCount = 10;
    
    [self.graph draw];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Event Handlers

- (IBAction)onButtonDraw:(id)sender {
    [self.graph reset];
    [self.graph draw];
}

- (IBAction)onButtonReset:(id)sender {
    [self.graph reset];    
}


#pragma mark - GKLineGraphDataSource

- (NSInteger)numberOfLines {
    return [self.data count];
}

- (UIColor *)colorForLineAtIndex:(NSInteger)index {
    id colors = @[[UIColor gk_turquoiseColor],
                  [UIColor gk_peterRiverColor],
                  [UIColor gk_alizarinColor],
                  [UIColor gk_sunflowerColor]
                  ];
    return [colors objectAtIndex:index];
}

- (NSArray *)valuesForLineAtIndex:(NSInteger)index {
    return [self.data objectAtIndex:index];
}

- (CFTimeInterval)animationDurationForLineAtIndex:(NSInteger)index {
    return [[@[@1, @1.6, @2.2, @1.4] objectAtIndex:index] doubleValue];
}

- (NSString *)titleForLineAtIndex:(NSInteger)index {
    return [self.labels objectAtIndex:index];
}

@end
