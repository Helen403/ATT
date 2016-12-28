//
//  HelenTarBarViewController.m
//  优积分
//
//  Created by Helen on 16/9/29.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "HTarBarViewController.h"
#import "HelenNavigationController.h"
/*******************************************/
#import "IntegralViewController.h"
#import "ShoppingCartViewController.h"
#import "MineViewController.h"
#import "MyCardViewController.h"
#import "HomeViewController.h"


//设置字体的大小
#define textSize 12
//设置下面导航栏的高度
#define TarBarHeight 49
//导航栏的颜色
#define TarBarBackgroundColor RGBCOLOR(0, 0, 0)





@implementation HTarBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //移除TabBarController自带的下部的条
    [self.tabBar removeFromSuperview];
    
    //创建底部五个按钮
    [self addTarBarView];
    
    //给五个按钮设置对应的图片和文字
    [self setTarBarAttribute];
    
    //给五个按钮添加对应的点击事件;
    [self setOnClick];
}

-(void)addTarBarView{
    
    int W = self.view.frame.size.width;
    int H = self.view.frame.size.height;
    
    //底部view
    int TarBarViewX = 0;
    int TarBarViewH = TarBarHeight;
    int TarBarViewY = H-TarBarViewH;
    int TarBarViewW = W;
    
    
    _TarBarView = [[UIView alloc] initWithFrame:CGRectMake(TarBarViewX, TarBarViewY, TarBarViewW, TarBarViewH)];
    //设置背景颜色 为白色
    _TarBarView.backgroundColor = TarBarBackgroundColor;
    
    [self.view addSubview:_TarBarView];
    
    
    
    //添加按钮1
    int button1X = 0;
    int button1Y = 0;
    int button1W = TarBarViewW/5;
    int button1H = TarBarViewH;
    _button1 = [[HButtonView alloc] initWithFrame:CGRectMake(button1X, button1Y, button1W, button1H)];
    
    [_TarBarView addSubview:_button1];
    
    //添加按钮2
    int button2X = button1W;
    int button2Y = 0;
    int button2W = TarBarViewW/5;
    int button2H = TarBarViewH;
    _button2 = [[HButtonView alloc] initWithFrame:CGRectMake(button2X, button2Y, button2W, button2H)];
    
    [_TarBarView addSubview:_button2];
    //添加按钮3
    int button3X = button1W*2;
    int button3Y = 0;
    int button3W = TarBarViewW/5;
    int button3H = TarBarViewH;
    _button3 = [[HButtonView alloc] initWithFrame:CGRectMake(button3X, button3Y, button3W, button3H)];
    
    
    [_TarBarView addSubview:_button3];
    //添加按钮4
    int button4X = button1W*3;
    int button4Y = 0;
    int button4W = TarBarViewW/5;
    int button4H = TarBarViewH;
    _button4 = [[HButtonView alloc] initWithFrame:CGRectMake(button4X, button4Y, button4W, button4H)];
    
    [_TarBarView addSubview:_button4];
    //添加按钮5
    int button5X = button1W*4;
    int button5Y = 0;
    int button5W = TarBarViewW/5;
    int button5H = TarBarViewH;
    _button5 = [[HButtonView alloc] initWithFrame:CGRectMake(button5X, button5Y, button5W, button5H)];
    
    [_TarBarView addSubview:_button5];
}

-(void)setTarBarAttribute{
    
    //设置文字内容
    [_button1 setTitle:@"申请" forState:UIControlStateNormal];
    [_button2 setTitle:@"考勤" forState:UIControlStateNormal];
    [_button3 setTitle:@"通讯录" forState:UIControlStateNormal];
    [_button4 setTitle:@"统计" forState:UIControlStateNormal];
    [_button5 setTitle:@"信息" forState:UIControlStateNormal];
    //设置文字的大小
    _button1.titleLabel.font = [UIFont systemFontOfSize:textSize];
    _button2.titleLabel.font = [UIFont systemFontOfSize:textSize];
    _button3.titleLabel.font = [UIFont systemFontOfSize:textSize];
    _button4.titleLabel.font = [UIFont systemFontOfSize:textSize];
    _button5.titleLabel.font = [UIFont systemFontOfSize:textSize];
    //设置title的字体居中
    _button1.titleLabel.textAlignment = NSTextAlignmentCenter;
    _button2.titleLabel.textAlignment = NSTextAlignmentCenter;
    _button3.titleLabel.textAlignment = NSTextAlignmentCenter;
    _button4.titleLabel.textAlignment = NSTextAlignmentCenter;
    _button5.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    //设置正常状态的颜色
    [_button1 setTitleColor:[HelenUtils colorRed:255 Green:255 Blue:255] forState:UIControlStateNormal];
    [_button2 setTitleColor:[HelenUtils colorRed:255 Green:255 Blue:255] forState:UIControlStateNormal];
    [_button3 setTitleColor:[HelenUtils colorRed:255 Green:255 Blue:255] forState:UIControlStateNormal];
    [_button4 setTitleColor:[HelenUtils colorRed:255 Green:255 Blue:255] forState:UIControlStateNormal];
    [_button5 setTitleColor:[HelenUtils colorRed:255 Green:255 Blue:255] forState:UIControlStateNormal];
    
    //设置点击状态的颜色
    [_button1 setTitleColor:[HelenUtils colorRed:35 Green:35 Blue:35] forState:UIControlStateSelected];
    [_button2 setTitleColor:[HelenUtils colorRed:35 Green:35 Blue:35] forState:UIControlStateSelected];
    [_button3 setTitleColor:[HelenUtils colorRed:35 Green:35 Blue:35] forState:UIControlStateSelected];
    [_button4 setTitleColor:[HelenUtils colorRed:35 Green:35 Blue:35] forState:UIControlStateSelected];
    [_button5 setTitleColor:[HelenUtils colorRed:35 Green:35 Blue:35] forState:UIControlStateSelected];
    
    //设置正常状态的图片
    [_button1 setImage:[UIImage imageNamed:@"homepage_apply_button_white"] forState:UIControlStateNormal];
    [_button2 setImage:[UIImage imageNamed:@"homepage_attendance_button_white"] forState:UIControlStateNormal];
    [_button3 setImage:[UIImage imageNamed:@"homepage_record_button_white"] forState:UIControlStateNormal];
    [_button4 setImage:[UIImage imageNamed:@"homepage_statistics_button_white"] forState:UIControlStateNormal];
    [_button5 setImage:[UIImage imageNamed:@"homepage_information_button_white"] forState:UIControlStateNormal];
    
    //设置被点击状态的图片
    [_button1 setImage:[UIImage imageNamed:@"homepage_apply_button_gray"] forState:UIControlStateSelected];
    [_button2 setImage:[UIImage imageNamed:@"homepage_attendance_button_gray"] forState:UIControlStateSelected];
    [_button3 setImage:[UIImage imageNamed:@"homepage_record_button_gray"] forState:UIControlStateSelected];
    [_button4 setImage:[UIImage imageNamed:@"homepage_statistics_button_gray"] forState:UIControlStateSelected];
    [_button5 setImage:[UIImage imageNamed:@"homepage_information_button_gray"] forState:UIControlStateSelected];
    
    //设置button的内容横向居中
    _button1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    _button2.contentHorizontalAlignment =UIControlContentHorizontalAlignmentCenter;
    _button3.contentHorizontalAlignment =UIControlContentHorizontalAlignmentCenter;
    _button4.contentHorizontalAlignment =UIControlContentHorizontalAlignmentCenter;
    _button5.contentHorizontalAlignment =UIControlContentHorizontalAlignmentCenter;
    
    
}

//添加对应的点击事件
-(void)setOnClick{
    [_button1 addTarget:self action:@selector(OnClickButton:) forControlEvents:UIControlEventTouchUpInside];
    [_button2 addTarget:self action:@selector(OnClickButton:) forControlEvents:UIControlEventTouchUpInside];
    [_button3 addTarget:self action:@selector(OnClickButton:) forControlEvents:UIControlEventTouchUpInside];
    [_button4 addTarget:self action:@selector(OnClickButton:) forControlEvents:UIControlEventTouchUpInside];
    [_button5 addTarget:self action:@selector(OnClickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //设置对应的tag
    [_button1 setTag:0];
    [_button2 setTag:1];
    [_button3 setTag:2];
    [_button4 setTag:3];
    [_button5 setTag:4];
    
    //添加对应的自控制器
    [self addAllChildVcs];
    
    //默认第一个按钮被点击
    [self.button1 setSelected:YES];
    
    
    [self OnClickButton:self.button1];
}

-(void)OnClickButton:(HButtonView *)button{
    
    if (button == self.Selectbutton) {
        return;
    }
    
    //被点击按钮设置为被选中状态
    [button setSelected:YES];
    //上一个按钮设置为正常状态
    [self.Selectbutton setSelected:NO];
    self.Selectbutton = button;
    
    self.selectedIndex = button.tag;
}



/**
 *  添加所有的子控制器
 */
- (void)addAllChildVcs
{
    HomeViewController *near = [[HomeViewController alloc] init];
    [self addOneChlildVc:near title:@"首页"];
    
    IntegralViewController *integral = [[IntegralViewController alloc] init];
    [self addOneChlildVc:integral title:@"考勤"];
    
    MyCardViewController *myCard = [[MyCardViewController alloc] init];
    [self addOneChlildVc:myCard title:@"通讯录"];
    
    ShoppingCartViewController *shoppingCart = [[ShoppingCartViewController alloc] init];
    [self addOneChlildVc:shoppingCart title:@"统计"];
    
    MineViewController *mine = [[MineViewController alloc] init];
    [self addOneChlildVc:mine title:@"信息"];
    //让系统的控制器数组指向自己的数组
    self.viewControllers = self.controllers;
    
}

/**
 *  添加一个子控制器
 *
 *  @param childVc           子控制器对象
 */
- (void)addOneChlildVc:(UIViewController *)childVc title:(NSString *)title
{
    // 设置标题
    childVc.title = title;
    
    // 添加为tabbar控制器的子控制器
    HelenNavigationController *nav = [[HelenNavigationController alloc] initWithRootViewController:childVc];
    nav.TarBarView = self.TarBarView;
    
    [self.controllers addObject:nav];
}

//懒加载
-(NSMutableArray *)controllers{
    if (_controllers==nil) {
        _controllers = [NSMutableArray array];
    }
    return _controllers;
}

@end
