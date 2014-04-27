//
//  ExampleViewVC.h
//  GraphKit
//
//  Created by Michal Konturek on 16/04/2014.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GKBar;

@interface ExampleBarVC : UIViewController

@property (nonatomic, weak) IBOutlet GKBar *bar;

- (IBAction)onButtonAdd:(id)sender;

- (IBAction)onButtonMinus:(id)sender;

- (IBAction)onButtonChange:(id)sender;

- (IBAction)onButtonReset:(id)sender;

@end
