//
//  HMNavigationController.m
//  黑马微博
//
//  Created by apple on 14-7-3.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HNavigationController.h"

//中间标题文字的大小
#define titleFont 12
//返回按钮的大小
#define backSize 13


@implementation HNavigationController

/**
 *  当第一次使用这个类的时候调用1次
 */
+ (void)initialize
{

    // 设置UINavigationBarTheme的主
    [self setupNavigationBarTheme];

    // 设置UIBarButtonItem的主题
    [self setupBarButtonItemTheme];
}

/**
 *  设置UINavigationBarTheme的主题
 */
+ (void)setupNavigationBarTheme
{
    UINavigationBar *appearance = [UINavigationBar appearance];

    appearance.barTintColor = [UIColor whiteColor];
    
//    // 设置导航栏背景
//    if (!([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)) {
//        [appearance setBackgroundImage:[UIImage imageWithName:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
//    }
//    
//    // 设置文字属性
//    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
//    // UITextAttributeFont  --> NSFontAttributeName(iOS7)
//    CGFloat font = autoScaleW(titleFont);
//    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:font];
//    // UIOffsetZero是结构体, 只要包装成NSValue对象, 才能放进字典\数组中
//    textAttrs[NSShadowAttributeName] = [NSValue valueWithUIOffset:UIOffsetZero];
//    [appearance setTitleTextAttributes:textAttrs];
}

/**
 *  设置UIBarButtonItem的主题
 */
+ (void)setupBarButtonItemTheme
{
    // 通过appearance对象能修改整个项目中所有UIBarButtonItem的样式
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    
    /**设置文字属性**/
    // 设置普通状态的文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
//    CGFloat font = autoScaleW(titleFont);
//    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:font];
    textAttrs[NSShadowAttributeName] = [NSValue valueWithUIOffset:UIOffsetZero];
    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置高亮状态的文字属性
    NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    highTextAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    [appearance setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
    
    // 设置不可用状态(disable)的文字属性
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [appearance setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    
    /**设置背景**/
    // 技巧: 为了让某个按钮的背景消失, 可以设置一张完全透明的背景图片
    [appearance setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

/**
 *  能拦截所有push进来的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //设置push的背景为白色
//     viewController.view.backgroundColor = [UIColor whiteColor];
    if (self.viewControllers.count > 0) { // 如果现在push的不是栈底控制器(最先push进来的那个控制器)
       //跳转到新的界面就隐藏下面的导航栏
        self.TarBarView.hidden = YES;
        
//        CGFloat photoSize = autoScaleW(backSize);
//       viewController.navigationItem.leftBarButtonItem =  [HelenUtils itemWithImageName:@"icon_back" highImageName:@"icon_back" size:CGSizeMake(photoSize, photoSize) target:self action:@selector(back)];


    }
 
    [super pushViewController:viewController animated:animated];
}

- (void)back{
    // 这里用的是self, 因为self就是当前正在使用的导航控制器
    [self popViewControllerAnimated:YES];
    if (self.viewControllers.count == 1) {
            self.TarBarView.hidden = NO;
    }
}

- (void)more{
    [self popToRootViewControllerAnimated:YES];
    if (self.viewControllers.count == 1) {
        self.TarBarView.hidden = NO;
    }
}


//是否支持屏幕旋转
- (BOOL)shouldAutorotate {
    
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return [self.viewControllers.lastObject supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    
    return [self.viewControllers.lastObject preferredInterfaceOrientationForPresentation];
}

- (UIViewController *)childViewControllerForStatusBarStyle{
    
    return self.topViewController;
}
@end
