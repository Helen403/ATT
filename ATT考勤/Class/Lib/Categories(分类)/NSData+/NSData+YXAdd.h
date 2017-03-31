/**
 Copyright (c) 2016-present, yxiang.
 All rights reserved.
 Description: 用于NSData的操作
 https://github.com/yxiangBeauty/Project.git
 */

#import <Foundation/Foundation.h>

@interface NSData (YXAdd)

#pragma mark - NSData -> NSString

+ (NSString *)stringFromData:(NSData *)aData;
- (NSString *)dataString;

#pragma mark - NSData -> NSDictionary

+ (NSDictionary *)dictionaryFromData:(NSData *)aData;
- (NSDictionary *)dataDictionary;

#pragma mark - md

- (NSString *)md2String;
- (NSString *)md4String;
- (NSString *)md5String;
- (NSData *)md2Data;
- (NSData *)md4Data;
- (NSData *)md5Data;


#pragma mark - 获取日
- (NSInteger)day:(NSDate *)date;
#pragma mark - 获取月
- (NSInteger)month:(NSDate *)date;
#pragma mark - 获取年
- (NSInteger)year:(NSDate *)date;
#pragma mark - 获取当月第一天周几
- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date;
#pragma mark - 获取当前月有多少天
- (NSInteger)totaldaysInMonth:(NSDate *)date;

@end
