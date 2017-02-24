//
//  AppDelegate.h
//  ATT考勤
//
//  Created by Helen on 16/12/15.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件


@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>


@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) BMKMapManager *mapManager;




@end

