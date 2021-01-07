//
//  UIImage+JPLeeExtensions.m
//  JPLeeOCDemo
//
//  Created by Admin on 2021/1/7.
//

#import "UIImage+JPLeeExtensions.h"

@implementation UIImage (JPLeeExtensions)

- (UIImage *)grayImage
{
    if (!self || ![self isKindOfClass:[UIImage class]]) {
        return nil;
    }
    
    int bitmapInfo = kCGImageAlphaNone;
    int width = self.size.width;
    int height = self.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil,
                                                  width,
                                                  height,
                                                  8,
                                                  0,
                                                  colorSpace,
                                                  bitmapInfo);
    CGColorSpaceRelease(colorSpace);
    if (context == NULL) {
        return nil;
    }
    CGContextDrawImage(context,
                       CGRectMake(0, 0, width, height), self.CGImage);
    UIImage *grayImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    CGContextRelease(context);
    return grayImage;
}

+ (UIImage *)imageWithUIView:(UIView *)view
{
    if (!self) {
        return nil;
    }

    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageWithText:(NSString *)text textFont:(UIFont *)font textColor:(UIColor *)textColor
{
    font = font?:[UIFont systemFontOfSize:15.0];
    textColor = textColor?:[UIColor blackColor];
    
    NSDictionary *attrs = @{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor};
    CGSize size  = [text sizeWithAttributes:attrs];
    
    UIGraphicsBeginImageContextWithOptions(size,NO,0.0);
    UIGraphicsGetCurrentContext();
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    [text drawInRect:rect withAttributes:attrs];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageWithAttText:(NSAttributedString *)attText
{
    CGSize size  = [attText size];
    
    UIGraphicsBeginImageContextWithOptions(size,NO,0.0);
    UIGraphicsGetCurrentContext();
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    [attText drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)createQRCodeWithString:(NSString *)text qrSize:(CGSize)size {
    return [self createQRCodeWithString:text qrSize:size qrColor:[UIColor blackColor] bkColor:[UIColor whiteColor]];
}

+ (UIImage*)createQRCodeWithString:(NSString*)text qrSize:(CGSize)size qrColor:(UIColor*)qrColor bkColor:(UIColor*)bkColor {
    
    NSData *stringData = [text dataUsingEncoding: NSUTF8StringEncoding];
    
    // 生成
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 设置内容和纠错级别
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"H" forKey:@"inputCorrectionLevel"];
    //[qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    
    // 上色
    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor" keysAndValues:
                             @"inputImage",qrFilter.outputImage,
                             @"inputColor0",[CIColor colorWithCGColor:qrColor.CGColor],
                             @"inputColor1",[CIColor colorWithCGColor:bkColor.CGColor],
                             nil];
    
    CIImage *qrImage = colorFilter.outputImage;
    
    // 绘制
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    UIImage *codeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRelease(cgImage);
    
    return codeImage;
}

+ (NSString *)recogniseQRCodeFromImage:(UIImage *)qrImage
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:context options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    CIImage *image = [CIImage imageWithCGImage:qrImage.CGImage];
    NSArray *features = [detector featuresInImage:image];
    CIQRCodeFeature *feature = [features firstObject];
    
    NSString *result = feature.messageString;
    
    return result;
}

@end
