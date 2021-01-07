//
//  UIImage+JPLeeExtensions.h
//  JPLeeOCDemo
//
//  Created by Admin on 2021/1/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (JPLeeExtensions)

- (UIImage *)grayImage;

+ (UIImage *)imageWithUIView:(UIView *)view;
+ (UIImage *)imageWithText:(NSString *)text textFont:(UIFont *)font textColor:(UIColor *)textColor;
+ (UIImage *)imageWithAttText:(NSAttributedString *)attText;

+ (UIImage *)createQRCodeWithString:(NSString *)text qrSize:(CGSize)size;
+ (UIImage *)createQRCodeWithString:(NSString*)text qrSize:(CGSize)size qrColor:(UIColor*)qrColor bkColor:(UIColor*)bkColor;
+ (NSString *)recogniseQRCodeFromImage:(UIImage *)qrImage;
@end

NS_ASSUME_NONNULL_END
