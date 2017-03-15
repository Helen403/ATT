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

@interface AppDelegate ()

@property (nonatomic,strong) XCFNavigationController *nav;

@property (nonatomic, strong) RACCommand *loginclickCommand;

@property(nonatomic,strong) NSString *telphone;

@property(nonatomic,assign) Boolean flag;

@property (nonatomic, strong) RACCommand *loginCommand;

@end

@implementation AppDelegate

#pragma mark system
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self h_initialize];
    NSString *telphone = [[NSUserDefaults standardUserDefaults] objectForKey:@"myUser"];
    if (telphone.length>0) {
        self.telphone = telphone;
        [self.loginclickCommand execute:nil];
    }
    
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
    
    NSString *telphone = [[NSUserDefaults standardUserDefaults] objectForKey:@"myUser"];
    
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    NSString *companyNickName =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyNickName"];
    
    if (telphone.length>0&&companyCode.length>0&&companyNickName.length>0) {
        if (self.flag) {
            [self rootController];
        }else{
            self.telphone = telphone;
            [self.loginCommand execute:nil];
        }
        
    }else{
        [self CannotController];
        
    }
    
}

#pragma mark private
-(void)h_initialize{
    
    [self.loginclickCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        //        DismissHud();
        
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            self.flag = NO;
            return ;
        }
        
        if (result.length<200) {
            self.flag = NO;
        }else{
            
            NSDictionary *xmlDoc = [LSCoreToolCenter getFilter:result filter:@"User"];
            
            UserModel *model = [UserModel mj_objectWithKeyValues:xmlDoc];
            
            //存储对象
            saveModel(model, @"user");
            [[NSUserDefaults standardUserDefaults] setObject:model.userCode forKey:@"createUserCode"];
            self.flag = YES;
        }
        
        
    }];
    
    
    [[[self.loginclickCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            // ShowMaskStatus(@"正在拼命加载");
        }
    }];
    
    
    [self.loginCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            [self CannotController];
            return ;
        }
        
        if (result.length<200) {
            [self CannotController];
        }else{
            
            NSDictionary *xmlDoc = [LSCoreToolCenter getFilter:result filter:@"User"];
            
            UserModel *model = [UserModel mj_objectWithKeyValues:xmlDoc];
            
            //存储对象
            saveModel(model, @"user");
            [[NSUserDefaults standardUserDefaults] setObject:model.userCode forKey:@"createUserCode"];
            [self rootController];
        }
        
        
    }];
    
    
    [[[self.loginCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            // ShowMaskStatus(@"正在拼命加载");
        }
    }];
    
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

#pragma mark lazyload
-(RACCommand *)loginclickCommand{
    if (!_loginclickCommand) {
        
        _loginclickCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                NSString *body =[NSString stringWithFormat: @"<findUserByTelphone xmlns=\"http://service.webservice.vada.com/\">\
                                 <telphone xmlns=\"\">%@</telphone>\
                                 </findUserByTelphone>",self.telphone];
                
                [LSCoreToolCenter SOAPData:findUserByTelphone soapBody:body success:^(NSString *result) {
                    
                    [subscriber sendNext:result];
                    [subscriber sendCompleted];
                } failure:^(NSError *error) {
                    DismissHud();
                    //                    ShowErrorStatus(@"请检查网络状态");
                    [subscriber sendNext:@"netFail"];
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
        
    }
    return _loginclickCommand;
}


-(RACCommand *)loginCommand{
    if (!_loginCommand) {
        
        _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                NSString *body =[NSString stringWithFormat: @"<findUserByTelphone xmlns=\"http://service.webservice.vada.com/\">\
                                 <telphone xmlns=\"\">%@</telphone>\
                                 </findUserByTelphone>",self.telphone];
                
                [LSCoreToolCenter SOAPData:findUserByTelphone soapBody:body success:^(NSString *result) {
                    
                    [subscriber sendNext:result];
                    [subscriber sendCompleted];
                } failure:^(NSError *error) {
                    DismissHud();
                    ShowErrorStatus(@"请检查网络状态");
                    [subscriber sendNext:@"netFail"];
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
        
    }
    return _loginCommand;
}

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}



@end
