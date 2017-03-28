//
//  YYAudioTool.h
//  ATT考勤
//
//  Created by Helen on 17/2/24.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface YYAudioTool : NSObject

/**
 *播放音乐文件
 */
+(BOOL)playMusic:(NSString *)filename;
/**
 *暂停播放
 */
+(void)pauseMusic:(NSString *)filename;
/**
 *播放音乐文件
 */
+(void)stopMusic:(NSString *)filename;

/**
 *播放音效文件
 */
+(void)playSound:(NSString *)filename;
/**
 *销毁音效
 */
+(void)disposeSound:(NSString *)filename;

@end
