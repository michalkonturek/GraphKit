//
//  BarGraphViewVC.h
//  GraphKit
//
//  Created by Michal Konturek on 17/04/2014.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GraphKit.h"

@interface ExampleBarGraphVC : UIViewController<GKBarGraphDataSource>

@property (nonatomic, weak) IBOutlet GKBarGraph *graphView;

@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSArray *labels;

- (IBAction)onButtonFill:(id)sender;

- (IBAction)onButtonChange:(id)sender;

- (IBAction)onButtonReset:(id)sender;

@end
