//
//  ExampleStackedBarGraphVC.h
//  GraphKit
//
//  Created by Erich Grunewald on 27/04/15.
//  Copyright (c) 2015 Michal Konturek. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GraphKit.h"

@interface ExampleStackedBarGraphVC : UIViewController<GKStackedBarGraphDataSource>

@property (nonatomic, weak) IBOutlet GKStackedBarGraph *graphView;

@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSArray *labels;

- (IBAction)onButtonFill:(id)sender;

- (IBAction)onButtonChange:(id)sender;

- (IBAction)onButtonReset:(id)sender;

@end
