/**
 Copyright (c) 2016-present, yxiang.
 All rights reserved.
 Description: 用于NSTimer的操作
 https://github.com/yxiangBeauty/Project.git
 */

#import "NSTimer+YXAdd.h"

@implementation NSTimer (YXAdd)

#pragma mark - Block封装

+ (void)timerRun:(NSTimer *)timer
{
    YXTimerBlock aBlcok = [timer userInfo];
    if (aBlcok) {
        aBlcok(timer);
    }
}

+ (NSTimer *)scheduledWithTimeInterval:(NSTimeInterval)seconds repeats:(BOOL)repeats block:(YXTimerBlock)aBlock
{
     return [NSTimer scheduledTimerWithTimeInterval:seconds target:self selector:@selector(timerRun:) userInfo:[aBlock copy] repeats:repeats];
}

+ (NSTimer *)timerTimeInterval:(NSTimeInterval)seconds repeats:(BOOL)repeats block:(YXTimerBlock)aBlock
{
    NSTimer *timer = [NSTimer timerWithTimeInterval:seconds target:self selector:@selector(timerRun:) userInfo:[aBlock copy] repeats:repeats];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    return timer;
}

@end
