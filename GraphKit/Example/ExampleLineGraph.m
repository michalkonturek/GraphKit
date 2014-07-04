//
//  ExampleLineGraph.m
//  GraphKit
//
//  Created by Michal Konturek on 21/04/2014.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import "ExampleLineGraph.h"

#import "UIViewController+BButton.h"

@interface ExampleLineGraph () <GKLineGraphDelegate>

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
                  @[@-20, @-80, @20, @60, @40, @140, @80],
                  @[@40, @20, @60, @100, @60, @20, @60],
                  @[@80, @60, @40, @160, @100, @40, @110],
                  @[@120, @150, @80, @120, @140, @100, @0],
                  // @[@620, @650, @580, @620, @540, @400, @0]
                  ];
    
    self.labels = @[@"2001", @"2002", @"2003", @"2004", @"2005", @"2006", @"2007"];
    
    self.graph.dataSource = self;
    self.graph.delegate = self;
    self.graph.lineWidth = 1.5;
    self.graph.ensureXAxisVisibility = YES;
    self.graph.drawHorizontalGridLines = YES;
    self.graph.drawVerticalGridLines = NO;
    self.graph.drawCoordinateSystem = YES;
    
    self.graph.coordinateSystemColor = [UIColor darkGrayColor];
    self.graph.gridLinesColor = [UIColor lightGrayColor];
    self.graph.labelTextColor = [UIColor darkGrayColor];
    
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
    
    self.labels = @[@"2001", @"2002", @"2003", @"2004", @"2005", @"2006", @"2007"];
    
    self.graph.dataSource = self;
    self.graph.lineWidth = 3.0;
    
//    self.graph.startFromZero = YES;
    self.graph.valueLabelCount = 10;
    
    self.graph.ensureXAxisVisibility = YES;
    
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
                  [UIColor gk_sunflowerColor],
                  [UIColor gk_amethystColor]
                  ];
    return [colors objectAtIndex:index];
}

- (NSArray *)valuesForLineAtIndex:(NSInteger)index {
    return [self.data objectAtIndex:index];
}

- (CFTimeInterval)animationDurationForLineAtIndex:(NSInteger)index {
    // return [[@[@1, @1.6, @2.2, @1.4] objectAtIndex:index] doubleValue];
    return 0.75f;
}

- (NSString *)titleForLineAtIndex:(NSInteger)index {
    return [self.labels objectAtIndex:index];
}

- (NSArray* ) dashPatternForLineAtIndex:(NSInteger)index
{
    return [NSArray arrayWithObjects:[NSDecimalNumber numberWithInt:3],[NSDecimalNumber numberWithInt:3],nil];
}

#pragma mark - GKLineGraphDelegate
- (void)lineGraph:(GKLineGraph *)lineGraph willSelectDataPoint:(GKLineDataPoint *)dataPoint AtPoint:(CGPoint)targetPoint
{
    
}

- (void)lineGraph:(GKLineGraph *)lineGraph didSelectDataPoint:(GKLineDataPoint *)dataPoint AtPoint:(CGPoint)targetPoint
{
    NSLog (@"Did select value %i on line #%i", dataPoint.valueIndex, dataPoint.lineIndex);
}

- (void)lineGraph:(GKLineGraph *)lineGraph willDeselectDataPoint:(GKLineDataPoint *)dataPoint AtPoint:(CGPoint)targetPoint
{
    
}

- (void)lineGraph:(GKLineGraph *)lineGraph didDeselectDataPoint:(GKLineDataPoint *)dataPoint AtPoint:(CGPoint)targetPoint
{
    NSLog (@"Did deselect value %i on line #%i", dataPoint.valueIndex, dataPoint.lineIndex);
}

- (void)lineGraph:(GKLineGraph *)lineGraph didReselectDataPoint:(GKLineDataPoint *)dataPoint AtPoint:(CGPoint)targetPoint
{
    
}

@end
