//
//  UtilKits.h
//  DashunClient
//
//  Created by lottak_mac2 on 16/9/27.
//  Copyright © 2016年 com.lottak. All rights reserved.
//

#ifndef UtilKits_h
#define UtilKits_h


#define DBNAME @"HelenDb.sqlite"
#define TBNAME @"TableHelen"
#import "sqlite3.h"
#import "FMDatabase.h"

#import <MJExtension/MJExtension.h>//JSON 对象转换工具 通用
#import <AFNetworking/AFNetworking.h>//网络请求库
#import <MJRefresh/MJRefresh.h>//上啦刷新，下拉加载
#import <SDWebImage/UIImageView+WebCache.h>//图片下载缓存库


#import "NSObject+Tips.h"//消息提示框
#import "NSString+StringSize.h"//字符串高度/长度计算
#import "NSDate+Format.h"//时间分类
#import "NSObject+data.h"//运行时添加data属性
#import "NSString+isBlank.h"//字符串是否为空
#import "UIImage+scale.h"//图片压缩
#import "UIColor+FlatUI.h"//颜色分类 应用中的主要颜色
#import "NSString+firstChar.h"//字符串首字母，用于索引



#import <Reachability/Reachability.h>
#import <SDWebImage/UIButton+WebCache.h>
#import <SVProgressHUD/SVProgressHUD.h>
#define MAS_SHORTHAND_GLOBALS
#import <Masonry/Masonry.h>
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "JKCategories.h"



#endif /* UtilKits_h */
