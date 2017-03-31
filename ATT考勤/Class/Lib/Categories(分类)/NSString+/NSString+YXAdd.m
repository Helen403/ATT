/**
 Copyright (c) 2016-present, yxiang.
 All rights reserved.
 Description: 用于字符串的操作
 https://github.com/yxiangBeauty/Project.git
 */

#import "NSString+YXAdd.h"
#import "NSData+YXAdd.h"

@implementation NSString (YXAdd)

- (CGSize)sizeForMaxWidth:(CGFloat)max strFont:(UIFont *)font
{
    CGSize size = CGSizeZero;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) { // iOS7及往后版本
        size = [self boundingRectWithSize:CGSizeMake(max, 0)
                                  options:NSStringDrawingUsesLineFragmentOrigin
                               attributes:@{NSFontAttributeName : font}
                                  context:nil].size;
    } else { // iOS6
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        size = [self sizeWithFont:font];
#pragma GCC diagnostic pop
    }
    return size;
}
#pragma mark - 数字格式化

+ (NSString *_Nullable)formatStringForNumber:(NSNumber *_Nullable)number withStyle:(NSNFormatStyle)style
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    formatter.numberStyle = (NSNumberFormatterStyle)style;
    NSString *newAmount = [formatter stringFromNumber:number];
    return newAmount;
}

#pragma mark - NSString -> NSData

+ (NSData *)dataFromString:(NSString *)aString
{
    if (!aString) return nil;
    return [aString dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSData *)stingData
{
    return [self.class dataFromString:self];
}

#pragma mark - JSON -> NSDictionary

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString stingData];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

- (NSDictionary *)dictionaryWithJsonString
{
    return [self.class dictionaryWithJsonString:self];
}

#pragma mark - Utils（工具方法）

+ (BOOL)isVaildEmailForString:(NSString *)aString
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:aString];
}
- (BOOL)isVaildEamil
{
    return [self.class isVaildEmailForString:self];
}

+ (BOOL)isVaildTelphoneFroString:(NSString *)aString
{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    return  [regextestmobile evaluateWithObject:aString]   ||
    [regextestphs evaluateWithObject:aString]      ||
    [regextestct evaluateWithObject:aString]       ||
    [regextestcu evaluateWithObject:aString]       ||
    [regextestcm evaluateWithObject:aString];
}

- (BOOL)isVaildTelphone
{
    return [self.class isVaildTelphoneFroString:self];
}

+ (NSString *)timeIntervalToString:(NSTimeInterval)timeInterval forFormat:(NSString *)aFormat
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = aFormat;
    NSDate * confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeInterval/1000.f];
    return [formatter stringFromDate:confromTimesp];
}

- (NSString *)md2String
{
    return [[self stingData] md2String];
}
- (NSString *)md4String
{
    return [[self stingData] md4String];
}
- (NSString *)md5String
{
    return [[self stingData] md5String];
}

@end
