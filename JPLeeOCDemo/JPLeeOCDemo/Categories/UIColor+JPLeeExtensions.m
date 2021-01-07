//
//  UIColor+JPLeeExtensions.m
//  JPLeeOCDemo
//
//  Created by Admin on 2021/1/7.
//

#import "UIColor+JPLeeExtensions.h"

@implementation UIColor (JPLeeExtensions)

+ (UIColor *)colorWithHexString:(NSString *)hexString
{
    return [self colorWithHexString:hexString alpha:1.0f];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha
{
    hexString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([hexString length] < 6) return [UIColor clearColor];
    
    if ([hexString hasPrefix:@"0X"]) hexString = [hexString substringFromIndex:2];
    if ([hexString hasPrefix:@"#"]) hexString = [hexString substringFromIndex:1];
    if ([hexString length] != 6) return [UIColor clearColor];
    
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    unsigned int hexNumber;
    if (![scanner scanHexInt:&hexNumber]) return [UIColor clearColor];
    
    return [UIColor colorWithRed:((float)((hexNumber & 0xFF0000) >> 16))/255.0
                           green:((float)((hexNumber & 0xFF00) >> 8))/255.0
                            blue:((float)(hexNumber & 0xFF))/255.0
                           alpha:alpha];
}

+ (UIColor *)colorWithHex:(NSUInteger)hex {
    float r = (hex & 0xff000000) >> 24;
    float g = (hex & 0x00ff0000) >> 16;
    float b = (hex & 0x0000ff00) >> 8;
    float a = (hex & 0x000000ff);
    
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/255.0];
}

@end
