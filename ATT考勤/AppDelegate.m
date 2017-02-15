//
//  AppDelegate.m
//  ATT考勤
//
//  Created by Helen on 16/12/15.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "AppDelegate.h"
#import "StartApp.h"
#import "ThirdPartService.h"
#import "ZJLeadingPageController.h"
#import "ZJLaunchAdController.h"
/**********************************************/
#import "XCFNavigationController.h"
#import "LoginViewController.h"

@interface AppDelegate ()

@property (nonatomic,strong) XCFNavigationController *nav;

@end

@implementation AppDelegate

#pragma mark system
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
   
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstStart"];
        
        // 如果是第一次安装打开App --- 显示引导页面
        ZJLeadingPageController *leadController = [[ZJLeadingPageController alloc] initWithPagesCount:5 setupCellHandler:^(ZJLeadingPageCell *cell, NSIndexPath *indexPath) {
            
            // 设置图片
            NSString *imageName = [NSString stringWithFormat:@"splash%ld",indexPath.row+1];
            cell.imageView.image = [UIImage imageNamed:imageName];
            
            // 设置按钮属性
            [cell.finishBtn setTitle:@"立即体验" forState:UIControlStateNormal];
            [cell.finishBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            
        } finishHandler:^(UIButton *finishBtn) {
 
            self.window.rootViewController = self.nav;
            
        }];
        // 自定义属性
        leadController.pageControl.pageIndicatorTintColor = [UIColor yellowColor];
        leadController.pageControl.currentPageIndicatorTintColor = [UIColor purpleColor];
        
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.window.backgroundColor = white_color;
        [self.window makeKeyAndVisible];
        self.window.rootViewController = leadController;
        
        
    }else{
      
        
        //    NSString *adImageURLString = @"这是启动广告图片的URL";
        //    NSString *adURLString = @"这是点击广告图片后的广告URL";
        
        WS(weakSelf);
        ZJLaunchAdController *launchVc = [[ZJLaunchAdController alloc] initWithLaunchImage:nil setAdImageHandler:^(UIImageView *imageView) {
            // 这里可以直接使用SDWebimage等来请求服务器提供的广告图片(SDWebimage会处理好gif图片的显示)
            // 不过你需要注意选择SDWebimage的缓存策略
            imageView.image = [UIImage imageNamed:@"splash1"];
            
        } finishHandler:^(ZJLaunchAdCallbackType callbackType) {
            switch (callbackType) {
                    // 点击了广告, 展示相应的广告即可
                case ZJLaunchAdCallbackTypeClickAd:
                    [weakSelf setRoot];
                    
                    break;
                    //  展示广告图片结束, 可以进入App
                case ZJLaunchAdCallbackTypeShowFinish:
                   [weakSelf setRoot];
                    break;
                    
                    // 点击了跳过广告, 可以进入App
                case ZJLaunchAdCallbackTypeClickSkipBtn:
                    [weakSelf setRoot];
                    
                    
                    break;
            }
        }];
        
        launchVc.countDownTime = 3.f;
        // 自定义广告图片的frame
        //    launchVc.adImageViewFrame = [UIScreen mainScreen].bounds;
        [launchVc setSkipBtnHandler:^(UIButton *skipBtn, NSInteger currentTime) {
            [skipBtn setTitle:[NSString stringWithFormat:@"%lds 跳过", (long)currentTime] forState:UIControlStateNormal];
        }];
        
        
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.window.backgroundColor = [UIColor whiteColor];
        [self.window makeKeyAndVisible];
        self.window.rootViewController = launchVc;
        
    }

    return YES;
}

-(void)setRoot{
    for (UIView *v in self.window.subviews) {
        [v removeFromSuperview];
    }
    
    self.window.rootViewController = self.nav;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {
  
}

#pragma mark lazyload
-(XCFNavigationController *)nav{
    if (!_nav) {
        _nav = [[XCFNavigationController alloc] init];
        [_nav addChildViewController:[[LoginViewController alloc] init]];
    }
    return _nav;
    
}


@end
