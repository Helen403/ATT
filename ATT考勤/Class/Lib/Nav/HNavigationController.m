//
//  HMNavigationController.m
//  黑马微博
//
//  Created by apple on 14-7-3.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HNavigationController.h"


//返回按钮的大小
#define backSize 22

//设置返回的图片
#define backImg @"ic_schedule_menu_back"


@implementation HNavigationController

/**
 *  能拦截所有push进来的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{

    if (self.viewControllers.count > 0) { // 如果现在push的不是栈底控制器(最先push进来的那个控制器)
       //跳转到新的界面就隐藏下面的导航栏
//        self.TarBarView.hidden = YES;
        
        CGFloat photoSize = autoScaleW(backSize);
       viewController.navigationItem.leftBarButtonItem =  [self itemWithImageName:backImg highImageName:backImg size:CGSizeMake(photoSize, photoSize) target:self action:@selector(back)];
    }
 
    [super pushViewController:viewController animated:animated];
}

-(UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName size:(CGSize)size target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    
    // 设置按钮的尺寸为背景图片的尺寸
    // 1. 用一个临时变量保存返回值。
    CGRect temp = button.frame;
    
    // 2. 给这个变量赋值。因为变量都是L-Value，可以被赋值
    temp.size = size;
    
    // 3. 修改frame的值
    button.frame = temp;
    
    // 监听按钮点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
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
