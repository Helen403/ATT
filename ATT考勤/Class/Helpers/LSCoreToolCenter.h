//
//  LSCoreToolCenter.h
//  LSCoreFramework
//
//  Created by 王隆帅 on 15/5/14.
//  Copyright (c) 2015年 王隆帅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface LSCoreToolCenter : NSObject

extern void ShowSuccessStatus(NSString *statues);
extern void ShowErrorStatus(NSString *statues);
extern void ShowMaskStatus(NSString *statues);
extern void ShowMessage(NSString *statues);
extern void ShowProgress(CGFloat progress);
extern void DismissHud(void);


//插入数据库
+(void)insertSQLByStringKey:(NSString *)key Value:(NSString *)value;
//查询数据库
+(NSString *)querySQLByStringKey:(NSString *)key;
//删除数据库
+(void)deleteTable;


//计算文字的宽和高
+(CGSize) getSizeWithText:(NSString *)text fontSize:(CGFloat)fontSize;
@end
