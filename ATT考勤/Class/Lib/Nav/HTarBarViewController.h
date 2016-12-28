//
//  HelenTarBarViewController.h
//  优积分
//
//  Created by Helen on 16/9/29.
//  Copyright © 2016年 Helen. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "HButtonView.h"


@interface HTarBarViewController : UITabBarController

//下面导航栏
@property(strong,nonatomic) UIView * TarBarView;
//对应的按钮
@property(strong,nonatomic) HButtonView * button1;
@property(strong,nonatomic) HButtonView * button2;
@property(strong,nonatomic) HButtonView * button3;
@property(strong,nonatomic) HButtonView * button4;
@property(strong,nonatomic) HButtonView * button5;

//当前被选中的按钮
@property(strong,nonatomic) HButtonView * Selectbutton;

//对应的控制器集合
@property(strong,nonatomic) NSMutableArray *controllers;


@end
