//
//  NSArray+JPLeeExtensions.h
//  JPLeeOCDemo
//
//  Created by Admin on 2021/1/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (JPLeeExtensions)

- (NSString *)jsonString;
+ (NSArray *)arrayWithJsonString:(NSString *)json;
@end

NS_ASSUME_NONNULL_END
