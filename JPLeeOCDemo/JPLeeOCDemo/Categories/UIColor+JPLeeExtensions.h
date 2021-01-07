//
//  UIColor+JPLeeExtensions.h
//  JPLeeOCDemo
//
//  Created by Admin on 2021/1/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define JPLeeHEXRGBA(rgb,a)     [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0 green:((float)((rgb & 0xFF00) >> 8))/255.0 blue:((float)(rgb & 0xFF))/255.0 alpha:a]
#define JPLeeHEXRGB(rgb)        JPLeeHEXRGBA(rgb,1.0f)
#define JPLeeRGBA(r,g,b,a)      [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define JPLeeRGB(r,g,b)         JPLeeRGBA(r,g,b,1.0f)

@interface UIColor (JPLeeExtensions)

/// hexString:(FFFFFF, 0xFFFFFF，#FFFFFF)
+ (UIColor *)colorWithHexString:(NSString *)hexString;
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

/// hex:0xFFFFFFFF
+ (UIColor *)colorWithHex:(NSUInteger)hex;
@end

NS_ASSUME_NONNULL_END
