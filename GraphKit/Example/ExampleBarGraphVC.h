//
//  BarGraphViewVC.h
//  GraphKit
//
//  Created by Michal Konturek on 17/04/2014.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GKBarGraph.h"

@interface ExampleBarGraphVC : UIViewController

@property (nonatomic, weak) IBOutlet GKBarGraph *graphView;

- (IBAction)onButtonFill:(id)sender;

- (IBAction)onButtonChange:(id)sender;

- (IBAction)onButtonReset:(id)sender;

@end
