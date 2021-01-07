//
//  NSDictionary+JPLeeExtensions.h
//  JPLeeOCDemo
//
//  Created by Admin on 2021/1/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (JPLeeJSON)

- (NSString *)jsonString;
+ (NSDictionary *)dictWithJsonString:(NSString *)json;

@end

@interface NSDictionary(JPLeeSafe)

- (id)safeObjectForKey:(id)key;
- (int)intValueForKey:(id)key;
- (double)doubleValueForKey:(id)key;
- (NSString *)stringValueForKey:(id)key;

@end

@interface NSMutableDictionary(JPLeeSafe)

- (void)safeSetObject:(id)anObject forKey:(id)aKey;
- (void)setIntValue:(int)value forKey:(id)aKey;
- (void)setDoubleValue:(double)value forKey:(id)aKey;
- (void)setStringValueForKey:(NSString *)string forKey:(id)aKey;

@end

NS_ASSUME_NONNULL_END
