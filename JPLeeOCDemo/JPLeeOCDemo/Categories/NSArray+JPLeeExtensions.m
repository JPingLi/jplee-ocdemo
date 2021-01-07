//
//  NSArray+JPLeeExtensions.m
//  JPLeeOCDemo
//
//  Created by Admin on 2021/1/7.
//

#import "NSArray+JPLeeExtensions.h"

@implementation NSArray (JPLeeExtensions)

- (NSString *)jsonString
{
    NSData *infoJsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    NSString *json = [[NSString alloc] initWithData:infoJsonData encoding:NSUTF8StringEncoding];
    return json;
}

+ (NSArray *)arrayWithJsonString:(NSString *)json
{
    NSData *infoData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:infoData options:0 error:&error];
    if (error) {
        NSLog(@"Create array from json string:%@ error:%@",json,error);
    }
    return array;
}

@end
