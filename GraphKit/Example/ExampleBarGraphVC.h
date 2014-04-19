//
//  BarGraphViewVC.h
//  GraphKit
//
//  Created by Michal Konturek on 17/04/2014.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BarGraphView.h"

@interface ExampleBarGraphVC : UIViewController

@property (nonatomic, weak) IBOutlet BarGraphView *graphView;

- (IBAction)onButtonFill:(id)sender;
- (IBAction)onButtonChange:(id)sender;
- (IBAction)onButtonReset:(id)sender;

@end
