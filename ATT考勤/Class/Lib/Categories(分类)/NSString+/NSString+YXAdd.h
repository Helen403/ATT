/**
 Copyright (c) 2016-present, yxiang.
 All rights reserved.
 Description: 用于字符串的操作
 https://github.com/yxiangBeauty/Project.git
 */

#import <UIKit/UIKit.h>

@interface NSString (YXAdd)

/**
 根据最大宽度和字号获取NSString的size
 */
- (CGSize)sizeForMaxWidth:(CGFloat)max strFont:(UIFont *__nonnull)font;

#pragma mark - 数字格式化
// eg: 1234556.0012
typedef NS_ENUM(NSUInteger, NSNFormatStyle) {
    NSNFormatStyleNoStyle = kCFNumberFormatterNoStyle,                                                                  // > 1234556
    NSNFormatStyleDecimalStyle = kCFNumberFormatterDecimalStyle,                                                        // > 1,234,556.001
    NSNFormatStyleCurrencyStyle = kCFNumberFormatterCurrencyStyle,                                                      // > ￥1,234,556.00
    NSNFormatStylePercentStyle = kCFNumberFormatterPercentStyle,                                                        // > 123,455,600%
    NSNFormatStyleScientificStyle = kCFNumberFormatterScientificStyle,                                                  // > 1.2345560012E6
    NSNFormatStyleSpellOutStyle = kCFNumberFormatterSpellOutStyle,                                                      // > 一百二十三万四千五百五十六点〇〇一二
    NSNFormatStyleOrdinalStyle NS_ENUM_AVAILABLE(10_11, 9_0) = kCFNumberFormatterOrdinalStyle,                          // > 第123,4556
    NSNFormatStyleCurrencyISOCodeStyle NS_ENUM_AVAILABLE(10_11, 9_0) = kCFNumberFormatterCurrencyISOCodeStyle,          // > CNY1,234,556.00
    NSNFormatStyleCurrencyPluralStyle NS_ENUM_AVAILABLE(10_11, 9_0) = kCFNumberFormatterCurrencyPluralStyle,            // > 1,234,556.00人民币
    NSNFormatStyleCurrencyAccountingStyle NS_ENUM_AVAILABLE(10_11, 9_0) = kCFNumberFormatterCurrencyAccountingStyle,    // > ￥1,234,556.00
};
+ (NSString * _Nullable)formatStringForNumber:(NSNumber *_Nullable)number withStyle:(NSNFormatStyle)style;

#pragma mark - NSString -> NSData

+ (NSData *__nonnull)dataFromString:(NSString *__nonnull)aString;
- (NSData *__nonnull)stingData;

#pragma mark - JSON -> NSDictionary

+ (NSDictionary *__nonnull)dictionaryWithJsonString:(NSString *__nonnull)jsonString;
- (NSDictionary *__nonnull)dictionaryWithJsonString;

#pragma mark - Utils（工具方法）

/**********************************************************************************************
 **********************************************************************************************
 例如：正则判断、时间戳转化、md
 参考资料：http://blog.csdn.net/chaoyuan899/article/details/38583759
 **********************************************************************************************
 **********************************************************************************************/

/// 正则判断
/**
 邮箱格式
 */
+ (BOOL)isVaildEmailForString:(NSString *__nonnull)aString;
- (BOOL)isVaildEamil;

/**
 电话号
 */
+ (BOOL)isVaildTelphoneFroString:(NSString *__nonnull)aString;
- (BOOL)isVaildTelphone;

/**
 时间戳按要求转化为字符串
 */
+ (NSString *__nonnull)timeIntervalToString:(NSTimeInterval)timeInterval forFormat:(NSString *__nonnull)aFormat;

- (nullable NSString *)md2String;
- (nullable NSString *)md4String;
- (nullable NSString *)md5String;

@end
