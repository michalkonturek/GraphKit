//
//  UIColor+GraphKit.m
//  GraphKit
//
//  Copyright (c) 2014 Michal Konturek
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "UIColor+GraphKit.h"

@implementation UIColor (GraphKit)

+ (UIColor *)gk_turquoiseColor {
    return [UIColor gk_colorFromHexCode:@"1ABC9C"];
}

+ (UIColor *)gk_greenSeaColor {
    return [UIColor gk_colorFromHexCode:@"16A085"];
}

+ (UIColor *)gk_emerlandColor {
    return [UIColor gk_colorFromHexCode:@"2ECC71"];
}

+ (UIColor *)gk_nephritisColor {
    return [UIColor gk_colorFromHexCode:@"27AE60"];
}

+ (UIColor *)gk_peterRiverColor {
    return [UIColor gk_colorFromHexCode:@"3498DB"];
}

+ (UIColor *)gk_belizeHoleColor {
    return [UIColor gk_colorFromHexCode:@"2980B9"];
}

+ (UIColor *)gk_amethystColor {
    return [UIColor gk_colorFromHexCode:@"9B59B6"];
}

+ (UIColor *)gk_wisteriaColor {
    return [UIColor gk_colorFromHexCode:@"8E44AD"];
}

+ (UIColor *)gk_wetAsphaltColor {
    return [UIColor gk_colorFromHexCode:@"34495E"];
}

+ (UIColor *)gk_midnightBlueColor {
    return [UIColor gk_colorFromHexCode:@"2C3E50"];
}

+ (UIColor *)gk_sunflowerColor {
    return [UIColor gk_colorFromHexCode:@"F1C40F"];
}

+ (UIColor *)gk_orangeColor {
    return [UIColor gk_colorFromHexCode:@"F39C12"];
}

+ (UIColor *)gk_carrotColor {
    return [UIColor gk_colorFromHexCode:@"E67E22"];
}

+ (UIColor *)gk_pumpkinColor {
    return [UIColor gk_colorFromHexCode:@"D35400"];
}

+ (UIColor *)gk_alizarinColor {
    return [UIColor gk_colorFromHexCode:@"E74C3C"];
}

+ (UIColor *)gk_pomegranateColor {
    return [UIColor gk_colorFromHexCode:@"C0392B"];
}

+ (UIColor *)gk_cloudsColor {
    return [UIColor gk_colorFromHexCode:@"ECF0F1"];
}

+ (UIColor *)gk_silverColor {
    return [UIColor gk_colorFromHexCode:@"BDC3C7"];
}

+ (UIColor *)gk_concreteColor {
    return [UIColor gk_colorFromHexCode:@"95A5A6"];
}

+ (UIColor *)gk_asbestosColor {
    return [UIColor gk_colorFromHexCode:@"7F8C8D"];
}

+ (UIColor *)gk_colorFromHexCode:(NSString *)hex {
    
    /*
     source: http://stackoverflow.com/questions/3805177/how-to-convert-hex-rgb-color-codes-to-uicolor
     */
    
    NSString *cleanString = [hex stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
