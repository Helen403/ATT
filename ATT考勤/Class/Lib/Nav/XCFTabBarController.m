//
//  XCFTabBarController.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/2.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFTabBarController.h"
#import "XCFNavigationController.h"


/*******************************************/
#import "HomeViewController.h"
#import "ApplyController.h"
#import "NewsController.h"
#import "StatisticsController.h"
#import "AddressListController.h"

//设置对应的文字
#define text_1 @"考勤"
#define text_2 @"申请"
#define text_3 @"通讯录"
#define text_4 @"统计"
#define text_5 @"信息"

//设置对应的图片
#define Img_1_normal @"homepage_attendance_button_gray"
#define Img_2_normal @"homepage_apply_button_gray"
#define Img_3_normal @"homepage_record_button_gray"
#define Img_4_normal @"homepage_statistics_button_gray"
#define Img_5_normal @"homepage_information_button_gray"

#define Img_1_press @"homepage_attendance_button_orange"
#define Img_2_press @"homepage_apply_button_orange"
#define Img_3_press @"homepage_record_button_orange"
#define Img_4_press @"homepage_statistics_button_orange"
#define Img_5_press @"homepage_information_button_orange"

#define controller_1 [[HomeViewController alloc] init]
#define controller_2 [[ApplyController alloc] init]
#define controller_3 [[AddressListController alloc] init]
#define controller_4 [[StatisticsController alloc] init]
#define controller_5 [[NewsController alloc] init]


@interface XCFTabBarController ()

@end

@implementation XCFTabBarController

+ (void)initialize {
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    normalAttrs[NSForegroundColorAttributeName] = XCFTabBarNormalColor;
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = normalAttrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = XCFThemeColor;
    
    UITabBarItem *appearance = [UITabBarItem appearance];
    [appearance setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [appearance setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [self setupChildViewController:controller_1
                             title:text_1
                             image:Img_1_normal
                     selectedImage:Img_1_press];
    [self setupChildViewController:controller_2
                             title:text_2
                             image:Img_2_normal
                     selectedImage:Img_2_press];
    [self setupChildViewController:controller_3
                             title:text_3
                             image:Img_3_normal
                     selectedImage:Img_3_press];
    [self setupChildViewController:controller_4
                             title:text_4
                             image:Img_4_normal
                     selectedImage:Img_4_press];
    [self setupChildViewController:controller_5
                             title:text_5
                             image:Img_5_normal
                     selectedImage:Img_5_press];
}

- (void)setupChildViewController:(UIViewController *)childController
                           title:(NSString *)title
                           image:(NSString *)image
                   selectedImage:(NSString *)selectedImage {
    childController.title = title;
    UIImage *img= ImageNamed(image);
    UIImage *imgSelect = ImageNamed(selectedImage);
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    imgSelect = [imgSelect imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [childController.tabBarItem setImage:img];
    [childController.tabBarItem setSelectedImage:imgSelect];
 
    XCFNavigationController *navCon = [[XCFNavigationController alloc] initWithRootViewController:childController];
    navCon.title = title;
    
    [self addChildViewController:navCon];
}


@end
