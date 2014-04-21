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

    self.data = @[
                  @[@40, @120, @60, @100, @140, @160, @140, @80, @100, @120],
                  @[@180, @160, @140, @120, @110, @120, @140, @160, @180, @180]
                  ];
    
    self.graph.dataSource = self;
    
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
    id colors = @[[UIColor greenColor], [UIColor redColor]];
    return [colors objectAtIndex:index];
}

- (NSArray *)valuesForLineAtIndex:(NSInteger)index {
    return [self.data objectAtIndex:index];
}


@end
