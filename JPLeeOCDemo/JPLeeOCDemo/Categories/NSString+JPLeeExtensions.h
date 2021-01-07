//
//  NSString+JPLeeExtensions.h
//  JPLeeOCDemo
//
//  Created by Admin on 2021/1/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (JPLeeExtensions)

- (BOOL)isEmpty;
- (NSString *)trim;
- (NSString *)urlEncode;
- (NSString *)urlDecode;

- (NSString *)hash_md5;
- (NSString *)hash_sha1;

- (BOOL)validatePhoneNum;
- (BOOL)validateEmail;
- (BOOL)validateIdentityCard;

+ (NSString *)appVersion;
+ (NSString *)appShortVersion;
+ (NSString *)appDisplayName;
+ (NSString *)appBundleIdentifier;
@end

NS_ASSUME_NONNULL_END
