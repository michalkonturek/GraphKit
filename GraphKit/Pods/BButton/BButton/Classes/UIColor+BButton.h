//
//  Created by Mathieu Bolard on 31/07/12.
//  Copyright (c) 2012 Mathieu Bolard. All rights reserved.
//
//  https://github.com/mattlawer/BButton
//
//
//  BButton is licensed under the MIT license
//  http://opensource.org/licenses/MIT
//
//
//  -----------------------------------------
//  Edited and refactored by Jesse Squires on 2 April, 2013.
//
//  http://github.com/jessesquires/BButton
//
//  http://hexedbits.com
//

#import <UIKit/UIKit.h>

@interface UIColor (BButton)

#pragma mark - Custom colors

+ (UIColor *)bb_defaultColorV2;
+ (UIColor *)bb_defaultColorV3;

+ (UIColor *)bb_primaryColorV2;
+ (UIColor *)bb_primaryColorV3;

+ (UIColor *)bb_infoColorV2;
+ (UIColor *)bb_infoColorV3;

+ (UIColor *)bb_successColorV2;
+ (UIColor *)bb_successColorV3;

+ (UIColor *)bb_warningColorV2;
+ (UIColor *)bb_warningColorV3;

+ (UIColor *)bb_dangerColorV2;
+ (UIColor *)bb_dangerColorV3;

+ (UIColor *)bb_inverseColorV2;
+ (UIColor *)bb_inverseColorV3;

+ (UIColor *)bb_twitterColor;
+ (UIColor *)bb_facebookColor;
+ (UIColor *)bb_purpleBButtonColor;
+ (UIColor *)bb_grayBButtonColor;

#pragma mark - Utilities

- (UIColor *)bb_desaturatedColorToPercentSaturation:(CGFloat)percent;
- (UIColor *)bb_lightenColorWithValue:(CGFloat)value;
- (UIColor *)bb_darkenColorWithValue:(CGFloat)value;
- (BOOL)bb_isLightColor;

@end