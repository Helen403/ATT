//
//  LocalNotificationManager.m
//  ATT考勤
//
//  Created by Helen on 17/4/1.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "LocalNotificationManager.h"

#define KEY_NOTIFICATION @"this is a key for notification"

@implementation LocalNotificationManager

+ (BOOL)insertLocalNotificationToSystemQueueWithNotificationID:(NSString *)notificationID{
    
    //新增前先清楚已注册的相同ID的本地推送
    [self deleteLocadNotificationWithNotificationID:notificationID];
    
    //初始化
    UILocalNotification * localNotification = [[UILocalNotification alloc] init];
    
    //设置开火时间(演示为当前时间5秒后)
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    
    //设置时区，取手机系统默认时区
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    
    //重复次数 kCFCalendarUnitEra为不重复
    localNotification.repeatInterval = kCFCalendarUnitEra;
    
    localNotification.alertLaunchImage = @"Icon";
    //通知的主要内容
    localNotification.alertBody = @"ATT考勤提醒你,已到打卡时间";
    
    //小提示
    localNotification.alertAction = @"查看详情";
    
    //设置音效，系统默认为电子音，在系统音效中标号为1015
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    
    //or localNotification.soundName = @"send.caf" 自己的音频文件
    
    //localNotification.applicationIconBadgeNumber = 1; Icon上的红点和数字
    
    //查找本地系统通知的标识
    localNotification.userInfo = @{KEY_NOTIFICATION: notificationID};
    
    //提交到系统服务中，系统限制一个APP只能注册64条通知，已经提醒过的通知可以清除掉
    /**
     *64条是重点，必需mark一下
     */
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    return YES;
}


#pragma mark - 查询符合条件的本地推送
+ (UILocalNotification *)queryNotificationWithNotificatioID:(NSString *)notificatioID{
    
    NSArray * notifications = [self queryAllSystemNotifications];
    __block UILocalNotification * localnotification = nil;
    
    if (notifications.count > 0) {
        [notifications enumerateObjectsUsingBlock:^(UILocalNotification  * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //查找符合条件的本地推送
            if ([obj.userInfo[KEY_NOTIFICATION] isEqualToString:notificatioID]) {
                localnotification = obj;
                *stop = YES;
            }
        }];
    }
    return localnotification;
}

#pragma mark - 查询所有已注册的本地推送

+ (NSArray *)queryAllSystemNotifications{
    return [[UIApplication sharedApplication] scheduledLocalNotifications];
}

+ (void)cleanFiretimeIsPastNofications:(NSArray *)notifications{
    
    [notifications enumerateObjectsUsingBlock:^(UILocalNotification * notification, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self compareFiretime:notification needRemove:^(UILocalNotification *item) {
            /**
             *如果设置了重复的周期，这时候打印notificaion，会有个Next fire time字样
             */
            //销毁通知
            [[UIApplication sharedApplication] cancelLocalNotification:item];
            
        }];
        
    }];
}

#pragma mark - 对比，是否过期
+ (void)compareFiretime:(UILocalNotification *)notification needRemove:(void(^)(UILocalNotification * item))needRemove{
    
    NSComparisonResult result = [notification.fireDate compare:[NSDate date]];
    
    if (result == NSOrderedAscending) {
        needRemove(notification);
    }
    
}

#pragma mark - 注销一条本地推送(用于更新同一个ID的推送)
+ (void)deleteLocadNotificationWithNotificationID:(NSString *)notificationID{
    
    UILocalNotification * notification = [self queryNotificationWithNotificatioID:notificationID];
    
    if (notification) {
        [[UIApplication sharedApplication] cancelLocalNotification:notification];
    }
    
}
@end
