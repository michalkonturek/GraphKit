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
//                  @[@20, @40, @20, @60, @40, @60, @80, @50, @20, @40],
//                  @[@40, @20, @60, @100, @60, @20, @60, @80, @40, @20]
                  @[@20, @40, @20, @60, @40, @60, @80, @50],
                  @[@40, @20, @60, @100, @60, @20, @60, @80],
                  @[@80, @60, @40, @80, @100, @70, @90, @120]
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


@end
