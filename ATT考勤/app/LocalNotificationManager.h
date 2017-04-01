//
//  LocalNotificationManager.h
//  ATT考勤
//
//  Created by Helen on 17/4/1.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalNotificationManager : NSObject
+ (BOOL)insertLocalNotificationToSystemQueueWithNotificationID:(NSString *)notificationID;

+ (void)compareFiretime:(UILocalNotification *)notification needRemove:(void(^)(UILocalNotification * item))needRemove;
@end
