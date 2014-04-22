//
//  ExampleLineGraph.m
//  GraphKit
//
//  Created by Michal Konturek on 21/04/2014.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import "ExampleLineGraph.h"

@interface ExampleLineGraph ()

@end

@implementation ExampleLineGraph

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor gk_cloudsColor];

    self.data = @[
                  @[@20, @40, @20, @60, @40, @180, @80, @50],
                  @[@40, @20, @60, @100, @60, @20, @60, @10],
                  @[@80, @60, @40, @160, @100, @40, @110, @80]
                  ];
    
    self.graph.dataSource = self;
    self.graph.lineWidth = 4.0;
    
    [self.graph draw];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - GKLineGraphDataSource

- (NSInteger)numberOfLines {
    return [self.data count];
}

- (UIColor *)colorForLineAtIndex:(NSInteger)index {
    id colors = @[[UIColor gk_turquoiseColor], [UIColor gk_peterRiverColor], [UIColor gk_alizarinColor]];
    return [colors objectAtIndex:index];
}

- (NSArray *)valuesForLineAtIndex:(NSInteger)index {
    return [self.data objectAtIndex:index];
}

- (CFTimeInterval)animationDurationForLineAtIndex:(NSInteger)index {
    return [[@[@1, @1.4, @1.8] objectAtIndex:index] doubleValue];
}

@end
