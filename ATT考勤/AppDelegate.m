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

#import "UserModel.h"
#import "XCFTabBarController.h"
#import "NavigationView.h"
//==============================================
#import "BPush.h"
#import <UserNotifications/UserNotifications.h>
static BOOL isBackGroundActivateApplication;


@interface AppDelegate ()

@property (nonatomic,strong) XCFNavigationController *nav;

@property(nonatomic,strong) NavigationView *navigationView;


@end

@implementation AppDelegate

#pragma mark system
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    

  
    
    /*****************************************************/
    //请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"b1jmW0hQukisNzasTZa6GuVaaTbD2iai"  generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    /*******************************************************/
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstStart"];
        
        // 如果是第一次安装打开App --- 显示引导页面
        ZJLeadingPageController *leadController = [[ZJLeadingPageController alloc] initWithPagesCount:5 setupCellHandler:^(ZJLeadingPageCell *cell, NSIndexPath *indexPath) {
            
            // 设置图片
            NSString *imageName = [NSString stringWithFormat:@"splash%ld",indexPath.row+1];
            cell.imageView.image = [UIImage imageNamed:imageName];
            
            // 设置按钮属性
            [cell.finishBtn setTitle:@"立即体验" forState:UIControlStateNormal];
            [cell.finishBtn setTitleColor:white_color forState:UIControlStateNormal];
            
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
            imageView.image =  [LSCoreToolCenter convertViewToImage:self.navigationView];
            
            
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
    

    
    // iOS10 下需要使用新的 API
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
        UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
        
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound + UNAuthorizationOptionBadge)
                              completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                  // Enable or disable features based on authorization.
                                  if (granted) {
                                      [application registerForRemoteNotifications];
                                  }
                              }];
#endif
    }
    else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType myTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }else {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
    
#warning 测试 开发环境 时需要修改BPushMode为BPushModeDevelopment 需要修改Apikey为自己的Apikey
    
    // 在 App 启动时注册百度云推送服务，需要提供 Apikey
    
    [BPush registerChannel:launchOptions apiKey:@"5YHrZSL9pmQZk3GwV50lO439" pushMode:BPushModeDevelopment withFirstAction:@"打开" withSecondAction:@"关闭" withCategory:@"test" useBehaviorTextInput:YES isDebug:YES];
    
    // 禁用地理位置推送 需要再绑定接口前调用。
    
    [BPush disableLbs];
    
    // App 是用户点击推送消息启动
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        [BPush handleNotification:userInfo];
    }
#if TARGET_IPHONE_SIMULATOR
    Byte dt[32] = {0xc6, 0x1e, 0x5a, 0x13, 0x2d, 0x04, 0x83, 0x82, 0x12, 0x4c, 0x26, 0xcd, 0x0c, 0x16, 0xf6, 0x7c, 0x74, 0x78, 0xb3, 0x5f, 0x6b, 0x37, 0x0a, 0x42, 0x4f, 0xe7, 0x97, 0xdc, 0x9f, 0x3a, 0x54, 0x10};
    [self application:application didRegisterForRemoteNotificationsWithDeviceToken:[NSData dataWithBytes:dt length:32]];
#endif
    //角标清0
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    /*
     // 测试本地通知
     [self performSelector:@selector(testLocalNotifi) withObject:nil afterDelay:1.0];
     */


    
    return YES;
}


- (void)testLocalNotifi
{
    NSLog(@"测试本地通知啦！！！");
    NSDate *fireDate = [[NSDate new] dateByAddingTimeInterval:5];
    [BPush localNotification:fireDate alertBody:@"这是本地通知" badge:3 withFirstAction:@"打开" withSecondAction:nil userInfo:nil soundName:nil region:nil regionTriggersOnce:YES category:nil useBehaviorTextInput:YES];
}



// 此方法是 用户点击了通知，应用在前台 或者开启后台并且应用在后台 时调起
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    completionHandler(UIBackgroundFetchResultNewData);
    // 打印到日志 textView 中
    NSLog(@"********** iOS7.0之后 background **********");
    // 应用在前台，不跳转页面，让用户选择。
    if (application.applicationState == UIApplicationStateActive) {
        NSLog(@"acitve ");
              UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"收到一条消息" message:userInfo[@"aps"][@"alert"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
               [alertView show];
    }
    //杀死状态下，直接跳转到跳转页面。
    if (application.applicationState == UIApplicationStateInactive && !isBackGroundActivateApplication)
    {
//        LoginViewController *skipCtr = [[LoginViewController alloc]init];
//        // 根视图是nav 用push 方式跳转
//        [_tabBarCtr.selectedViewController pushViewController:skipCtr animated:YES];
        NSLog(@"applacation is unactive ===== %@",userInfo);
        /*
         // 根视图是普通的viewctr 用present跳转
         [_tabBarCtr.selectedViewController presentViewController:skipCtr animated:YES completion:nil]; */
    }
    // 应用在后台。当后台设置aps字段里的 content-available 值为 1 并开启远程通知激活应用的选项
    if (application.applicationState == UIApplicationStateBackground) {
        NSLog(@"background is Activated Application ");
        // 此处可以选择激活应用提前下载邮件图片等内容。
        isBackGroundActivateApplication = YES;
        //        UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"收到一条消息" message:userInfo[@"aps"][@"alert"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        //        [alertView show];
    }
//    [self.viewController addLogString:[NSString stringWithFormat:@"Received Remote Notification :\n%@",userInfo]];
    
    NSLog(@"%@",userInfo);
}

// 在 iOS8 系统中，还需要添加这个方法。通过新的 API 注册推送服务
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    
    [application registerForRemoteNotifications];
    
    
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"test:%@",deviceToken);
    [BPush registerDeviceToken:deviceToken];
    [BPush bindChannelWithCompleteHandler:^(id result, NSError *error) {
//        [self.viewController addLogString:[NSString stringWithFormat:@"Method: %@\n%@",BPushRequestMethodBind,result]];
        // 需要在绑定成功后进行 settag listtag deletetag unbind 操作否则会失败
        
        // 网络错误
        if (error) {
            return ;
        }
        if (result) {
            // 确认绑定成功
            if ([result[@"error_code"]intValue]!=0) {
                return;
            }
            // 获取channel_id
            NSString *myChannel_id = [BPush getChannelId];
            NSLog(@"==%@",myChannel_id);
            
            [BPush listTagsWithCompleteHandler:^(id result, NSError *error) {
                if (result) {
                    NSLog(@"result ============== %@",result);
                }
            }];
            [BPush setTag:@"Mytag" withCompleteHandler:^(id result, NSError *error) {
                if (result) {
                    NSLog(@"设置tag成功");
                }
            }];
        }
    }];
    
    // 打印到日志 textView 中
//    [self.viewController addLogString:[NSString stringWithFormat:@"Register use deviceToken : %@",deviceToken]];
    
    
}

// 当 DeviceToken 获取失败时，系统会回调此方法
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"DeviceToken 获取失败，原因：%@",error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    // App 收到推送的通知
    [BPush handleNotification:userInfo];
    NSLog(@"********** ios7.0之前 **********");
    // 应用在前台 或者后台开启状态下，不跳转页面，让用户选择。
    if (application.applicationState == UIApplicationStateActive || application.applicationState == UIApplicationStateBackground) {
        NSLog(@"acitve or background");
        UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"收到一条消息" message:userInfo[@"aps"][@"alert"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
    else//杀死状态下，直接跳转到跳转页面。
    {
//        SkipViewController *skipCtr = [[SkipViewController alloc]init];
//        [_tabBarCtr.selectedViewController pushViewController:skipCtr animated:YES];
        [self setRoot];
    }
    
//    [self.viewController addLogString:[NSString stringWithFormat:@"Received Remote Notification :\n%@",userInfo]];
    
    NSLog(@"%@",userInfo);
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"接收本地通知啦！！！");
    [BPush showLocalNotificationAtFront:notification identifierKey:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self setRoot];
    }
}



-(void)setRoot{
    for (UIView *v in self.window.subviews) {
        [v removeFromSuperview];
    }
    
    NSString *telphone = [[NSUserDefaults standardUserDefaults] objectForKey:@"myUser"];
    
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    NSString *companyNickName =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyNickName"];
    NSString *userCodeNum =  [[NSUserDefaults standardUserDefaults] objectForKey:@"userCode"];
    NSString *RealName =  [[NSUserDefaults standardUserDefaults] objectForKey:@"userRealName"];
    if (telphone.length>0&&companyCode.length>0&&companyNickName.length>0&&userCodeNum.length>0 &&RealName.length>0) {
        UserModel *user = [[UserModel alloc] init];
        user.userCode = userCodeNum;
        user.userRealName = RealName;
        //存储对象
        saveModel(user, @"user");
        
        [self rootController];

    }else{
        [self CannotController];
        
    }
    
}



-(void)rootController{
    
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].keyWindow.rootViewController =[[XCFTabBarController alloc] init];
        });
    }else{
        [UIApplication sharedApplication].keyWindow.rootViewController =[[XCFTabBarController alloc] init];
    }
}

-(void)CannotController{
    
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.window.rootViewController = self.nav;
        });
    }else{
        self.window.rootViewController = self.nav;
    }
    
    
}

#pragma mark lazyload
-(XCFNavigationController *)nav{
    if (!_nav) {
        _nav = [[XCFNavigationController alloc] init];
        [_nav addChildViewController:[[LoginViewController alloc] init]];
    }
    return _nav;
}


- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        //        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        //        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {}
- (void)applicationDidEnterBackground:(UIApplication *)application {}
- (void)applicationWillEnterForeground:(UIApplication *)application {}
- (void)applicationDidBecomeActive:(UIApplication *)application {}
- (void)applicationWillTerminate:(UIApplication *)application {}



- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}


-(NavigationView *)navigationView{
    if (!_navigationView) {
        _navigationView = [[NavigationView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
    }
    return _navigationView;
}



@end
