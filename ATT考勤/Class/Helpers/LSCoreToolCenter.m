//
//  LSCoreToolCenter.m
//  LSCoreFramework
//
//  Created by 王隆帅 on 15/5/14.
//  Copyright (c) 2015年 王隆帅. All rights reserved.
//

#import "LSCoreToolCenter.h"

#import "SDWebImageManager.h"
#import "SDWebImageCompat.h"
#import "SVProgressHUD.h"
#import <AVFoundation/AVFoundation.h>
#import "GDataXMLNode.h"
#import "sys/utsname.h"
#import "ZJProgressHUD.h"
#import "XMLDictionary.h"


#define HQDateFormatter @"yyyy-MM-dd HH:mm:ss"

@implementation LSCoreToolCenter

+ (void)load{
    
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setInfoImage:nil];
}

void ShowSuccessStatus(NSString *statues){
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showSuccessWithStatus:statues];
        });
    }else{
        [SVProgressHUD showSuccessWithStatus:statues];
    }
}


void ShowMessage(NSString *statues){
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showInfoWithStatus:statues];
        });
    }else{
        [SVProgressHUD showInfoWithStatus:statues];
    }
}

void ShowErrorStatus(NSString *statues){
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
//            [SVProgressHUD showErrorWithStatus:statues];
            
            
            //            [SVProgressHUD showProgress:0.5 status:@"上传"];
            [ZJProgressHUD showErrorWithStatus:statues andAutoHideAfterTime:0.6f];
        });
    }else{
        
        // [SVProgressHUD showErrorWithStatus:statues];
        [ZJProgressHUD showErrorWithStatus:statues andAutoHideAfterTime:0.6f];
        
    }
    
}


void ShowMaskStatus(NSString *statues){
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //            [ZJProgressHUD showStatus:statues andAutoHideAfterTime:1.0f];
            
            [SVProgressHUD showWithStatus:statues];
        });
    }else{
        
        [SVProgressHUD showWithStatus:statues];
        //         [ZJProgressHUD showStatus:statues andAutoHideAfterTime:1.0f];
    }
}

void ShowProgress(CGFloat progress){
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [SVProgressHUD showProgress:progress];
            
        });
    }else{
        [SVProgressHUD showProgress:progress];
    }
}

void DismissHud(void){
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [ZJProgressHUD hideAllHUDs];
        });
    }else{
        [SVProgressHUD dismiss];
        [ZJProgressHUD hideAllHUDs];
    }
}


+(void)insertSQLByStringKey:(NSString *)key Value:(NSString *)value{
    
    
    //1.获得数据库文件的路径
    NSString *fileName =[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject] stringByAppendingString:DBNAME];
    
    //2.获得数据库
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    
    //3.使用如下语句，如果打开失败，可能是权限不足或者资源不足。通常打开完操作操作后，需要调用 close 方法来关闭数据库。在和数据库交互 之前，数据库必须是打开的。如果资源或权限不足无法打开或创建数据库，都会导致打开失败。
    if ([db open])
    {
        //4.创表
        [db executeUpdate:@"create table if not exists TableHelen(id integer primary key autoincrement,url text,value text);"];
        
        //1.executeUpdate:不确定的参数用？来占位（后面参数必须是oc对象，；代表语句结束）
        [db executeUpdate:@"INSERT INTO TableHelen (url, value) VALUES (?,?);",key,value];
    }
    [db close];
}


+(NSString *)querySQLByStringKey:(NSString *)key{
    NSString *result=@"";
    
    
    //1.获得数据库文件的路径
    NSString *fileName =[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject] stringByAppendingString:DBNAME];
    
    //2.获得数据库
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    
    
    //3.使用如下语句，如果打开失败，可能是权限不足或者资源不足。通常打开完操作操作后，需要调用 close 方法来关闭数据库。在和数据库交互 之前，数据库必须是打开的。如果资源或权限不足无法打开或创建数据库，都会导致打开失败。
    if ([db open])
    {
        //根据条件查询
        FMResultSet *resultSet = [db executeQuery:@"select * from TableHelen where url=?;",key];
        //遍历结果集合
        
        while ([resultSet  next]){
            result = [resultSet stringForColumn:@"value"];
        }
        
    }
    
    [db close];
    
    return result;
    
}

+(void)deleteTable{
    //1.获得数据库文件的路径
    NSString *fileName =[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject] stringByAppendingString:DBNAME];
    
    //2.获得数据库
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    if ([db open]){
        //如果表格存在 则销毁
        [db  executeUpdate:@"drop table if exists TableHelen;"];
    }
    [db close];
    
}


//计算文字的宽和高
+(CGSize) getSizeWithText:(NSString *)text fontSize:(CGFloat)fontSize
{
    CGFloat font =SizeScaleW*fontSize;
    CGSize size=[text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:font]}];
    
    //ios系统大于7
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0) {
        size=[text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]}];
    }else{
        NSAttributedString *attributeSting = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]}];
        size = [attributeSting size];
    }
    return size;
}



//获取当天为星期几
+ (NSString*)currentWeek{
    NSString *weekDayStr = nil;
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSString *str = [self description];
    if (str.length >= 10) {
        NSString *nowString = [str substringToIndex:10];
        NSArray *array = [nowString componentsSeparatedByString:@"-"];
        if (array.count == 0) {
            array = [nowString componentsSeparatedByString:@"/"];
        }
        if (array.count >= 3) {
            NSInteger year = [[array objectAtIndex:0] integerValue];
            NSInteger month = [[array objectAtIndex:1] integerValue];
            NSInteger day = [[array objectAtIndex:2] integerValue];
            [comps setYear:year];
            [comps setMonth:month];
            [comps setDay:day];
        }
    }
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *_date = [gregorian dateFromComponents:comps];
    NSDateComponents *weekdayComponents = [gregorian components:NSCalendarUnitWeekday fromDate:_date];
    NSInteger week = [weekdayComponents weekday];
    week ++;
    switch (week) {
        case 1:
            weekDayStr = @"星期日";
            break;
        case 2:
            weekDayStr = @"星期一";
            break;
        case 3:
            weekDayStr = @"星期二";
            break;
        case 4:
            weekDayStr = @"星期三";
            break;
        case 5:
            weekDayStr = @"星期四";
            break;
        case 6:
            weekDayStr = @"星期五";
            break;
        case 7:
            weekDayStr = @"星期六";
            break;
        default:
            weekDayStr = @"";
            break;
    }
    return weekDayStr;
    
}


//获取年月日
+(NSString *)currentYear{
    
    NSCalendar * cal = [NSCalendar currentCalendar];
    
    NSUInteger unitFlags = NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear;
    
    NSDateComponents * conponent = [cal components:unitFlags fromDate:[NSDate date]];
    NSInteger year=[conponent year];
    NSInteger month=[conponent month];
    NSInteger day=[conponent day];
    NSString * nsDateString= [NSString stringWithFormat:@"%4ld年%2ld月%2ld日",(long)year,(long)month,(long)day];
    return nsDateString;
}

//获取年月日
+(NSString *)currentYearMonth{
    
    NSCalendar * cal = [NSCalendar currentCalendar];
    
    NSUInteger unitFlags = NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear;
    
    NSDateComponents * conponent = [cal components:unitFlags fromDate:[NSDate date]];
    NSInteger year=[conponent year];
    NSInteger month=[conponent month];
   
    NSString * nsDateString= [NSString stringWithFormat:@"%4ld年%2ld月",(long)year,(long)month];
    return nsDateString;
}

//获取年月日
+(NSString *)curDate{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
   
   NSString *str = [formatter stringFromDate:[NSDate date]];
    return str;
}

//获取年月日
+(NSString *)curDateYMD{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    
    NSString *str = [formatter stringFromDate:[NSDate date]];
    return str;
}

+(NSString *)curDateYear{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    
    NSString *str = [formatter stringFromDate:[NSDate date]];
    return str;
}

+(NSString *)currentYearType{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *str = [formatter stringFromDate:[NSDate date]];
    return str;

}

+(NSString *)currentYearYMDHM{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString *str = [formatter stringFromDate:[NSDate date]];
    return str;
    
}

+(NSString *)currentYearYM{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    
    NSString *str = [formatter stringFromDate:[NSDate date]];
    return str;
}

+(NSString *)currentYearY{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-"];
    
    NSString *str = [formatter stringFromDate:[NSDate date]];
    return str;
}


+(NSString *)currentDateHMS{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    
    NSString *str = [formatter stringFromDate:[NSDate date]];
    return str;
    
}

//获取年月日
+(NSMutableArray *)currentYearArr{
    
    NSCalendar * cal = [NSCalendar currentCalendar];
    
    NSUInteger unitFlags = NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear;
    
    NSDateComponents * conponent = [cal components:unitFlags fromDate:[NSDate date]];
    NSInteger year=[conponent year];
    NSInteger month=[conponent month];
    NSInteger day=[conponent day];
    //    NSString * nsDateString= [NSString stringWithFormat:@"%4ld年%2ld月%2ld日",(long)year,(long)month,(long)day];
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:[NSString stringWithFormat:@"%4ld",(long)year]];
    [arr addObject:[NSString stringWithFormat:@"%2ld",(long)month]];
    [arr addObject:[NSString stringWithFormat:@"%2ld",(long)day]];
    return arr;
}


+(Boolean)isDayOrNight:(NSString *)str{
    
    NSArray *arr = [str componentsSeparatedByString:@":"];
    
    NSInteger hour = [arr[0] integerValue];
    if ((hour >= 0 && hour < 6) || (hour >= 18 && hour < 24)) {
        return true;
    } else {
        return false;
    }
}


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
+(NSMutableArray*)xmlToArray:(NSString*)xml{
    
    NSMutableArray *retVal = [[NSMutableArray alloc] init] ;
    xml = [NSString stringWithFormat:@"<data>%@</data>",xml];
    GDataXMLDocument *root = [[GDataXMLDocument alloc] initWithXMLString:xml options:0 error:nil] ;
    GDataXMLElement *rootEle = [root rootElement];
    for (int i=0; i <[rootEle childCount]; i++) {
        GDataXMLNode *item = [rootEle childAtIndex:i];
        [retVal addObject:item.stringValue];
    }
    return retVal;
}




#pragma mark -
#pragma mark - 将标准的xml(实体)转换成NSMutableArray (List<class>)
/**
 * 将标准的xml(实体)转换成NSMutableArray
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
+(NSMutableArray*)xmlToArray:(NSString*)xml class:(Class)class rowRootName:rowRootName{
    
    NSMutableArray *retVal = [NSMutableArray array];
    xml = [NSString stringWithFormat:@"<data>%@</data>",xml];
    
    GDataXMLDocument *root = [[GDataXMLDocument alloc] initWithXMLString:xml options:0 error:nil];
    GDataXMLElement *rootEle = [root rootElement];
    
    NSArray *rows = [rootEle elementsForName:rowRootName];
    
    for (GDataXMLElement *row in rows) {
        id object = [[class alloc] init];
        object = [self initWithXMLString:row.XMLString object:object];
        [retVal addObject:object];
        
    }
    return retVal;
}

/**
 * 将传递过来的实体赋值
 * @param xml(忽略实体属性大小写差异):
 <row><UserID>ff0f0704</UserID><UserName>fs</UserName></row>
 * @param class:
 User @property userName,userID;
 * @return class
 */
+(id)initWithXMLString:(NSString*)xml object:(id)object{
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([object class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        NSString *value = [self setXMLProperty:xml propertyName:propertyName];
        [object setValue:value forKey:propertyName];
    }
    free(properties);
    
    return object;
}

/**
 * 通过正则将传递过来的实体赋值
 * @param content(忽略实体属性大小写差异):
 <row><UserID>ff0f0704</UserID><UserName>fs</UserName></row>
 * @param propertyName:
 userID
 * @return NSString
 ff0f0704
 */
+(NSString*)setXMLProperty:(NSString*)value propertyName:(NSString*)propertyName {
    
    NSString *retVal = @"";
    NSString *patternString = [NSString stringWithFormat:@"(?<=<%@>)(.*)(?=</%@>)",propertyName,propertyName];
    // CaseInsensitive:不区分大小写比较
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:patternString options:NSRegularExpressionCaseInsensitive error:nil];
    if (regex) {
        NSTextCheckingResult *firstMatch = [regex firstMatchInString:value options:NSCaseInsensitiveSearch range:NSMakeRange(0, [value length])];
        if (firstMatch) {
            retVal = [value substringWithRange:firstMatch.range];
        }
    }
    return retVal;
}

#pragma mark -
#pragma mark - 将标准的Json(实体)转换成NSMutableArray (List<class>)
/**
 * 将标准的Json(实体)转换成NSMutableArray
 * @param xml:
 [{"UserID":"ff0f0704","UserName":"fs"},
 {"UserID":"ff0f0704","UserName":"fs"},...]
 * @param class:
 User
 * @return NSMutableArray (List<class>)
 */
+(NSMutableArray*)jsonToArray:(NSString*)json class:(Class)class {
    
    NSMutableArray *retVal = [[NSMutableArray alloc] init] ;
    NSString *patternString = @"\\{.*?\\}";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:patternString options:0 error:nil];
    if (regex) {
        NSArray *match = [regex matchesInString:json options:0 range:NSMakeRange(0, [json length])];
        if (match) {
            for (NSTextCheckingResult *result in match) {
                NSString *jsonRow = [json substringWithRange:result.range];
                id object = [[class alloc] init];
                object = [self initWithJsonString:jsonRow object:object];
                [retVal addObject:object];
                
            }
        }
    }
    return retVal;
}

/**
 * 将传递过来的实体赋值
 * @param xml(忽略实体大小写差异):
 {"UserID":"ff0f0704","UserName":"fs"}
 * @param class:
 User @property userName,userID;
 * @return class
 */
+(id)initWithJsonString:(NSString*)json object:(id)object{
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([object class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        NSString *value = [self setJsonProperty:json propertyName:propertyName];
        [object setValue:value forKey:propertyName];
    }
    free(properties);
    
    return object;
}

/**
 * 通过正则将传递过来的实体赋值
 * @param content(忽略实体大小写差异):
 {"UserID":"ff0f0704","UserName":"fs"}
 * @param propertyName:
 userID
 * @return NSString
 ff0f0704
 */
+(NSString*)setJsonProperty:(NSString*)value propertyName:(NSString*)propertyName {
    
    NSString *retVal = @"";
    //    NSString *patternString = [NSString stringWithFormat:@"(?<=\"%@\":\")[^\",]*",propertyName];
    //    // CaseInsensitive:不区分大小写比较
    //    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:patternString options:NSRegularExpressionCaseInsensitive error:nil];
    //    if (regex) {
    //        NSTextCheckingResult *firstMatch = [regex firstMatchInString:value options:NSCaseInsensitiveSearch range:NSMakeRange(0, [value length])];
    //        if (firstMatch) {
    //            retVal = [value substringWithRange:firstMatch.range];
    //        }
    //    }
    return retVal;
}

//把没有双引号和用了单引号的json字符串转化为标准格式字符串;
+ (NSString *)changeJsonStringToTrueJsonString:(NSString *)json
{
    // 将没有双引号的替换成有双引号的
    NSString *validString = [json stringByReplacingOccurrencesOfString:@"(\\w+)\\s*:([^A-Za-z0-9_])"
                                                            withString:@"\"$1\":$2"
                                                               options:NSRegularExpressionSearch
                                                                 range:NSMakeRange(0, [json length])];
    
    
    //把'单引号改为双引号"
    validString = [validString stringByReplacingOccurrencesOfString:@"([:\\[,\\{])'"
                                                         withString:@"$1\""
                                                            options:NSRegularExpressionSearch
                                                              range:NSMakeRange(0, [validString length])];
    validString = [validString stringByReplacingOccurrencesOfString:@"'([:\\],\\}])"
                                                         withString:@"\"$1"
                                                            options:NSRegularExpressionSearch
                                                              range:NSMakeRange(0, [validString length])];
    
    //再重复一次 将没有双引号的替换成有双引号的
    validString = [validString stringByReplacingOccurrencesOfString:@"([:\\[,\\{])(\\w+)\\s*:"
                                                         withString:@"$1\"$2\":"
                                                            options:NSRegularExpressionSearch
                                                              range:NSMakeRange(0, [validString length])];
    return validString;
}


+(NSString *)appleIFA {
    NSString *ifa = nil;
    Class ASIdentifierManagerClass = NSClassFromString(@"ASIdentifierManager");
    if (ASIdentifierManagerClass) { // a dynamic way of checking if AdSupport.framework is available
        SEL sharedManagerSelector = NSSelectorFromString(@"sharedManager");
        id sharedManager = ((id (*)(id, SEL))[ASIdentifierManagerClass methodForSelector:sharedManagerSelector])(ASIdentifierManagerClass, sharedManagerSelector);
        SEL advertisingIdentifierSelector = NSSelectorFromString(@"advertisingIdentifier");
        NSUUID *advertisingIdentifier = ((NSUUID* (*)(id, SEL))[sharedManager methodForSelector:advertisingIdentifierSelector])(sharedManager, advertisingIdentifierSelector);
        ifa = [advertisingIdentifier UUIDString];
    }
    return ifa;
}

+ (NSString *)randomUUID {
    if(NSClassFromString(@"NSUUID")) { // only available in iOS >= 6.0
        return [[NSUUID UUID] UUIDString];
    }
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef cfuuid = CFUUIDCreateString(kCFAllocatorDefault, uuidRef);
    CFRelease(uuidRef);
    NSString *uuid = [((__bridge NSString *) cfuuid) copy];
    CFRelease(cfuuid);
    return uuid;
}


+ (void)setValue:(NSString *)value forKey:(NSString *)key inService:(NSString *)service {
    NSMutableDictionary *keychainItem = [[NSMutableDictionary alloc] init];
    keychainItem[(__bridge id)kSecClass] = (__bridge id)kSecClassGenericPassword;
    keychainItem[(__bridge id)kSecAttrAccessible] = (__bridge id)kSecAttrAccessibleAlways;
    keychainItem[(__bridge id)kSecAttrAccount] = key;
    keychainItem[(__bridge id)kSecAttrService] = service;
    keychainItem[(__bridge id)kSecValueData] = [value dataUsingEncoding:NSUTF8StringEncoding];
    SecItemAdd((__bridge CFDictionaryRef)keychainItem, NULL);
}


//+(NSString *)identifier
//{
//    NSString *key = @"com.app.keychain.uuid";
//    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:key accessGroup:nil];
//
//    NSString *strUUID = [keychainItem objectForKey:(__bridge id)kSecValueData];
//
//    if (strUUID.length <= 0) {
//        strUUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
//
//        [keychainItem setObject:@"uuid" forKey:(__bridge id)kSecAttrAccount];
//        [keychainItem setObject:strUUID forKey:(__bridge id)kSecValueData];
//    }
//
//    return strUUID;
//}


+(NSString *)phoneModel{
    return [[UIDevice currentDevice] model];
}

/**
 *  设备版本
 *
 *  @return e.g. iPhone 5S
 */
+ (NSString*)deviceVersion
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,3"])    return @"iPhoneSE";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhoneSE";
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"iPhone7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"iPhone7Plus";
    
    
    
    //iPod
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    
    //iPad
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2 (32nm)";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad mini (GSM)";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad mini (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3(WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3(CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3(4G)";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4 (4G)";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    if ([deviceString isEqualToString:@"iPad4,4"]
        ||[deviceString isEqualToString:@"iPad4,5"]
        ||[deviceString isEqualToString:@"iPad4,6"])      return @"iPad mini 2";
    
    if ([deviceString isEqualToString:@"iPad4,7"]
        ||[deviceString isEqualToString:@"iPad4,8"]
        ||[deviceString isEqualToString:@"iPad4,9"])      return @"iPad mini 3";
    
    return deviceString;
}

//获取当前时间yyyyMMddHHmmss
+(NSString *) getCurrentTime{

    NSDate *date=[[NSDate alloc] init];

    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];

    [formatter  setDateFormat:HQDateFormatter];

    NSString *curTime=[formatter stringFromDate:date];

    return curTime;
}

+(NSString *) getCurrentTimeYMD{
    
    NSDate *date=[[NSDate alloc] init];
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    
    [formatter  setDateFormat:@"yyyy-MM-dd"];
    
    NSString *curTime=[formatter stringFromDate:date];
    
    return curTime;
}

+(NSString *)getFormatter:(NSString *)str {
    
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *theDate = [formatter dateFromString:str];
    [formatter setDateFormat:@"MM月dd日"];
    return [formatter stringFromDate:theDate];
}

+(NSString *)getFormatterYM:(NSString *)str {
    
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"yyyy-MM"];
    
    NSDate *theDate = [formatter dateFromString:str];
    [formatter setDateFormat:@"yyyy年MM月"];
    return [formatter stringFromDate:theDate];
}

+(NSString *)getFormatterYMD:(NSString *)str {
    
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *theDate = [formatter dateFromString:str];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    return [formatter stringFromDate:theDate];
}


+(NSString *)getDateAddMinuts:(NSString *)str time:(NSInteger )minute{

    NSDate* theDate;
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:HQDateFormatter];

    NSDate *date = [formatter dateFromString:str];
    theDate = [date dateByAddingTimeInterval:minute];
    
    return [formatter stringFromDate:theDate];
    
}

+(NSTimeInterval)getDifferenceTime:(NSString *) beginTime endTime:(NSString *) endTime{

    NSDateFormatter *dateFormatter= [[NSDateFormatter alloc]init];
    
    //要注意格式一定要统一
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];

    
    NSDate *beginD=[dateFormatter dateFromString:beginTime];

    NSDate *endD=[dateFormatter dateFromString:endTime];
    
    NSTimeInterval value=[endD timeIntervalSinceDate:beginD];
    
    return value/60;
}

+(NSTimeInterval)getDateDiff:(NSString *)beginTime end:(NSString *)endTime{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    
    //要注意格式一定要统一
    
    [dateFormatter setDateFormat:HQDateFormatter];
    
    NSDate *beginD=[dateFormatter dateFromString:beginTime];
    
    NSDate *endD=[dateFormatter dateFromString:endTime];
    
    NSTimeInterval value=[endD timeIntervalSinceDate:beginD];
    return value;
}


#pragma mark - 获取网络状态
+(NSString *)internetStatus {
    
    Reachability *reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    NSString *net = @"WIFI";
    switch (internetStatus) {
        case ReachableViaWiFi:
            net = @"WIFI";
            break;
            
        case ReachableViaWWAN:
            net = @"wwan";
            break;
            
        case NotReachable:
            net = @"notReachable";
            
        default:
            break;
    }
    
    return net;
}


/**
 *实现部分
 */
#pragma mark -- 获取日
+ (NSInteger)day:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return components.day;
}

#pragma mark -- 获取月
+ (NSInteger)month:(NSDate *)date{
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return components.month;
}
+ (NSInteger)month1{
    NSDateComponents * conponent = [[NSCalendar currentCalendar] components: NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:[NSDate date]];
    
    return [conponent month];
}

#pragma mark -- 获取年
+ (NSInteger)year:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return components.year;
}

#pragma mark -- 获得当前月份第一天星期几
+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //设置每周的第一天从周几开始,默认为1,从周日开始
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    //若设置从周日开始算起则需要减一,若从周一开始算起则不需要减
    return firstWeekday - 1;
}
#pragma mark -- 获取当前月共有多少天

+ (NSInteger)totaldaysInMonth:(NSDate *)date{
    NSRange daysInLastMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInLastMonth.length;
}



// i为0就是当月  i为－1就是上个月 i为1 就是下个月
+(NSMutableArray *)getCurrentMonthInfo:(NSInteger)i{
    NSMutableArray *arrTmp = [NSMutableArray array];
    int yearTmp = [[LSCoreToolCenter curDateYear] intValue];
    
    //获取月份
    int mounth = ((int)[LSCoreToolCenter month1] + i)%12;
    NSInteger d = (i+(int)[LSCoreToolCenter month1])/12;
    if (mounth == 0&&d==1) {
        d=0;
    }
    if (mounth == 0&&d>1) {
        d = (i+(int)[LSCoreToolCenter month1])/12-1;
    }
    
    NSDateComponents *components = [[NSDateComponents alloc]init];
    //获取下个月的年月日信息,并将其转为date
    components.month = mounth;
    components.year = yearTmp+d + mounth/12;
    components.day = 1;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *nextDate = [calendar dateFromComponents:components];
    //获取该月第一天星期几
    NSInteger firstDayInThisMounth = [LSCoreToolCenter firstWeekdayInThisMonth:nextDate];
    //该月的有多少天daysInThisMounth
    NSInteger daysInThisMounth = [LSCoreToolCenter totaldaysInMonth:nextDate];
    NSString *string = [[NSString alloc]init];
    for (int j = 0; j < (daysInThisMounth > 29 && (firstDayInThisMounth == 6 || firstDayInThisMounth ==5) ? 42 : 35) ; j++) {
        
        if (j < firstDayInThisMounth || j > daysInThisMounth + firstDayInThisMounth - 1) {
            string = @"";
            [arrTmp addObject:string];
        }else{
            string = [NSString stringWithFormat:@"%ld",j - firstDayInThisMounth + 1];
            [arrTmp addObject:string];
        }
    }
    
    if (daysInThisMounth==30&&(firstDayInThisMounth ==5)) {
        for(int i = 35;i<arrTmp.count;i++){
            [arrTmp removeObjectAtIndex:i];
        }
    }
    
    return arrTmp;
}



//或当前月标题
+(NSString *)getCurrentMonthTitle:(NSInteger)i{
    int yearTmp = [[LSCoreToolCenter curDateYear] intValue];
    
    //获取月份
    int mounth = ((int)[LSCoreToolCenter month1] + i)%12;
    NSInteger d = (i+(int)[LSCoreToolCenter month1])/12;
    if (mounth==0&&d==1) {
        d=0;
    }
    if (mounth==0&&d>1) {
        d = (i+(int)[LSCoreToolCenter month1])/12-1;
    }
    NSDateComponents *components = [[NSDateComponents alloc]init];
    //获取下个月的年月日信息,并将其转为date
    components.month = mounth;
    components.year = yearTmp+d + mounth/12;
    components.day = 1;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *nextDate = [calendar dateFromComponents:components];
    NSDateFormatter *dateFormattor = [[NSDateFormatter alloc] init];
    [dateFormattor setDateFormat:@"MM"];
    
    NSString *str = [dateFormattor stringFromDate:nextDate];
    return [NSString stringWithFormat:@"%ld年%@月",yearTmp+d,str];;
}

+(NSString *)getCurrentYMonth:(NSInteger)i{
    int yearTmp = [[LSCoreToolCenter curDateYear] intValue];
    
    //获取月份
    int mounth = ((int)[LSCoreToolCenter month1] + i)%12;
    NSInteger d = (i+(int)[LSCoreToolCenter month1])/12;
    if (mounth==0&&d==1) {
        d=0;
    }
    if (mounth==0&&d>1) {
        d = (i+(int)[LSCoreToolCenter month1])/12-1;
    }
    NSDateComponents *components = [[NSDateComponents alloc]init];
    //获取下个月的年月日信息,并将其转为date
    components.month = mounth;
    components.year = yearTmp+d + mounth/12;
    components.day = 1;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *nextDate = [calendar dateFromComponents:components];
    NSDateFormatter *dateFormattor = [[NSDateFormatter alloc] init];
    [dateFormattor setDateFormat:@"MM"];
    
    NSString *str = [dateFormattor stringFromDate:nextDate];
    return [NSString stringWithFormat:@"%ld-%@",yearTmp+d,str];;
}


//SOAP请求
+(void)SOAPData:(NSString *)url soapBody:(NSString *)soapBody success:(void (^)(NSString *result))success failure:(void(^)(NSError *error))failure {
    
    NSString *soapStr = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                         <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"\
                         xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"\
                         >\
                         <soap:Body>%@</soap:Body>\
                         </soap:Envelope>",soapBody];
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    // 访问方式
    [request setHTTPMethod:@"POST"];
    
    // body内容
    [request setHTTPBody:[soapStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *result = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
        success(result);
        if (error) {
            failure(error);
        }
    }];
    
    [task resume];
}

+(NSDictionary *)getFilter:(NSString *)result filter:(NSString *)filter{
    
    if(result.length==0){
        return nil;
    }
    
    NSString *str1 = [NSString stringWithFormat:@"<%@>",filter];
    NSRange range1 = [result rangeOfString:str1];//匹配得到的下标
    NSString *str2 = [NSString stringWithFormat:@"</%@>",filter];
    NSRange range2 = [result rangeOfString:str2];//匹配得到的下标
    NSDictionary *xmlDoc;
    
    @try {
        result = [result substringToIndex:range2.location+range2.length];
        result = [result substringFromIndex:range1.location];
        
        xmlDoc = [NSDictionary dictionaryWithXMLString:result];
    } @catch (NSException *exception) {
        xmlDoc = nil;
        ShowMessage(@"请检查网络");
    } @finally {
        
    }
    return xmlDoc;
}



+(NSString *)getFilterStr:(NSString *)result filter1:(NSString *)filter1 filter2:(NSString *)filter2{
    if(result.length==0){
        return @"";
    }
    
    NSRange range1 = [result rangeOfString:filter1];//匹配得到的下标
    NSRange range2 = [result rangeOfString:filter2];//匹配得到的下标
    @try {
        result = [result substringToIndex:range2.location];
        result = [result substringFromIndex:range1.location+range1.length];
    } @catch (NSException *exception) {
        result = @"";
       
    } @finally {
        
    }
    return result;
}


+(BOOL)PureLetters:(NSString*)str{
    
    for(int i=0;i<str.length;i++){
        
        unichar c=[str characterAtIndex:i];
        
        if((c<'A'||c>'Z')&&(c<'a'||c>'z'))
            
            return NO;
        
    }
    
    return YES;
    
}



+(UIImage*)convertViewToImage:(UIView*)v{
    CGSize s = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
