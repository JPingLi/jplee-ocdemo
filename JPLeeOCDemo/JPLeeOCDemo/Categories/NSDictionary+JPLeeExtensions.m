//
//  NSDictionary+JPLeeExtensions.m
//  JPLeeOCDemo
//
//  Created by Admin on 2021/1/7.
//

#import "NSDictionary+JPLeeExtensions.h"


#define isValidKey(key) ((key) != nil && ![key isKindOfClass:[NSNull class]])
#define isValidValue(value) (((value) != nil) && ![value isKindOfClass:[NSNull class]])

@implementation NSDictionary (JPLeeExtensions)

- (NSString *)jsonString
{
    NSData *infoJsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    NSString *json = [[NSString alloc] initWithData:infoJsonData encoding:NSUTF8StringEncoding];
    return json;
}

+ (NSDictionary *)dictWithJsonString:(NSString*)json
{
    NSData *infoData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *info = [NSJSONSerialization JSONObjectWithData:infoData options:0 error:&error];
    if (error) {
        NSLog(@"Create dictionary from json string:%@ error:%@",json,error);
    }
    return info;
}

- (id)safeObjectForKey:(id)key {
    if (!isValidKey(key)) {
        return nil;
    }
    id obj = [self objectForKey:key];
    if(!isValidValue(obj))
        return nil;
    return obj;
}

- (int)intValueForKey:(id)key {
    id obj = [self safeObjectForKey:key];
    return [obj intValue];
}

- (double)doubleValueForKey:(id)key {
    id obj = [self safeObjectForKey:key];
    return [obj doubleValue];
}

- (NSString*)stringValueForKey:(id)key {
    id obj = [self safeObjectForKey:key];
    if ([obj respondsToSelector:@selector(stringValue)]) {
        return [obj stringValue];
    }
    
    return nil;
}

@end

@implementation NSMutableDictionary(JPLeeSafe)

- (void)safeSetObject:(id)anObject forKey:(id)aKey {
    if (!isValidKey(aKey)) {
        return;
    }
    if ([aKey isKindOfClass:[NSString class]]) {
        [self setValue:anObject forKey:aKey];
    }
    else {
        if (anObject != nil) {
            [self setObject:anObject forKey:aKey];
        }
        else {
            [self removeObjectForKey:aKey];
        }
    }
}

- (void)setIntValue:(int)value forKey:(id)aKey {
    [self safeSetObject:[[NSNumber numberWithInt:value] stringValue] forKey:aKey];
}

- (void)setDoubleValue:(double)value forKey:(id)aKey {
    [self safeSetObject:[[NSNumber numberWithDouble:value] stringValue] forKey:aKey];
}

- (void)setStringValueForKey:(NSString *)string forKey:(id)aKey {
    [self safeSetObject:string forKey:aKey];
}

@end
