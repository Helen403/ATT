//
//  LSCoreToolCenter.m
//  LSCoreFramework
//
//  Created by 王隆帅 on 15/5/14.
//  Copyright (c) 2015年 王隆帅. All rights reserved.
//

#import "LSCoreToolCenter.h"

#import <SDWebImageManager.h>
#import <SDWebImageCompat.h>
#import <SVProgressHUD.h>
#import <AVFoundation/AVFoundation.h>


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
            [SVProgressHUD showErrorWithStatus:statues];
            [SVProgressHUD showProgress:0.5 status:@"上传" maskType:SVProgressHUDMaskTypeGradient];
            
        });
    }else{
        [SVProgressHUD showErrorWithStatus:statues];
    }
}


void ShowMaskStatus(NSString *statues){
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showWithStatus:statues maskType:SVProgressHUDMaskTypeGradient];
        });
    }else{
        [SVProgressHUD showWithStatus:statues maskType:SVProgressHUDMaskTypeGradient];
    }
}

void ShowProgress(CGFloat progress){
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showProgress:progress maskType:SVProgressHUDMaskTypeGradient];
        });
    }else{
        [SVProgressHUD showProgress:progress maskType:SVProgressHUDMaskTypeGradient];
    }
}

void DismissHud(void){
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }else{
        [SVProgressHUD dismiss];
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
        
        while ([resultSet  next])
            
        {
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
    if ([db open])
    {
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
//+(NSString *)currentYearLine{
//    
//    NSCalendar * cal = [NSCalendar currentCalendar];
//    
//    NSUInteger unitFlags = NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear;
//    
//    NSDateComponents * conponent = [cal components:unitFlags fromDate:[NSDate date]];
//    NSInteger year=[conponent year];
//    NSInteger month=[conponent month];
//    NSInteger day=[conponent day];
//    NSString * nsDateString= [NSString stringWithFormat:@"%4ld-%2ld-%2ld",(long)year,(long)month,(long)day];
//    return nsDateString;
//}


//#pragma mark - ScaleSize
//- (void)initAutoScaleSize{
//    int kScreenHeight = getHeight;
//    int kScreenWith = getWidth;
//    
//    if (kScreenHeight == 480) {
//        //4s
//        _autoSizeScaleW = kScreenWith / 375.f;
//        _autoSizeScaleH = kScreenHeight / 667.f;
//    }else if (kScreenHeight == 568) {
//        //5
//        _autoSizeScaleW = kScreenWith / 375.f;
//        _autoSizeScaleH = kScreenHeight / 667.f;
//    }else if (kScreenHeight == 667){
//        //6 以6为原型
//        _autoSizeScaleW = kScreenWith / 375.f;
//        _autoSizeScaleH = kScreenHeight / 667.f;
//    }else if(kScreenHeight == 736){
//        //6p
//        _autoSizeScaleW = kScreenWith / 375.f;
//        _autoSizeScaleH = kScreenHeight/ 667.f;
//    }else{
//        _autoSizeScaleW = 1;
//        _autoSizeScaleH = 1;
//    }
//    
//}

@end
