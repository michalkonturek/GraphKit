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
#import "UIColor+BButton.h"
#import "NSString+FontAwesome.h"

/**
 *  A constant describing the button style.
 */
typedef NS_ENUM(NSUInteger, BButtonStyle) {
    /**
     *  Styles the button like bootstrap version 2.x.x.
     */
    BButtonStyleBootstrapV2,
    /**
     *  Styles the button like bootstrap version 3.x.x.
     */
    BButtonStyleBootstrapV3
};


/**
 *  A constant describing the button type. This sets the button color.
 */
typedef NS_ENUM(NSUInteger, BButtonType) {
    BButtonTypeDefault,
    BButtonTypePrimary,
    BButtonTypeInfo,
    BButtonTypeSuccess,
    BButtonTypeWarning,
    BButtonTypeDanger,
    BButtonTypeInverse,
    BButtonTypeTwitter,
    BButtonTypeFacebook,
    BButtonTypePurple,
    BButtonTypeGray
};


/**
 *  An instanace of `BButton` is a subclass of `UIButton` that is styled like the Twitter Bootstrap buttons and is drawn entirely with `CoreGraphics`.
 */
@interface BButton : UIButton <UIAppearance>

/**
 *  The color of the button in its normal state. `BButton` automatically darks this color when the button enters its pressed state. The default value is `[UIColor bb_defaultColorV3]`, the color value associated with `BButtonTypeDefault`. @see BButtonType.
 */
@property (strong, nonatomic) UIColor *color;

/**
 *  The corner radius of the button. The default value is 6.0 for buttons initialized with style `BButtonStyleBootstrapV2`, or 4.0 for buttons initialized with style `BButtonStyleBootstrapV3`. @see BButtonType.
 */
@property (strong, nonatomic) NSNumber *buttonCornerRadius UI_APPEARANCE_SELECTOR;

/**
 *  A boolean value indicating whether or not the button should be drawn to reflect a disabled state when `enabled` is set to `NO`. The default value is `YES`.
 */
@property (assign, nonatomic) BOOL shouldShowDisabled;

#pragma mark - Initialization

/**
 *  Initializes and returns a button having the given frame, type, and style.
 *
 *  @param frame  A rectangle specifying the initial location and size of the button in its superview's coordinates.
 *  @param type   A constant that specifies the type of the button. @see BButtonType.
 *  @param style  A constant that specifies the style of the button. @see BButtonStyle.
 *
 *  @return An initialized `BButton` object or `nil` if the object could not be successfully initialized.
 */
- (instancetype)initWithFrame:(CGRect)frame type:(BButtonType)type style:(BButtonStyle)style;

/**
 *  Initializes and returns a button having the given frame, type, style, icon, and font size.
 *
 *  @param frame  A rectangle specifying the initial location and size of the button in its superview's coordinates.
 *  @param type   A constant that specifies the type of the button. @see BButtonType.
 *  @param style  A constant that specifies the style of the button. @see BButtonStyle.
 *  @param icon     A contant that specifies the FontAwesome icon of the button. @see FAIcon.
 *  @param fontSize A float specifying the font size of the button's `textLabel`.
 *
 *  @return An initialized `BButton` object or `nil` if the object could not be successfully initialized.
 */
- (instancetype)initWithFrame:(CGRect)frame
                         type:(BButtonType)type
                        style:(BButtonStyle)style
                         icon:(FAIcon)icon
                     fontSize:(CGFloat)fontSize;

/**
 *  Initializes and returns a button having the given frame, color, and style.
 *
 *  @param frame  A rectangle specifying the initial location and size of the button in its superview's coordinates.
 *  @param color  A `UIColor` object specifying the color of the button.
 *  @param style  A constant that specifies the style of the button. @see BButtonStyle.
 *
 *  @return An initialized `BButton` object or `nil` if the object could not be successfully initialized.
 */
- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color style:(BButtonStyle)style;

/**
 *  Initializes and returns a button having the given frame, color, style, icon, and font size.
 *
 *  @param frame  A rectangle specifying the initial location and size of the button in its superview's coordinates.
 *  @param color  A `UIColor` object specifying the color of the button.
 *  @param style  A constant that specifies the style of the button. @see BButtonStyle.
 *  @param icon     A contant that specifies the FontAwesome icon of the button. @see FAIcon.
 *  @param fontSize A float specifying the font size of the button's `textLabel`.
 *
 *  @return An initialized `BButton` object or `nil` if the object could not be successfully initialized.
 */
- (instancetype)initWithFrame:(CGRect)frame
                        color:(UIColor *)color
                        style:(BButtonStyle)style
                         icon:(FAIcon)icon
                     fontSize:(CGFloat)fontSize;

/**
 *  Initializes and returns a special icon-only button having the given icon, type, and style. The button frame is set with an origin of `(0.0, 0.0)` and a size of `(40.0, 40.0)`. The button font size is set to `20.0`.
 *
 *  @param icon  A contant that specifies the FontAwesome icon of the button. @see FAIcon.
 *  @param type  A constant that specifies the type of the button. @see BButtonType.
 *  @param style A constant that specifies the style of the button. @see BButtonStyle.
 *
 *  @return An initialized `BButton` object or `nil` if the object could not be successfully initialized.
 */
+ (instancetype)awesomeButtonWithOnlyIcon:(FAIcon)icon
                                     type:(BButtonType)type
                                    style:(BButtonStyle)style;

/**
 *  Initializes and returns a special icon-only button having the given icon, color, and style. The button frame is set with an origin of `(0.0, 0.0)` and a size of `(40.0, 40.0)`. The button font size is set to `20.0`.
 *
 *  @param icon  A contant that specifies the FontAwesome icon of the button. @see FAIcon.
 *  @param color A `UIColor` object specifying the color of the button.
 *  @param style A constant that specifies the style of the button. @see BButtonStyle.
 *
 *  @return An initialized `BButton` object or `nil` if the object could not be successfully initialized.
 */
+ (instancetype)awesomeButtonWithOnlyIcon:(FAIcon)icon
                                    color:(UIColor *)color
                                    style:(BButtonStyle)style;

#pragma mark - BButton

/**
 *  Sets the style of the button after. @see BButtonStyle.
 *
 *  @param style A constant describing the button style.
 *
 *  @bug If also setting the button type via `setType:`, *you must set the button style first*, via this method.
 */
- (void)setStyle:(BButtonStyle)style;

/**
 *  Sets the type of the button. @see BButtonType.
 *
 *  @param type A constant describing the button type.
 */
- (void)setType:(BButtonType)type;

/**
 *  Adds the specified icon to the buttons's `titleLabel`, and sets `titleLabel.font` to `FontAwesome.ttf`.
 *
 *  @param icon   A constant describing the FontAwesome Icon. @see FAIcon.
 *  @param before A boolean value indicating if the icon should be placed before or after any existing text. Pass `YES` to place the icon before the text, and `NO` to place the icon after the text. 
 *
 *  @warning A single space is inserted between the added icon and existing text.
 */
- (void)addAwesomeIcon:(FAIcon)icon beforeTitle:(BOOL)before;

@end