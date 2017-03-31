/**
 Copyright (c) 2016-present, yxiang.
 All rights reserved.
 Description: 用于NSDictionary的操作
 https://github.com/yxiangBeauty/Project.git
 */

#import <Foundation/Foundation.h>

@interface NSDictionary (YXAdd)

#pragma mark - NSDictionary -> JSON

+ (NSString *)convertToJson:(NSDictionary *)dict;
- (NSString *)convertToJson;

#pragma mark - NSDictionary -> NSData

+ (NSData *)returnDataWithDictionary:(NSDictionary *)dict;
- (NSData *)dictionaryData;

@end
