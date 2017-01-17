//
//  ThirdPartService.m
//  ATT考勤
//
//  Created by Helen on 16/12/16.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "ThirdPartService.h"
//#import "IQKeyboardManager.h"

@implementation ThirdPartService
+ (void)load {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        [[self class] initCoredata];
        
        [[self class] setKeyBord];
        
        [[self class] testReachableStaus];
        
    });
}

#pragma mark - 初始化coredata
+ (void)initCoredata {
       
}

#pragma mark - 键盘回收相关
+ (void)setKeyBord {
    
//    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
//    manager.enable = YES;
//    manager.shouldResignOnTouchOutside = YES;
//    manager.shouldToolbarUsesTextFieldTintColor = YES;
//    manager.enableAutoToolbar = YES;
}

#pragma mark － 检测网络相关
+ (void)testReachableStaus {
    
}
@end
