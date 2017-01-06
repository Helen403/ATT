//
//  UtilsMacro.h
//  PhoneSearch
//
//  Created by 王隆帅 on 15/5/20.
//  Copyright (c) 2015年 王隆帅. All rights reserved.
//

/**
 *  本类放一些方便使用的宏定义
 */

// ios7之上的系统
#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0 ? YES : NO)

// 获取屏幕 宽度、高度 bounds就是屏幕的全部区域
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define IS_IPHONE4 [UIScreen mainScreen].bounds.size.height == 480

// 获取当前屏幕的高度 applicationFrame就是app显示的区域，不包含状态栏
#define kMainScreenHeight ([UIScreen mainScreen].applicationFrame.size.height)
#define kMainScreenWidth  ([UIScreen mainScreen].applicationFrame.size.width)

// 判断字段时候为空的情况
#define IF_NULL_TO_STRING(x) ([(x) isEqual:[NSNull null]]||(x)==nil)? @"":TEXT_STRING(x)
// 转换为字符串
#define TEXT_STRING(x) [NSString stringWithFormat:@"%@",x]

// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// 设置颜色RGB
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

//定义UIImage对象
//#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]
#define ImageNamed(name) [UIImage imageNamed:name]

// 每次请求列表 数据量
#define LS_REQUEST_LIST_COUNT @"10"
#define LS_REQUEST_LIST_NUM_COUNT 10

// 个人信息
#define IS_LOGIN (((NSString *)SEEKPLISTTHING(USER_ID)).length > 0)

#define YC_USER_ID IF_NULL_TO_STRING(((NSString *)SEEKPLISTTHING(USER_ID)))
#define YC_USER_PHONE IF_NULL_TO_STRING(((NSString *)SEEKPLISTTHING(USER_PHONE)))
#define YC_USER_EASEMOB_NAME IF_NULL_TO_STRING(((NSString *)SEEKPLISTTHING(USER_EASEMOB_NAME)))

#define MAINCOLOR UIColorFromRGB(0x21C1F7)

#define SUBCOLOR UIColorFromRGB(0xFF4C4C)

#define GX_BGCOLOR COLOR(234, 234, 234, 1)

#define MAIN_TEXT_COLOR COLOR(109, 109, 109, 1)

#define MAIN_LINE_COLOR COLOR(135, 135, 135, 1)

#define MAIN_LIGHT_LINE_COLOR COLOR(174, 174, 174, 1)

#define MAIN_BLACK_TEXT_COLOR COLOR(38, 38, 38, 1)

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//不同设备的屏幕比例 以6为原型
#define SizeScaleH SCREEN_HEIGHT/667.f
#define SizeScaleW SCREEN_WIDTH/375.f

//以iphone6为主自动适配宽
#define autoScaleW(width) width*SizeScaleW;
//以iphone6为主自动适配高
#define autoScaleH(height) width*SizeScaleH;

//插入数据库
#define insert(key,value) [LSCoreToolCenter insertSQLByStringKey:key Value:value]
//查询数据库
#define query(key) [LSCoreToolCenter querySQLByStringKey:key]
//删除数据库
#define delete [LSCoreToolCenter deleteTable]


#define MAIN_GRAY RGBCOLOR(110, 111, 114)

#define MAIN_ORANGER RGBCOLOR(242, 130, 74)


#define MAIN_PAN RGBCOLOR(188, 188, 188)

#define BG_COLOR RGBCOLOR(240,240,240)

#define LINE_COLOR RGBCOLOR(206,206,206)

#define MAIN_PAN_2 RGBCOLOR(29, 29, 29)




#define XCFGlobalBackgroundColor RGB(245, 240, 215)     // 背景颜色
#define XCFLabelColorWhite RGB(255, 255, 255)           // 字体颜色：白色
#define XCFLabelColorGray [UIColor grayColor]           // 字体颜色：灰色
#define XCFCoverViewColor RGBA(0, 0, 0, 0.2)            // 黑色半透明遮盖
#define XCFTabBarNormalColor RGBCOLOR(170, 170, 170)         // TabBar颜色
#define XCFThemeColor RGBCOLOR(242, 130, 74)        // TabBar选中颜色
#define XCFSearchBarTintColor RGB(192, 192, 192)        // 搜索按钮背景色
#define XCFDishViewBackgroundColor RGB(235, 235, 226)   // 作品view背景色
#define XCFAddressCellColor RGB(215, 228, 225)          // 收货地址选中颜色
