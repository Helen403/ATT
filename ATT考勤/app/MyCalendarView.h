//
//  MyCalendarView.h
//  ATT考勤
//
//  Created by Helen on 17/3/9.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HView.h"

@interface MyCalendarView : HView

@property (nonatomic, copy) void(^calendarBlock)(NSString *day);

@property(nonatomic,copy) void(^countBlock)(NSInteger count);

@end
