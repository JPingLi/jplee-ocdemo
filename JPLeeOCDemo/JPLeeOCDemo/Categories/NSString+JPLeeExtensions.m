//
//  NSString+JPLeeExtensions.m
//  JPLeeOCDemo
//
//  Created by Admin on 2021/1/7.
//

#import "NSString+JPLeeExtensions.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (JPLeeExtensions)

- (BOOL)isEmpty {
    return !self || nil == self
    || 0 == [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length];
}

- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)urlEncode {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                 NULL,
                                                                                 (CFStringRef)self,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                 CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
#pragma clang diagnostic pop
}

- (NSString *)urlDecode {
    return (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapes(
                                                                                 kCFAllocatorDefault,
                                                                                 (CFStringRef)self,
                                                                                 CFSTR("")));
}


- (NSString *)hash_md5
{
    const char* ptr = [self UTF8String];
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CC_MD5(ptr, (CC_LONG)strlen(ptr), md5Buffer);
#pragma clang diagnostic pop
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", md5Buffer[i]];
    }
    
    return output;
}

- (NSString *)hash_sha1
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

- (BOOL)validatePhoneNum
{
    if (!self || self.length <= 0) {
        return NO;
    }
    
    /**
     * 手机号码
     */
    NSString * MOBILE = @"^1\\d{10}$";
    
    /**
      * 大陆地区固话及小灵通
      * 区号：010,020,021,022,023,024,025,027,028,029
      * 号码：七位或八位
      */
     NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    /**
     * 香港|澳门手机号码正则
     * 9或6开头后面跟7位数字
     */
     NSString * HK_MC = @"^([6|9])\\d{7}$";
    
    /**
     * 台湾手机号码正则
     * 9开头后面跟8位数字
     */
    NSString * TW = @"^[0][9]\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestPHS = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    NSPredicate *regextesthk_mc = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", HK_MC];
    NSPredicate *regextesttw = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", TW];
    
    if([regextestmobile evaluateWithObject:self]
       || [regextestPHS evaluateWithObject:self]
       || [regextesthk_mc evaluateWithObject:self]
       || [regextesttw evaluateWithObject:self]) {
        return YES;
    }
    else {
        return NO;
    }
}

- (BOOL)validateEmail
{
    if (!self || self.length <= 0) {
        return NO;
    }
    NSString *emailRegex = @"[\\w-]+(\\.[\\w-]+)*@[\\w-]+(\\.[\\w-]+)+";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)validateIdentityCard
{
    if (!self || self.length <= 0) {
        return NO;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}

+ (NSString *)appVersion
{
    return [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleVersion"];
}

+ (NSString *)appShortVersion
{
    return [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)appDisplayName
{
    return [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleDisplayName"];
}

+ (NSString *)appBundleIdentifier
{
    return [[NSBundle mainBundle] bundleIdentifier];
}

@end
