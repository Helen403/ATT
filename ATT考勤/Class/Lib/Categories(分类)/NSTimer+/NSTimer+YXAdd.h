/**
 Copyright (c) 2016-present, yxiang.
 All rights reserved.
 Description: 用于NSTimer的操作
 https://github.com/yxiangBeauty/Project.git
 */

#import <Foundation/Foundation.h>

@interface NSTimer (YXAdd)

#pragma mark - Block封装

/**
 timer的执行回调
 */
typedef void (^YXTimerBlock)(NSTimer *timer);

/**
 初始化timer
 参考资料：http://blog.csdn.net/davidsph/article/details/7899731

 @param seconds 时间间隔
 @param repeats 是否重复
 @param aBlock  执行回调
 */
+ (NSTimer *)scheduledWithTimeInterval:(NSTimeInterval)seconds repeats:(BOOL)repeats block:(YXTimerBlock)aBlock;

/*
 默认加在NSRunLoopCommonModes的RunLoop中，自行启动。
 */
+ (NSTimer *)timerTimeInterval:(NSTimeInterval)seconds repeats:(BOOL)repeats block:(YXTimerBlock)aBlock;

@end
