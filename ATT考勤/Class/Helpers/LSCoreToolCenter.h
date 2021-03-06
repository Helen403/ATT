//
//  LSCoreToolCenter.h
//  LSCoreFramework
//
//  Created by 王隆帅 on 15/5/14.
//  Copyright (c) 2015年 王隆帅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <objc/runtime.h>
#import <AVFoundation/AVFoundation.h>
#import "lame.h"

@interface LSCoreToolCenter : NSObject

extern void ShowSuccessStatus(NSString *statues);
extern void ShowErrorStatus(NSString *statues);
extern void ShowMaskStatus(NSString *statues);
extern void ShowMessage(NSString *statues);
extern void ShowProgress(CGFloat progress);
extern void DismissHud(void);

+ (NSData *)audio_PCMtoMP3:(NSString *)recordUrl;
+ (NSString *)Base64StrWithMp3Data:(NSData *)data;
+(BOOL)isBlankString:(NSString *)string;
+(void)playMusic:(NSString *)urlMusic1;
+(NSString *)currentYearYMDHMSA;
+(NSInteger)getCurrentWeek;
+(NSString *)curDateMonth;

+(NSInteger)getCurrentWeekTmp:(NSString *)str;
+(NSInteger )getCurrentPreMonth:(NSInteger)i;

//插入数据库
+(void)insertSQLByStringKey:(NSString *)key Value:(NSString *)value;
//查询数据库
+(NSString *)querySQLByStringKey:(NSString *)key;
//删除数据库
+(void)deleteTable;


//计算文字的宽和高
+(CGSize) getSizeWithText:(NSString *)text fontSize:(CGFloat)fontSize;

//获取当天为星期几
+ (NSString*)currentWeek;

//获取年月日
+(NSString *)currentYear;




#pragma mark -
#pragma mark - 将xml(数组)转换成NSMutableArray (List<String>)
/**
 * 将xml(数组)转换成NSMutableArray
 * @param xml
 <string>fs</string>
 <string>fs</string>
 ...
 * @return NSMutableArray (List<String>)
 */
+(NSMutableArray*)xmlToArray:(NSString*)xml;

#pragma mark -
#pragma mark - 将标准的xml(实体)转换成NSMutableArray (List<class>)
/**
 * 把标准的xml(实体)转换成NSMutableArray
 * @param xml:
 <data xmlns="">
 <row><UserID>ff0f0704</UserID><UserName>fs</UserName></row>
 <row><UserID>ff0f0704</UserID><UserName>fs</UserName></row>
 ......
 </data>
 * @param class:
 User
 * @param rowRootName:
 row
 * @return NSMutableArray (List<class>)
 */
+(NSMutableArray*)xmlToArray:(NSString*)xml class:(Class)class rowRootName:rowRootName;

#pragma mark -
#pragma mark - 将标准的Json(实体)转换成NSMutableArray (List<class>)
/**
 * 把标准的xml(实体)转换成NSMutableArray
 * @param xml:
 [{"UserID":"ff0f0704","UserName":"fs"},
 {"UserID":"ff0f0704","UserName":"fs"},...]
 * @param class:
 User
 * @return NSMutableArray (List<class>)
 */
+(NSMutableArray*)jsonToArray:(NSString*)json class:(Class)class;


+(id)initWithXMLString:(NSString*)xml object:(id)object;
+(id)initWithJsonString:(NSString*)json object:(id)object;

+ (NSString *)changeJsonStringToTrueJsonString:(NSString *)json;

+(NSString *)appleIFA ;

+ (NSString *)randomUUID;

+ (NSString*)deviceVersion;

+(NSString *)phoneModel;

//获取年月日
+(NSMutableArray *)currentYearArr;

+(Boolean)isDayOrNight:(NSString *)str;

+(NSString *)curDate;

+(NSTimeInterval)getDateDiff:(NSString *)beginTime end:(NSString *)endTime;

+(NSString *)getDateAddMinuts:(NSString *)str time:(NSInteger )minute;


+(NSString *)currentYearType;

+(NSString *)internetStatus ;

+(NSString *)currentDateHMS;

+(NSString *)currentYearYMDHM;

+(NSTimeInterval)getDifferenceTime:(NSString *) beginTime endTime:(NSString *) endTime;

+(NSString *) getCurrentTime;

+(NSString *)currentYearMonth;

+(NSString *)curDateYear;
+(NSString *)curDateYMD;


/**
 *实现部分
 */
#pragma mark -- 获取日
+ (NSInteger)day:(NSDate *)date;

#pragma mark -- 获取月
+ (NSInteger)month:(NSDate *)date;

+ (NSInteger)month1;
#pragma mark -- 获取年
+ (NSInteger)year:(NSDate *)date;

#pragma mark -- 获得当前月份第一天星期几
+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date;
#pragma mark -- 获取当前月共有多少天

+ (NSInteger)totaldaysInMonth:(NSDate *)date;


+ (UIImage *)convertViewToImage:(UIView *)view;


+(NSString *)currentYearYM;
+(NSString *)getCurrentMonthTitle:(NSInteger)i;

+(NSMutableArray *)getCurrentMonthInfo:(NSInteger)i;

+(NSString *)currentYearY;

+(NSString *)getCurrentYMonth:(NSInteger)i;

//SOAP请求
+(void)SOAPData:(NSString *)url soapBody:(NSString *)soapBody success:(void (^)(NSString *result))success failure:(void(^)(NSError *error))failure;

+(NSDictionary *)getFilter:(NSString *)result filter:(NSString *)filter;

+(NSString *)getFilterStr:(NSString *)result filter1:(NSString *)filter1 filter2:(NSString *)filter2;

+(BOOL)PureLetters:(NSString*)str;

+(NSString *)getFormatter:(NSString *)str;
+(NSString *)getFormatterYMD:(NSString *)str;
+(NSString *)getFormatterYM:(NSString *)str;
+(NSString *) getCurrentTimeYMD;
+(NSString *)getFormatterYMDHM:(NSString *)str;

+ (NSInteger)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime;
+(NSString *)currentYearYMDHMS;
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
+(NSString *)nextYear:(NSInteger)i;
+(NSString *)nextMonth:(NSInteger)i;
+(NSString *)getFilterStr:(NSString *)result filter:(NSString *)filter;
+(NSString *) getCurrentD;

@end
