//
//  BButton.m
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

#import "BButton.h"
#import <CoreGraphics/CoreGraphics.h>

static CGFloat const kBButtonCornerRadiusV2 = 6.0f;
static CGFloat const kBButtonCornerRadiusV3 = 4.0f;
static NSArray * kFontAwesomeStrings;

@interface BButton ()

@property (assign, nonatomic) BButtonStyle buttonStyle;

- (void)setup;
- (void)setTextAttributesForStyle:(BButtonStyle)aStyle;

- (void)didRecieveMemoryWarningNotification:(NSNotification *)notification;

- (NSString *)stringFromFontAwesomeIcon:(FAIcon)icon;

+ (UIColor *)colorForButtonType:(BButtonType)type style:(BButtonStyle)style;
+ (UIColor *)colorForV2StyleButtonWithType:(BButtonType)type;
+ (UIColor *)colorForV3StyleButtonWithType:(BButtonType)type;
+ (NSNumber *)cornerRadiusForStyle:(BButtonStyle)aStyle;

- (NSString *)stringByTrimingWhiteSpaceFromString:(NSString *)str;
- (BOOL)isStringEmpty:(NSString *)str;

- (void)drawBButtonStyleV2InRect:(CGRect)rect withContext:(CGContextRef *)context;
- (void)drawBButtonStyleV3InRect:(CGRect)rect withContext:(CGContextRef *)context;

@end



@implementation BButton

#pragma mark - Setup

- (void)setup
{
    [self setBackgroundColor:[UIColor clearColor]];
    _shouldShowDisabled = YES;
    _buttonStyle = BButtonStyleBootstrapV3;
    [self setType:BButtonTypeDefault];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didRecieveMemoryWarningNotification:)
                                                 name:UIApplicationDidReceiveMemoryWarningNotification
                                               object:nil];
}

- (void)setTextAttributesForStyle:(BButtonStyle)aStyle
{
    switch (aStyle) {
        case BButtonStyleBootstrapV2:
            [[self titleLabel] setShadowOffset:CGSizeMake(0.0f, -1.0f)];
            [[self titleLabel] setFont:[UIFont boldSystemFontOfSize:17.0f]];
            break;
            
        case BButtonStyleBootstrapV3:
            [[self titleLabel] setShadowOffset:CGSizeMake(0.0f, 0.0f)];
            [[self titleLabel] setFont:[UIFont systemFontOfSize:17.0f]];
            break;
    }
}

#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame type:(BButtonType)type style:(BButtonStyle)style
{
    return [self initWithFrame:frame
                         color:[BButton colorForButtonType:type style:style]
                         style:style];
}

- (id)initWithFrame:(CGRect)frame
               type:(BButtonType)type
              style:(BButtonStyle)style
               icon:(FAIcon)icon
           fontSize:(CGFloat)fontSize
{
    return [self initWithFrame:frame
                         color:[BButton colorForButtonType:type style:style]
                         style:style
                          icon:icon
                      fontSize:fontSize];
}

- (id)initWithFrame:(CGRect)frame color:(UIColor *)color style:(BButtonStyle)style
{
    self = [self initWithFrame:frame];
    if(self) {
        _buttonStyle = style;
        [self setColor:color];
        [self setTextAttributesForStyle:style];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
              color:(UIColor *)color
              style:(BButtonStyle)style
               icon:(FAIcon)icon
           fontSize:(CGFloat)fontSize
{
    self = [self initWithFrame:frame color:color style:style];
    if(self) {
        [[self titleLabel] setFont:[UIFont fontWithName:kFontAwesomeFont size:fontSize]];
        [[self titleLabel] setTextAlignment:NSTextAlignmentCenter];
        [self setTitle:[self stringFromFontAwesomeIcon:icon]
              forState:UIControlStateNormal];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        [self setup];
        [self setTextAttributesForStyle:_buttonStyle];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self setup];
    }
    return self;
}

- (void)dealloc
{
    _color = nil;
    _buttonCornerRadius = nil;
    kFontAwesomeStrings = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidReceiveMemoryWarningNotification
                                                  object:nil];
}

#pragma mark - Class initialization

+ (BButton *)awesomeButtonWithOnlyIcon:(FAIcon)icon
                                  type:(BButtonType)type
                                 style:(BButtonStyle)style
{
    return [BButton awesomeButtonWithOnlyIcon:icon
                                        color:[BButton colorForButtonType:type style:style]
                                        style:style];
}

+ (BButton *)awesomeButtonWithOnlyIcon:(FAIcon)icon
                                 color:(UIColor *)color
                                 style:(BButtonStyle)style
{
    return [[BButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 40.0f, 40.0f)
                                    color:color
                                    style:style
                                     icon:icon
                                 fontSize:20.0f];
}

#pragma mark - Parent overrides

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    [self setNeedsDisplay];
}

#pragma mark - UIAppearance getters

- (NSNumber *)buttonCornerRadius
{
    if(!_buttonCornerRadius) {
        _buttonCornerRadius = [[[self class] appearance] buttonCornerRadius];
    }
    
    if(_buttonCornerRadius) {
        return _buttonCornerRadius;
    }
    
    return [BButton cornerRadiusForStyle:_buttonStyle];
}

#pragma mark - Setters

- (void)setColor:(UIColor *)newColor
{
    _color = newColor;
    
    if([newColor bb_isLightColor]) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleShadowColor:[[UIColor whiteColor] colorWithAlphaComponent:0.6f] forState:UIControlStateNormal];
        
        if(self.shouldShowDisabled)
            [self setTitleColor:[UIColor colorWithWhite:0.4f alpha:0.5f] forState:UIControlStateDisabled];
    }
    else {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleShadowColor:[[UIColor blackColor] colorWithAlphaComponent:0.6f] forState:UIControlStateNormal];
        
        if(self.shouldShowDisabled)
            [self setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.5f] forState:UIControlStateDisabled];
    }
    
    [self setNeedsDisplay];
}

- (void)setShouldShowDisabled:(BOOL)show
{
    _shouldShowDisabled = show;
    
    if(show) {
        if([self.color bb_isLightColor])
            [self setTitleColor:[UIColor colorWithWhite:0.4f alpha:0.5f] forState:UIControlStateDisabled];
        else
            [self setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.5f] forState:UIControlStateDisabled];
    }
    else {
        if([self.color bb_isLightColor])
            [self setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
        else
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    }
}

#pragma mark - Notifications

- (void)didRecieveMemoryWarningNotification:(NSNotification *)notification
{
    NSLog(@"%@ recieved %@", [BButton class], notification.name);
    kFontAwesomeStrings = nil;
}

#pragma mark - BButton

- (void)setStyle:(BButtonStyle)style
{
    _buttonStyle = style;
    [self setColor:_color];
}

- (void)setType:(BButtonType)type
{
    [self setColor:[BButton colorForButtonType:type
                                         style:_buttonStyle]];
}

- (void)addAwesomeIcon:(FAIcon)icon beforeTitle:(BOOL)before
{
    NSString *iconString = [self stringFromFontAwesomeIcon:icon];
    self.titleLabel.font = [UIFont fontWithName:kFontAwesomeFont
                                           size:self.titleLabel.font.pointSize];
    
    NSString *title = [NSString stringWithFormat:@"%@", iconString];
    
    if(self.titleLabel.text && ![self isStringEmpty:self.titleLabel.text]) {
        if(before) {
            title = [title stringByAppendingFormat:@" %@", self.titleLabel.text];
        }
        else {
            title = [NSString stringWithFormat:@"%@ %@", self.titleLabel.text, iconString];
        }
    }
    
    [self setTitle:title forState:UIControlStateNormal];
}

- (NSString *)stringFromFontAwesomeIcon:(FAIcon)icon
{
    if(!kFontAwesomeStrings) {
        kFontAwesomeStrings = [NSString fa_allFontAwesomeStrings];
    }
    return [NSString fa_stringFromFontAwesomeStrings:kFontAwesomeStrings
                                             forIcon:icon];
}

+ (UIColor *)colorForButtonType:(BButtonType)type style:(BButtonStyle)style
{
    switch (style) {
        case BButtonStyleBootstrapV2:
            return [BButton colorForV2StyleButtonWithType:type];
        case BButtonStyleBootstrapV3:
        default:
            return [BButton colorForV3StyleButtonWithType:type];
    }
}

+ (UIColor *)colorForV2StyleButtonWithType:(BButtonType)type
{
    switch (type) {
        case BButtonTypePrimary:
            return [UIColor bb_primaryColorV2];
            
        case BButtonTypeInfo:
            return [UIColor bb_infoColorV2];
            
        case BButtonTypeSuccess:
            return [UIColor bb_successColorV2];
            
        case BButtonTypeWarning:
            return [UIColor bb_warningColorV2];
            
        case BButtonTypeDanger:
            return [UIColor bb_dangerColorV2];
            
        case BButtonTypeInverse:
            return [UIColor bb_inverseColorV2];
            
        case BButtonTypeTwitter:
            return [UIColor bb_twitterColor];
            
        case BButtonTypeFacebook:
            return [UIColor bb_facebookColor];
            
        case BButtonTypePurple:
            return [UIColor bb_purpleBButtonColor];
            
        case BButtonTypeGray:
            return [UIColor bb_grayBButtonColor];
            
        case BButtonTypeDefault:
        default:
            return [UIColor bb_defaultColorV2];
    }
}

+ (UIColor *)colorForV3StyleButtonWithType:(BButtonType)type
{
    switch (type) {
        case BButtonTypePrimary:
            return [UIColor bb_primaryColorV3];
            
        case BButtonTypeInfo:
            return [UIColor bb_infoColorV3];
            
        case BButtonTypeSuccess:
            return [UIColor bb_successColorV3];
            
        case BButtonTypeWarning:
            return [UIColor bb_warningColorV3];
            
        case BButtonTypeDanger:
            return [UIColor bb_dangerColorV3];
            
        case BButtonTypeInverse:
            return [UIColor bb_inverseColorV3];
            
        case BButtonTypeTwitter:
            return [UIColor bb_twitterColor];
            
        case BButtonTypeFacebook:
            return [UIColor bb_facebookColor];
            
        case BButtonTypePurple:
            return [UIColor bb_purpleBButtonColor];
            
        case BButtonTypeGray:
            return [UIColor bb_grayBButtonColor];
            
        case BButtonTypeDefault:
        default:
            return [UIColor bb_defaultColorV3];
    }
}

+ (NSNumber *)cornerRadiusForStyle:(BButtonStyle)aStyle
{
    CGFloat r = 0.0f;
    
    switch (aStyle) {
        case BButtonStyleBootstrapV2:
            r = kBButtonCornerRadiusV2;
            break;
        case BButtonStyleBootstrapV3:
            r = kBButtonCornerRadiusV3;
            break;
    }
    return [NSNumber numberWithFloat:r];
}

#pragma mark - Utilities

- (NSString *)stringByTrimingWhiteSpaceFromString:(NSString *)str
{
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)isStringEmpty:(NSString *)str
{
    return [[self stringByTrimingWhiteSpaceFromString:str] isEqualToString:@""];
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if(!context)
        return;
    
    switch (self.buttonStyle) {
        case BButtonStyleBootstrapV2:
            [self drawBButtonStyleV2InRect:rect withContext:&context];
            break;
        case BButtonStyleBootstrapV3:
            [self drawBButtonStyleV3InRect:rect withContext:&context];
            break;
    }
}

- (void)drawBButtonStyleV2InRect:(CGRect)rect withContext:(CGContextRef *)context
{
    UIColor *border = [self.color bb_darkenColorWithValue:0.06f];
    
    UIColor *shadow = [self.color bb_lightenColorWithValue:0.50f];
    CGSize shadowOffset = CGSizeMake(0.0f, 1.0f);
    CGFloat shadowBlurRadius = 2.0f;
    
    UIBezierPath *roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.5f, 0.5f, rect.size.width-1.0f, rect.size.height-1.0f)
                                                                    cornerRadius:[self.buttonCornerRadius floatValue]];
    
    CGContextSaveGState(*context);
    
    [roundedRectanglePath addClip];
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    UIColor *topColor = (self.shouldShowDisabled && !self.enabled) ? [self.color bb_darkenColorWithValue:0.12f] : [self.color bb_lightenColorWithValue:0.12f];
    
    NSArray *newGradientColors = [NSArray arrayWithObjects:(id)topColor.CGColor, (id)self.color.CGColor, nil];
    CGFloat newGradientLocations[] = {0.0f, 1.0f};
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)newGradientColors, newGradientLocations);
    
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawLinearGradient(*context,
                                gradient,
                                CGPointMake(0.0f, self.highlighted ? rect.size.height - 0.5f : 0.5f),
                                CGPointMake(0.0f, self.highlighted ? 0.5f : rect.size.height - 0.5f), 0.0f);
    
    CGGradientRelease(gradient);
    
    CGContextRestoreGState(*context);
    
    if(!self.highlighted) {
        // Rounded Rectangle Inner Shadow
        CGRect roundedRectangleBorderRect = CGRectInset([roundedRectanglePath bounds], -shadowBlurRadius, -shadowBlurRadius);
        roundedRectangleBorderRect = CGRectOffset(roundedRectangleBorderRect, -shadowOffset.width, -shadowOffset.height);
        roundedRectangleBorderRect = CGRectInset(CGRectUnion(roundedRectangleBorderRect, [roundedRectanglePath bounds]), -1.0f, -1.0f);
        
        UIBezierPath *roundedRectangleNegativePath = [UIBezierPath bezierPathWithRect: roundedRectangleBorderRect];
        [roundedRectangleNegativePath appendPath: roundedRectanglePath];
        roundedRectangleNegativePath.usesEvenOddFillRule = YES;
        
        CGContextSaveGState(*context);
        
        CGFloat xOffset = shadowOffset.width + round(roundedRectangleBorderRect.size.width);
        CGFloat yOffset = shadowOffset.height;
        CGContextSetShadowWithColor(*context,
                                    CGSizeMake(xOffset + copysign(0.1f, xOffset), yOffset + copysign(0.1f, yOffset)),
                                    shadowBlurRadius,
                                    shadow.CGColor);
        
        [roundedRectanglePath addClip];
        CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(roundedRectangleBorderRect.size.width), 0.0f);
        [roundedRectangleNegativePath applyTransform: transform];
        [[UIColor grayColor] setFill];
        [roundedRectangleNegativePath fill];
        
        CGContextRestoreGState(*context);
    }
    
    [border setStroke];
    roundedRectanglePath.lineWidth = 1.0f;
    [roundedRectanglePath stroke];
}

- (void)drawBButtonStyleV3InRect:(CGRect)rect withContext:(CGContextRef *)context
{
    CGContextSaveGState(*context);
    
    UIColor *fill = (!self.highlighted) ? self.color : [self.color bb_darkenColorWithValue:0.06f];
    if(!self.enabled)
        [fill bb_desaturatedColorToPercentSaturation:0.60f];
    
    CGContextSetFillColorWithColor(*context, fill.CGColor);
    
    UIColor *border = (!self.highlighted) ? [self.color bb_darkenColorWithValue:0.06f] : [self.color bb_darkenColorWithValue:0.12f];
    if(!self.enabled)
        [border bb_desaturatedColorToPercentSaturation:0.60f];
    
    CGContextSetStrokeColorWithColor(*context, border.CGColor);
    
    CGContextSetLineWidth(*context, 1.0f);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.5f, 0.5f, rect.size.width-1.0f, rect.size.height-1.0f)
                                                    cornerRadius:[self.buttonCornerRadius floatValue]];
    
    CGContextAddPath(*context, path.CGPath);
    CGContextDrawPath(*context, kCGPathFillStroke);
    
    CGContextRestoreGState(*context);
}

@end